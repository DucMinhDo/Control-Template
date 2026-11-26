function [f, h] = pendulum_dynamics(x1, x2, pms)
%PENDULUM_DYNAMICS f and h transcribed literally from lecture slide 7.
% x2 is retained in the signature even though slide's f,h omit x2.
% NOTE: numerator contains m*l^2*cos(x1)*sin(x1) in the slide.
% A more conventional cart-pole expression may contain m*l*x2^2...
% No correction is applied here: this reproduces the provided lecture.
% x1 in radians; x2 in rad/s.
M = pms.mc + pms.m;
den = pms.l * (4/3 - pms.m * cos(x1)^2 / M);
f = (pms.g * sin(x1) - pms.m * pms.l^2 * cos(x1) * sin(x1) / M) / den;
h = (cos(x1) / M) / den;
end
