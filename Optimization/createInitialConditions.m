function [P,T,N] = createInitialConditions(filename,scale)
% Converts data from a previously saved MAT-file to initial conditions for
% the genetic algorithm
% Copyright 2017 The MathWorks, Inc.

    % Load previously saved file
    load(filename);
    
    % Find number of points (ignore end point)
    N = numel(hip_motion)-1;   
    
    % Find gait period
    T = time(N+1);
    
    % Convert gait to scaled version for optimization
    P = rad2deg([ankle_motion(1:N)' ...
                 knee_motion(1:N)' ...
                 hip_motion(1:N)'])/scale;

end