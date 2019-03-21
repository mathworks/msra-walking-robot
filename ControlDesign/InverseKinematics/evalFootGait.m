function [x,y] = evalFootGait(t,stepLength,stepHeight,gaitPeriod)
% EVALFOOTGAIT Evaluates foot gait at a specified time
%
% Copyright 2019 The MathWorks, Inc.

    % t = 0 : extended forward
    % 0 >= t > T/2 : dragging back
    % T/2 >= t > T : swinging forward
    
    tEff = mod(t,gaitPeriod);
    
    % Dragging back (y position is 0)
    if tEff < gaitPeriod/2
        x = stepLength * (gaitPeriod - 2*tEff)/gaitPeriod - stepLength/2;
        y = 0;
        
    % Swinging forward (y follows curve)
    else
        x = stepLength * (2*tEff - gaitPeriod)/gaitPeriod - stepLength/2; 
        y = stepHeight*(1 - (4*abs(tEff - 3*gaitPeriod/4)/gaitPeriod)^2);
    end
    
end