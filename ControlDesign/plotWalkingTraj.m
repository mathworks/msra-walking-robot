% Plot 2D Walking Robot Trajectory
% Currently, this works with the logged data from walkingRobot3DPath.slx
%
% Copyright 2019 The MathWorks, Inc.

%% Check if there is an existing data log
if ~exist('logsout','var')
    error('No data log found. Run the simulation first.');
end

%% Setup
% Create figure and graphics objects
figure(1), clf, hold on
hRef = plot(pathX,pathY,'b-');
trajX = 0;
trajY = 0;
hTraj = plot(trajX,trajY,'k:','LineWidth',2); % Trajectory
hCom = plot(0,0,'go','MarkerSize',10,'LineWidth',3); % Center of mass
hRight = plot(0,0,'rs','MarkerSize',10,'LineWidth',3); % Right foot
hLeft = plot(0,0,'bs','MarkerSize',10,'LineWidth',3); % Leg foot
hHead = plot([0 0],[0 0],'g-','LineWidth',2); % Torso heading
hLeg = plot([0 0],[0 0],'b-','LineWidth',2); % Leg line
grid on

% Get data logs
% Footsteps are tracked at the sample time of the stepping
tStep = logsout.get('stepFwd').Values.Time;
stepFwd = logsout.get('stepFwd').Values.Data;
stepLat = logsout.get('stepFwd').Values.Data;

% Get the center of mass data and interpolate it to be an integer
% multiple of the stepping sample time.
% For example, N = 10 means 10 trajectory points
% per footstep.
N = 10;
tTraj = linspace(0,tStep(end),1 + (numel(tStep)-1)*N)';
X = interp1(logsout.get('sensors').Values.X.Time, ...
            logsout.get('sensors').Values.X.Data, ...
            tTraj);
Y = interp1(logsout.get('sensors').Values.Y.Time, ...
            logsout.get('sensors').Values.Y.Data, ...
            tTraj);
Q = interp1(logsout.get('sensors').Values.Q.Time, ...
            logsout.get('sensors').Values.Q.Data, ...
            tTraj);

%% Animate
for idx = 2:numel(stepFwd)
    % Extract center of mass position and heading
    trajIdx = N*(idx-2) + 1;
    x = X(trajIdx + N-1);
    y = Y(trajIdx + N-1);
    R = quat2rotm(Q(trajIdx + N-1,:));

    % Set graphics
    if mod(idx,2)   % Left foot at steps 2, 4, 6, 8, ...     
        footPos = R*[stepFwd(idx);-stepLat(idx);0]/100;       
        set(hLeft,'xdata',x+footPos(1),'ydata',y+footPos(2)); % Left leg
        set(hRight,'xdata',[],'ydata',[]);
    else            % Right foot at steps 1, 3, 5, 7, ...
        footPos = R*[stepFwd(idx);stepLat(idx);0]/100;
        set(hLeft,'xdata',[],'ydata',[]);
        set(hRight,'xdata',x+footPos(1),'ydata',y+footPos(2)); % Right leg
    end
    set(hLeg,'xdata',[x, x+footPos(1)], ...
             'ydata',[y, y+footPos(2)]);        
    set(hCom,'xdata',x,'ydata',y);
    angPos = R*[0.01;0;0];
    set(hHead,'xdata',[x, x+angPos(1)],'ydata',[y, y+angPos(2)]);
    trajX = [trajX;X(trajIdx + (0:(N-1)))];
    trajY = [trajY;Y(trajIdx + (0:(N-1)))];
    set(hTraj,'xdata',trajX,'ydata',trajY);
    
    % Set titles, axis limits, and pause
    title(['Robot Walking Trajectory, t = ' num2str(tStep(idx))]);
    xlim(x + [-0.1 0.1])
    ylim(y + [-0.1 0.1])
    legend('CoM Reference','CoM Trajectory','CoM Position','Right Foot','Left Foot')
    pause(tWalk/2)
    
end

% Expand the view at the end
xlim auto
ylim auto