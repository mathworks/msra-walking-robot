% Walking Robot Parameters -- 3D
% Copyright 2019 The MathWorks, Inc.

%% General parameters
density = 500;
foot_density = 1000;
if ~exist('actuatorType','var')
    actuatorType = 1;
end
world_damping = 1e-3;
world_rot_damping = 5e-2;
                    
%% Contact/friction parameters
contact_stiffness = 500;
contact_damping = 50;
mu_k = 0.7;
mu_s = 0.9;
mu_vth = 0.01;
height_plane = 0.025;
plane_x = 25;
plane_y = 3;
contact_point_radius = 1e-4;

%% Foot parameters
foot_x = 5;
foot_y = 4;
foot_z = 1;
foot_offset = [-1 0 0];

%% Leg parameters
leg_radius = 0.75;
lower_leg_length = 10;
upper_leg_length = 10;

%% Torso parameters
torso_y = 8;
torso_x = 5;
torso_z = 8;
torso_offset_z = -2;
torso_offset_x = -1;
mass = (0.01^3)*torso_y*torso_x*torso_z*density;
g = 9.80665;

%% Derived parameters for initial conditions
h = 18;
init_height = foot_z + h + ...
              torso_z/2 + torso_offset_z + height_plane/2;
          
init_angs = legInvKin(upper_leg_length/100,lower_leg_length/100,0,-h/100);
init_angs = init_angs(2,:);

%% Joint parameters
joint_damping = 1;
joint_stiffness = 1;
motion_time_constant = 0.01;

%% Joint controller parameters
hip_servo_kp = 60;
hip_servo_ki = 10;
hip_servo_kd = 20;
knee_servo_kp = 60;
knee_servo_ki = 5;
knee_servo_kd = 10;
ankle_servo_kp = 20;
ankle_servo_ki = 4;
ankle_servo_kd = 8;
deriv_filter_coeff = 100;
max_torque = 20;

%% Electric motor parameters
motor_resistance = 1;
motor_constant = 0.02;
motor_inertia = 0;
motor_damping = 0;
motor_inductance = 1.2e-6;
gear_ratio = 50;

%% Walking controller parameters
TsCtrl = 0.05;      % Controller sample time (s)
tWalk = 0.3;        % Walking gait period (s)
stepHeight = 0.02;  % Step height when swinging leg (m)
Kwalk = 0.5;        % Walking gain for tracking XYZ foot positions

%% Sample path for the robot to track
if ~exist('pathType','var')
    pathType = 1;
end
if pathType == 1        % Square
    pathT = [0 2 15 30 45 60]';
    pathX = [0 0.01 1 1 0 0]';
    pathY = [0 0.01 0 1 1 0]';
elseif pathType == 2        % Circle
    timePts = (0:2.5:60);
    pathR = 0.5;
    pathT = [0 1 timePts+2]';
    pathX = [0 0.01 pathR*cos(2*pi*timePts/60 - pi/2)]';
    pathY = [0 0.01 pathR*(sin(2*pi*timePts/60 - pi/2)+1)]';     
elseif pathType == 3    % Star
    pathT = [0 1 12 24 36 48 60]';
    pathX = [0 0.01 0.75 -0.25 0.5 0.25 0]';
    pathY = [0 0.01 0.5  0.5   0   0.75 0]';
end
curveT = linspace(0,pathT(end),100)';
curveX = interp1(pathT,pathX,curveT);
curveY = interp1(pathT,pathY,curveT);
curveZ = zeros(size(curveT));
interPts = [curveX curveY curveZ];