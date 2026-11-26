%% INIT_PMS - Parameters from lecture slides 6-9
% Run once before opening/running the Simulink model.
pms = struct();
pms.l = 0.5;         % Half-length of pendulum (m)
pms.m = 0.1;         % Pendulum mass (kg)
pms.mc = 1.0;        % Cart mass (kg)
pms.g = 9.8;         % Gravitational acceleration (m/s^2)
pms.lambda = 1;      % Sliding-surface coefficient
pms.k = 1;           % Switching gain, must exceed D=0.02
pms.D = 0.02;        % Disturbance bound
pms.x0 = [pi/60; 0.05]; % Initial [angle; angular velocity]
pms.Tstop = 10;      % End time (s)
pms.Ts = 1e-3;       % Suggested fixed-step size (s)
pms.useSat = false;  % false: exact sign(s), true: boundary layer
pms.phi = 1e-3;      % Boundary-layer width (when useSat=true)
