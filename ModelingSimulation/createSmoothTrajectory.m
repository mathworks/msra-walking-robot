function curveData = createSmoothTrajectory(ankle,knee,hip,period)
% Generates cubic spline trajectory parameters given waypoints
% for 3 joints (ankle, knee, hip) and total gait period
% Source: https://see.stanford.edu/materials/aiircs223a/handout6_Trajectory.pdf
% Copyright 2017 The MathWorks, Inc.

    %% Create necessary values for calculations
    numPoints = numel(hip);
    curveData.gaitPeriod = period;
    curveData.gaitTime = linspace(0,period,numPoints);
    dt = period/(numPoints-1);
    
    %% Calculate derivatives
    % Assume zero derivatives at start and end
    hip_der = [0; 0.5*( diff(hip(1:end-1)) + diff(hip(2:end)) )/dt; 0];
    knee_der = [0; 0.5*( diff(knee(1:end-1)) + diff(knee(2:end)) )/dt; 0];
    ankle_der = [0; 0.5*( diff(ankle(1:end-1)) + diff(ankle(2:end)) )/dt; 0];
    
    %% Do cubic spline fitting
    curveData.a0_hip = hip(1:end-1);
    curveData.a1_hip = hip_der(1:end-1);
    curveData.a2_hip = 3*diff(hip)/(dt^2) - 2*hip_der(1:end-1)/dt - hip_der(2:end)/dt;
    curveData.a3_hip = -2*diff(hip)/(dt^3) + (hip_der(1:end-1)+hip_der(2:end))/(dt^2);
    curveData.a0_knee = knee(1:end-1);
    curveData.a1_knee = knee_der(1:end-1);
    curveData.a2_knee = 3*diff(knee)/(dt^2) - 2*knee_der(1:end-1)/dt - knee_der(2:end)/dt;
    curveData.a3_knee = -2*diff(knee)/(dt^3) + (knee_der(1:end-1)+knee_der(2:end))/(dt^2);
    curveData.a0_ankle = ankle(1:end-1);
    curveData.a1_ankle = ankle_der(1:end-1);
    curveData.a2_ankle = 3*diff(ankle)/(dt^2) - 2*ankle_der(1:end-1)/dt - ankle_der(2:end)/dt;
    curveData.a3_ankle = -2*diff(ankle)/(dt^3) + (ankle_der(1:end-1)+ankle_der(2:end))/(dt^2);
