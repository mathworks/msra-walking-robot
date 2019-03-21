% Plots cubic spline trajectory, defined by the 'curveData' variable
% Copyright 2017 The MathWorks, Inc.

%% Define vectors for plots
N = 500;
t = linspace(0,curveData.gaitPeriod,N);
ankle_curve = zeros(size(t));
knee_curve = zeros(size(t));
hip_curve = zeros(size(t));

%% Loop over all points
for idx = 1:N 
    trajPts = evalSmoothTrajectory(curveData,t(idx));
    ankle_curve(idx) = trajPts(1);
    knee_curve(idx) = trajPts(2);
    hip_curve(idx) = trajPts(3);   
end

%% Plot
figure
subplot(3,1,1)
plot(t,rad2deg(ankle_curve),'b-', ...
     curveData.gaitTime,rad2deg([curveData.a0_ankle;curveData.a0_ankle(1)]),'ro');
title('Gait')
xlabel('Time [s]');
ylabel('Ankle Angles [deg]');
subplot(3,1,2)
plot(t,rad2deg(knee_curve),'b-', ...
     curveData.gaitTime,rad2deg([curveData.a0_knee;curveData.a0_knee(1)]),'ro');
xlabel('Time [s]');
ylabel('Knee Angles [deg]');
subplot(3,1,3)
plot(t,rad2deg(hip_curve),'b-', ...
     curveData.gaitTime,rad2deg([curveData.a0_hip;curveData.a0_hip(1)]),'ro');
xlabel('Time [s]');
ylabel('Hip Angles [deg]');