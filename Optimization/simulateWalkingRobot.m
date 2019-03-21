function penalty = simulateWalkingRobot(params,mdlName,scaleFactor,period,actuatorType)
% Cost function for robot walking optimization
% Copyright 2017 The MathWorks, Inc.

    % Load parameters into function workspace
    robotParameters;
    
    % Apply variable scaling
    params = scaleFactor*params;
    
    % Extract simulation inputs from parameters
    N = numel(params)/3;
    ankle_motion   = deg2rad([params(1:N), params(1)]');
    knee_motion  = deg2rad([params(N+1:2*N), params(N+1)]');
    hip_motion = deg2rad([params(2*N+1:3*N), params(2*N+1)]');    
    curveData = createSmoothTrajectory( ... 
                ankle_motion,knee_motion,hip_motion,period);
    initAnglesR = evalSmoothTrajectory(curveData,0);
    initAnglesL = evalSmoothTrajectory(curveData,-period/2);

    % Simulate the model
    simout = sim(mdlName,'SrcWorkspace','current','FastRestart','on');          

    % Unpack logged data
    wAvg = mean(simout.yout{1}.Values.Data);
    xEnd = simout.yout{2}.Values.Data(end);
    tEnd = simout.tout(end);

    % Calculate penalty from logged data
    %   Distance traveled without falling 
    %   (ending simulation early) increases reward
    positiveReward = sign(xEnd)*xEnd^2 * tEnd;
    %   Angular velocity and trajectory aggressiveness 
    %   (number of times the derivative flips signs) decreases reward
    %   NOTE: Set lower limits to prevent divisions by zero
    aggressiveness = 0;
    diffs = [diff(hip_motion) diff(knee_motion) diff(ankle_motion)];
    for idx = 1:numel(diffs)-1
        if (sign(diffs(idx)/diffs(idx+1))<0) && mod(idx,N) 
             aggressiveness = aggressiveness + 1;            
        end
    end
    negativeReward = max(abs(wAvg),0.01) * max(aggressiveness,1);
    %   Negative sign needed since the optimization minimizes cost function     
    penalty = -positiveReward/negativeReward;        
    
end

