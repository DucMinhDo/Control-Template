function [sys, x0, str, ts] = pendulum_sfunc(t, x, u, flag, pms)
    switch flag
        case 0
            [sys, x0, str, ts] = mdlInitializeSizes(pms);
        case 1
            sys = mdlDerivatives(t, x, u, pms);
        case 3
            sys = mdlOutputs(t, x, u);
        case {2, 4, 9}
            sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
    end
function [sys, x0, str, ts] = mdlInitializeSizes(pms)
    sizes = simsizes;
    sizes.NumContStates  = 2;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 2;
    sizes.NumInputs      = 2;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0 = pms.x0(:);
    str = [];
    ts = [0 0];
function sys = mdlDerivatives(t, x, u, pms)
    [f, h] = pendulum_dynamics(x(1), x(2), pms);
    dx1 = x(2);
    dx2 = f + h * u(2) + u(1);
    sys = [dx1; dx2];
function sys=mdlOutputs(t, x, u)
    sys = x(:);
