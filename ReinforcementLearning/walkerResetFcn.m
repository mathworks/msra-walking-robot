% Helper function to reset walking robot simulation with different initial conditions
%
% Copyright 2019 The MathWorks, Inc.

function in = walkerResetFcn(in,upper_leg_length,lower_leg_length,init_height,dim)
    
    % Randomization Parameters
    % Note: Y-direction parameters are only used for the 3D walker model
    max_displacement_x = 0.05;
    max_speed_x = 0.05;
    max_displacement_y = 0.025;
    max_speed_y = 0.025;
    
    % Chance of randomizing initial conditions
    if rand < 0.5
        if rand < 0.5
            in = in.setVariable('vx0',2*max_speed_x *(rand-0.5));
            in = in.setVariable('vy0',2*max_speed_y *(rand-0.5));
        else
            in = in.setVariable('vx0',0);
            in = in.setVariable('vy0',0);
        end       
        leftinit  = [(rand(2,1)-[0.5;0]).*[2*max_displacement_x; max_displacement_y]; -init_height];              
        rightinit = [-leftinit(1); -rand*max_displacement_y ; -init_height]; % Ensure feet are symmetrically positioned for stability                
        
    % Chance of starting from zero initial conditions
    else
        in = in.setVariable('vx0',0); 
        in = in.setVariable('vy0',0);
        leftinit  = [0;0;-init_height];
        rightinit = [0;0;-init_height];
    end
    
    % Solve Inverse Kinematics for both left and right foot positions
    init_angs_L = walkerInvKin(leftinit, upper_leg_length, lower_leg_length, dim);     
    in = in.setVariable('leftinit',leftinit);
    in = in.setVariable('init_angs_L',init_angs_L);

    init_angs_R = walkerInvKin(rightinit, upper_leg_length, lower_leg_length, dim);     
    in = in.setVariable('rightinit',rightinit);
    in = in.setVariable('init_angs_R',init_angs_R); 
    
end