function angs = walkerInvKin(pos, upper_leg_length, lower_leg_length,dim)
% 3D Inverse Kinematics to set the robot leg initial conditions
% The "dim" argument can be set to "2D" or "3D" for the different cases.
%
% Copyright 2019 The MathWorks, Inc.

    % Unpack
    x = pos(1);
    if isequal(dim,'3D')
        y = pos(2);
    else
        y = 0;
    end
    z = pos(3);
    
    % Compute the hip angle
    hipRoll = -atan2(y,-z);
    
    % Call symbolic generated function for 2D leg
    zMod = z/cos(hipRoll);
    
    maxMag = (upper_leg_length + lower_leg_length)*0.99; % Do not allow fully extended
    mag = sqrt(x^2 + zMod^2);
    if sqrt(x^2 + zMod^2) > maxMag
        x = x*maxMag/mag;
        zMod = zMod*maxMag/mag;
    end
    
    % Call 2D Inverse Kinematics
    theta = legInvKin(upper_leg_length,lower_leg_length,-x,zMod);
    
    % Address multiple outputs
    if size(theta,1) == 2
       if theta(1,2) < 0
          hipPitch = theta(2,1);
          kneePitch = theta(2,2);
       else
          hipPitch = theta(1,1);
          kneePitch = theta(1,2);
       end
    else
        hipPitch = theta(1);
        kneePitch = theta(2);
    end
    
    % Set ankle angles
    anklePitch = -kneePitch - hipPitch;
    ankleRoll  = -hipRoll;
    
    % Pack
    angs = [ankleRoll; anklePitch; kneePitch; hipRoll; hipPitch];
    
end