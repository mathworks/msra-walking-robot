function out = evalSmoothTrajectory(params,t)
% Evaluates cubic spline trajectory given the following inputs
%   params  - Curve parameters (coefficients, time vector, etc.)
%   t       - Time to evaluate curve
% Copyright 2017 The MathWorks, Inc.

    % Wrap the time value on every cycle of the trajectory
    tEff = mod(t,params.gaitPeriod);
    
    % Find the index of the curve segment based on time
    indices = find(tEff >= params.gaitTime(1:end-1));
    idx = indices(end);
    
    % Find the difference between current time and start of curve segment
    dt = tEff - params.gaitTime(idx);
    
    % Calculate smooth trajectory joint angles
    out = zeros(3,1);
    out(1) = params.a0_ankle(idx) + params.a1_ankle(idx)*dt + ...
             params.a2_ankle(idx)*dt^2 + params.a3_ankle(idx)*dt^3; 
    out(2) = params.a0_knee(idx) + params.a1_knee(idx)*dt + ...
             params.a2_knee(idx)*dt^2 + params.a3_knee(idx)*dt^3;
    out(3) = params.a0_hip(idx) + params.a1_hip(idx)*dt + ...
             params.a2_hip(idx)*dt^2 + params.a3_hip(idx)*dt^3;

end