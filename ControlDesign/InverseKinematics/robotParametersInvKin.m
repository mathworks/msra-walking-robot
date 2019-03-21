% Walking Robot Parameters -- Inverse Kinematics Variation
% Copyright 2019 The MathWorks, Inc.

%% General parameters
density = 500;
foot_density = 1000;
world_damping = 1e-3;
world_rot_damping = 0.25;
if ~exist('actuatorType','var')
    actuatorType = 1;
end

%% Inputs
gaitPeriod = 0.75;
stepLength = 0.075;
stepHeight = 0.025;
                     
%% Contact/friction parameters
contact_stiffness = 1000;
contact_damping = 50;
mu_k = 0.7;
mu_s = 0.9;
mu_vth = 0.1;
height_plane = 0.025;
plane_x = 25;
plane_y = 3;
contact_point_radius = 1e-4;

%% Foot parameters
foot_x = 8;
foot_y = 6;
foot_z = 1;
foot_offset = [-1 0 0];

%% Leg parameters
leg_radius = 0.75;
lower_leg_length = 10;
upper_leg_length = 10;

%% Torso parameters
torso_y = 10;
torso_x = 5;
torso_z = 8;
torso_offset_z = -2;
torso_offset_x = -1;

%% Derived parameters for initial conditions
foot_height_offset = sqrt( (lower_leg_length+upper_leg_length)^2 ...
                         - ((stepLength/2)*100)^2 ) - 1e-3;
if ~isreal(foot_height_offset)
    error('Step Length is too long given the robot leg lengths.');
end

init_height = foot_z + foot_height_offset + ...
              torso_z/2 + torso_offset_z + height_plane/2;
          
init_ang = sin( (stepLength/2)*100 / sqrt(lower_leg_length+upper_leg_length)^2 );
initAnglesR = init_ang * [1; 0; -1];
initAnglesL = -initAnglesR;

%% Joint parameters
joint_damping = 1;
joint_stiffness = 1;
motion_time_constant = 0.001;

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