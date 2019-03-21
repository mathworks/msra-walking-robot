% Copyright 2018 The MathWorks, Inc.

% Initialize parameters

waistW = 2 * 0.037;      % j_pelvis_l to base_link_to_body 
thighH = 0.093;          % j_tibia_l to j_thigh2_l 
calfH  = 0.093;          % j_ankle1_l to j_tibia_l
footL  = 0.05;             % TODO not measured yet 
footW  = 0.045;           % TODO not measured yet 0.06   
footH  = 0.005;          % TODO not measured yet  
footCom2ankle = 0;       % TODO not measured yet 
trunkH = 0.09355;        % j_pelvis_l to base_link_to_body 
neckH = 0.0235;          % j_pan to base_link_to_body 
backW = 2*0.0635;        % j_back_l to base_link_to_body 
armH = 0.06;                % j_low_arm_l to j_high_arm_l
radiusH = 0.048 + 0.048; % j_gripper_l to j_wrist_l to j_low_arm_l
handH = 0.02;            % TODO not measured yet 
handW = 0.005;            % TODO not measured yet 
handL = 0.02;            % TODO not measured yet 
headR = 0.025;            % TODO not measured yet   
linkWidth = 0.015;  % Width for all the links.

stickModelMassLink = 0.2;   % kg  Only for stick model


% Compute other parameters
waistCom2hip = waistW/2;
thighCom2hip = thighH/2;
thighCom2knee = thighH/2;
calfCom2knee = calfH/2;
calfCom2ankle = calfH/2;
footLF = 0.5*footL;           % 0.7*
footLB = footL - footLF;    % back 
footWE = 0.4*footW;         % 0.4            
footWI = footW - footWE;
armCom2shoulder = armH/2;
armCom2elbow = armH/2;
radiusCom2elbow = radiusH/2;
radiusCom2hand = radiusH/2;

% Figure color
human2color = [1.0 0 0];