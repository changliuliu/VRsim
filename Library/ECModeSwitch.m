% This is the implementation of the finite state machine
%
% Changliu Liu
% 2016.9
% Modified 2016.10 for VR Simulator

switch TASK_PHASE
    
    case 0 % Get target position
        VISUALIZE = 0;
        % Exit condition
        if flag(7) > 0
            [prepPos,graspPos,liftPos,targetPos,putPos,returnPos,restPos,offset_prep,z_theta] = getTargetPos(t_adjusted(:,:,7),si,TG_list,LT_list);
            TASK_PHASE = 1;
            xref = sendEcCmd(prepPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,1);
            VISUALIZE = 1;
            nstep = size(xref,1)/6;
            waypoints = zeros(6,nstep);
            for i=1:nstep
                waypoints(:,i) = xref((i-1)*6+1:i*6);
            end
            WAYPOINT = 1;
        end
        
    case 1 % Go to prepPos
        VISUALIZE = 0;
        if max(abs(jpos-prepPos))>2
            
            % Update the target position and replan if moved
            if flag(7) && (norm(offset_prep(1:2)-offset_grasp_xy) > 20 || norm(z_theta_new-z_theta) > 15)
                z_theta = z_theta_new;
                offset_prep = [mean(t_adjusted(1,:,7));mean(t_adjusted(2,:,7));0.18-0.529]*1000;
                offset_grasp = [mean(t_adjusted(1,:,7));mean(t_adjusted(2,:,7));0.13-0.529]*1000;
                prepPos = fanucikine([offset_prep' -180 0 z_theta], si.ri{1}, [0 0 0 0 -90 0]);
                graspPos = fanucikine([offset_grasp' -180 0 z_theta], si.ri{1}, [0 0 0 0 -90 0]);
                xref = sendEcCmd(prepPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,1);
                VISUALIZE = 1;
                nstep = size(xref,1)/6;
                waypoints = zeros(6,nstep);
                for i=1:nstep
                    waypoints(:,i) = xref((i-1)*6+1:i*6);
                end
                WAYPOINT = 1;
            else
                % check if need to replan
                if flag_sc > MAX_SC
                    xref = sendEcCmd(prepPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,1);
                    VISUALIZE = 1;
                    nstep = size(xref,1)/6;
                    waypoints = zeros(6,nstep);
                    for i=1:nstep
                        waypoints(:,i) = xref((i-1)*6+1:i*6);
                    end
                    WAYPOINT = 1;
                    flag_sc = 0;
                else
                    % check way points
                    if max(abs(jpos-waypoints(:,WAYPOINT)')) > WAY_MARGIN + norm(jvel)/3
                        xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
                    else
                        WAYPOINT = min([WAYPOINT + 1,nstep]);
                        xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
                    end
                end
            end
        else
            disp('Start Grasping');
            desiredPos = graspPos;
            judp('send',26000,'192.168.1.80',typecast(desiredPos,'int8'));
            TASK_PHASE = 2;
            grasp_count = 0;
        end
    case 2 % Go to graspPos and grasp
        VISUALIZE = 0;
        if max(abs(jpos-graspPos)) < 2
            if grasp_count == 0
                wasStopped = tg_start_stop('start');
                gripper_action(ParamSgnID, 'DRIVE', cellstr(repmat('gccf', numel(1), 1)));
                tg_start_stop('stop', wasStopped);
            end
            grasp_count = grasp_count + 1;
        end
        if grasp_count > 0
            grasp_count = grasp_count + 1;
        end
        if grasp_count > 5
            xref = sendEcCmd(liftPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,1);
            VISUALIZE = 1;
            nstep = size(xref,1)/6;
            waypoints = zeros(6,nstep);
            for i=1:nstep
                waypoints(:,i) = xref((i-1)*6+1:i*6);
            end
            WAYPOINT = 1;
            flag_sc = 0;
            TASK_PHASE = 3;
        end
    case 3 % Go to liftPos
        VISUALIZE = 0;
        if max(abs(jpos-liftPos)) < 2 || flag_sc > MAX_SC
            TASK_PHASE = 4;
            xref = sendEcCmd(targetPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,1);
            VISUALIZE = 1;
            nstep = size(xref,1)/6;
            waypoints = zeros(6,nstep);
            for i=1:nstep
                waypoints(:,i) = xref((i-1)*6+1:i*6);
            end
            WAYPOINT = 1;
        else
            % check way points
            if max(abs(jpos-waypoints(:,WAYPOINT)')) > WAY_MARGIN + norm(jvel)/3
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,0);
            else
                WAYPOINT = min([WAYPOINT + 1,nstep]);
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,0);
            end
        end
    case 4 % Go to targetPos
        VISUALIZE = 0;
        if max(abs(jpos-targetPos)) > 1
            % check if need to replan
            if flag_sc > 10
                xref = sendEcCmd(targetPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,1);
                VISUALIZE = 1;
                nstep = size(xref,1)/6;
                waypoints = zeros(6,nstep);
                for i=1:nstep
                    waypoints(:,i) = xref((i-1)*6+1:i*6);
                end
                WAYPOINT = 1;
                flag_sc = 0;
            else
                if max(abs(jpos-waypoints(:,WAYPOINT)')) > WAY_MARGIN + norm(jvel)/3
                    xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,0);
                else
                    WAYPOINT = min([WAYPOINT + 1,nstep]);
                    xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,0);
                end
            end
        else
            disp('Go to putPos');
            xref = sendEcCmd(putPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,1,1);
            VISUALIZE = 1;
            nstep = size(xref,1)/6;
            waypoints = zeros(6,nstep);
            for i=1:nstep
                waypoints(:,i) = xref((i-1)*6+1:i*6);
            end
            WAYPOINT = 1;
            flag_sc = 0;
            TASK_PHASE = 5;
        end
    case 5 % Go to putPos and put
        VISUALIZE = 0;
        if max(abs(jpos-putPos)) < 2
            gripper_action(ParamSgnID, 'DRIVE', cellstr(repmat('fully open', numel(1), 1)));
            disp('Go to returnPos');
            judp('send',26000,'192.168.1.80',typecast(returnPos,'int8'));
            TASK_PHASE = 6;
        else
            if max(abs(jpos-waypoints(:,WAYPOINT)')) > WAY_MARGIN + norm(jvel)/3
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
            else
                WAYPOINT = min([WAYPOINT + 1,nstep]);
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
            end
        end
    case 6 % Go to returnPos
        if max(abs(jpos-returnPos)) < 2
            TASK_PHASE = 7;
            xref = sendEcCmd(restPos,jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,1);
            VISUALIZE = 1;
            nstep = size(xref,1)/6;
            waypoints = zeros(6,nstep);
            for i=1:nstep
                waypoints(:,i) = xref((i-1)*6+1:i*6);
            end
            WAYPOINT = 1;
            flag_sc = 0;
            count = 0;
        end
    case 7 % Rest Pos
        VISUALIZE = 0;
        if max(abs(jpos-restPos)) > 4
            if max(abs(jpos-waypoints(:,WAYPOINT)')) > WAY_MARGIN + norm(jvel)/3
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
            else
                WAYPOINT = min([WAYPOINT + 1,nstep]);
                xref = sendEcCmd(waypoints(:,WAYPOINT)',jpos,jvel,maxspeed,spTime,turtlebotstate,robot,0,0);
            end
        else
            if count < REST_COUNT
                count = count + 1;
            else
                TASK_PHASE = 0;
            end
        end
end
if VISUALIZE
    if exist('rthandle')
        for i=1:size(rthandle,1)
            for j=[2,4,5]
                delete(rthandle(i,j));
            end
        end
    end
    for i=1:nstep
        theta=xref((i-1)*6+1:i*6)/180*pi;
        valpha=i/6;
        color='r';
        robot.pos = CapPosMex(theta, robot.DH, robot.base, eye(3), robot.cap, robot.pos);
        
        for j=[2,4,5]
            rthandle(i,j)=plot3(robot.pos{1,j}.p(1,:),robot.pos{1,j}.p(2,:),robot.pos{1,j}.p(3,:),'.-','LineWidth',10,'markersize',50);
        end
        
        % Use the following lines to draw capsules
        % pause(0.1)
        % RobotCapLink;
        
        % Use the following lines to draw robot arm
        % RobotFigureLink;
    end
end