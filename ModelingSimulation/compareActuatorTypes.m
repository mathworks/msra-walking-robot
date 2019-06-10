% Simulates the walking robot model with the 3 actuator variants and
% compares results
% Copyright 2017 The MathWorks, Inc.

%% Setup
clc; close all;
robotParameters
load optimizedData_21Jul17_0751 % Modify file name
mdlName = 'walkingRobot';       % Modify model name
bdclose(mdlName)
open_system(mdlName)

%% Simulate
actuatorType = 1;
tic; simout_motion = sim(mdlName,'StopTime','10');
disp(['Compiled and ran Motion actuated simulation in ' num2str(toc) ' seconds']);
actuatorType = 2;
tic; simout_torque = sim(mdlName,'StopTime','10');
disp(['Compiled and ran Torque actuated simulation in ' num2str(toc) ' seconds']);
actuatorType = 3;
tic; simout_motor = sim(mdlName,'StopTime','10');
disp(['Compiled and ran Motor actuated simulation in ' num2str(toc) ' seconds']);

%% Plot
figure(1)
subplot(3,1,1)
hold on
plot(simout_motion.yout{2}.Values.Time,simout_motion.yout{2}.Values.Data,'b-');
plot(simout_torque.yout{2}.Values.Time,simout_torque.yout{2}.Values.Data,'r-');
plot(simout_motor.yout{2}.Values.Time, simout_motor.yout{2}.Values.Data, 'k-');
title('Robot Motion')
legend('Motion','Torque','Motor');
title('Simulation Output Comparisons');
xlabel('Time [s]');
ylabel('Distance traveled [m]');
subplot(3,1,2)
hold on
plot(simout_motion.yout{1}.Values.Time,simout_motion.yout{1}.Values.Data,'b-');
plot(simout_torque.yout{1}.Values.Time,simout_torque.yout{1}.Values.Data,'r-');
plot(simout_motor.yout{1}.Values.Time, simout_motor.yout{1}.Values.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Angular Velocity [rad/s]');
subplot(3,1,3)
hold on
plot(simout_motion.yout{3}.Values.Time,simout_motion.yout{3}.Values.Data,'b-');
plot(simout_torque.yout{3}.Values.Time,simout_torque.yout{3}.Values.Data,'r-');
plot(simout_motor.yout{3}.Values.Time, simout_motor.yout{3}.Values.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Torso Height [cm]');

figure(2)
subplot(3,1,1)
hold on
plot(simout_motion.yout{4}.Values.ankle_torque.Time,simout_motion.yout{4}.Values.ankle_torque.Data,'b-');
plot(simout_torque.yout{4}.Values.ankle_torque.Time,simout_torque.yout{4}.Values.ankle_torque.Data,'r-');
plot(simout_motor.yout{4}.Values.ankle_torque.Time, simout_motor.yout{4}.Values.ankle_torque.Data, 'k-');
title('Joint Torques')
legend('Motion','Torque','Motor');xlabel('Time [s]');
ylabel('Right Leg Ankle Torque [N*m]');
subplot(3,1,2)
hold on
plot(simout_motion.yout{4}.Values.knee_torque.Time,simout_motion.yout{4}.Values.knee_torque.Data,'b-');
plot(simout_torque.yout{4}.Values.knee_torque.Time,simout_torque.yout{4}.Values.knee_torque.Data,'r-');
plot(simout_motor.yout{4}.Values.knee_torque.Time, simout_motor.yout{4}.Values.knee_torque.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Right Leg Knee Torque [N*m]');
subplot(3,1,3)
hold on
plot(simout_motion.yout{4}.Values.hip_torque.Time,simout_motion.yout{4}.Values.hip_torque.Data,'b-');
plot(simout_torque.yout{4}.Values.hip_torque.Time,simout_torque.yout{4}.Values.hip_torque.Data,'r-');
plot(simout_motor.yout{4}.Values.hip_torque.Time, simout_motor.yout{4}.Values.hip_torque.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Right Leg Hip Torque [N*m]');

figure(3)
subplot(3,1,1)
hold on
plot(simout_motion.yout{4}.Values.ankle_angle.Time,simout_motion.yout{4}.Values.ankle_angle.Data,'b-');
plot(simout_torque.yout{4}.Values.ankle_angle.Time,simout_torque.yout{4}.Values.ankle_angle.Data,'r-');
plot(simout_motor.yout{4}.Values.ankle_angle.Time, simout_motor.yout{4}.Values.ankle_angle.Data, 'k-');
title('Joint Angles')
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Right Leg Ankle Angle [rad]');
subplot(3,1,2)
hold on
plot(simout_motion.yout{4}.Values.knee_angle.Time,simout_motion.yout{4}.Values.knee_angle.Data,'b-');
plot(simout_torque.yout{4}.Values.knee_angle.Time,simout_torque.yout{4}.Values.knee_angle.Data,'r-');
plot(simout_motor.yout{4}.Values.knee_angle.Time, simout_motor.yout{4}.Values.knee_angle.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Right Leg Knee Angle [rad]');
subplot(3,1,3)
hold on
plot(simout_motion.yout{4}.Values.hip_angle.Time,simout_motion.yout{4}.Values.hip_angle.Data,'b-');
plot(simout_torque.yout{4}.Values.hip_angle.Time,simout_torque.yout{4}.Values.hip_angle.Data,'r-');
plot(simout_motor.yout{4}.Values.hip_angle.Time, simout_motor.yout{4}.Values.hip_angle.Data, 'k-');
legend('Motion','Torque','Motor');
xlabel('Time [s]');
ylabel('Right Leg Hip Angle [rad]');


%% Cleanup
bdclose(mdlName)