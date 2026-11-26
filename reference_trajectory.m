function [xd, dxd, ddxd] = reference_trajectory(t)
%REFERENCE_TRAJECTORY Reference in lecture slide 9.
% Input: simulation time t [s]. Outputs: desired angle and derivatives.
xd   =  0.1 * sin(t);
dxd  =  0.1 * cos(t);
ddxd = -0.1 * sin(t);
end
