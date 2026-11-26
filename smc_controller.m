function [u, e, de] = smc_controller(x, xd, dxd, ddxd, pms)
%SMC_CONTROLLER Sliding-mode controller from lecture slide 8.
% Inputs: measured angle x1, angular rate x2; reference xd,dxd,ddxd.
% Outputs: u, sliding variable s, position error e, and u components.
x1 = x(1);
x2 = x(2);
[f, h] = pendulum_dynamics(x1, x2, pms);
e = x1 - xd;
de = x2 - dxd;
s = de + pms.lambda * e;
if abs(h) < 1e-10
    % At cos(x1)=0 the input gain h is singular for inversion.
    error('smc_controller:singularInputGain', ...
        'Input gain h is too small near cos(x1)=0.');
end
ueq = (-f + ddxd - pms.lambda * de) / h;
if pms.useSat
    sigma = min(max(s / pms.phi, -1), 1);
else
    sigma = sign(s);
end
uR = -pms.k * sigma / h;
u = ueq + uR;
end
