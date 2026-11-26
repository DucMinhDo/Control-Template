# Sliding-mode control of inverted pendulum (MATLAB/Simulink R2023a)

Files transcribe the lecture's slides 6-9, plot style inspired by slide 41.

## Files
- `init_pms.m`: parameter struct `pms`, initial conditions, solver hints.
- `reference_trajectory.m`: reference `[xd,dxd,ddxd]` from time `t`.
- `disturbance_signal.m`: acceleration disturbance `d(t)`.
- `pendulum_dynamics.m`: shared dynamic terms `f`, `h`.
- `smc_controller.m`: SMC `u`, `s`, `e`, `ueq`, `uR`.
- `pendulum_sfunc.m`: continuous MATLAB S-Function of the plant.
- `plot_results.m`: plots workspace logs as MATLAB figures and 300 dpi PNGs.

## Setup: build in Simulink
1. Change MATLAB Current Folder to this directory, run `init_pms`.
2. Add **Clock** into a **MATLAB Function** block, e.g. source function body:
   ```matlab
   function [xd,dxd,ddxd] = reference_block(t)
   [xd,dxd,ddxd] = reference_trajectory(t);
   end
   ```
3. Add another MATLAB Function block for disturbance:
   ```matlab
   function d = disturbance_block(t)
   d = disturbance_signal(t);
   end
   ```
4. Create MATLAB Function controller block with **six** inputs: x1, x2, xd, dxd, ddxd, pms.
   Use **Constant** block with `Value = pms` for `pms` input (or mark `pms` as parameter in the block editor).
   ```matlab
   function [u,s,e,ueq,uR] = controller_block(x1,x2,xd,dxd,ddxd,pms)
   [u,s,e,ueq,uR] = smc_controller(x1,x2,xd,dxd,ddxd,pms);
   end
   ```
   You can also use a MATLAB Function block with `pms` declared as a **Parameter** rather than an input.
5. Add **S-Function** from Simulink / User-Defined Functions.
   - S-function name: `pendulum_sfunc`
   - S-function parameters: `pms`
   - Input: output of a 2-input **Mux** containing `[u;d]`
   - Output: **Demux (2)** to produce `x1`, `x2`
   - There are **no external integrators**: two integrations are inside this S-Function.
6. Feedback `x1`,`x2` to SMC. Send `x1`, `xd`, `u`, `s`, `e`, `d` to six **To Workspace** blocks with the exact listed variable names. Set each Save format = **Timeseries** (recommended). Optionally export `x2`, `ueq`, `uR`.
7. Set Stop time `pms.Tstop` (10), Type `Fixed-step`, Solver `ode4 (Runge-Kutta)`, Fixed-step size `pms.Ts` (0.001). In Configuration Parameters enable saving time to `tout` only if using Array format.
8. Run model; then run `plot_results` (MATLAB current folder = project directory). Figures appear and are saved under `figures/`.

## Key equations (as they appear in slides)
`e = x1 - xd`, `s = (x2 - dxd) + lambda*e`.
`ueq = (-f + ddxd - lambda*(x2-dxd))/h`.
`uR = -k*sign(s)/h`; `u = ueq + uR`.
State dynamics: `x1dot = x2`, `x2dot = f + h*u + d`.

**Important transcription notice:** Slide 7 shows the term `m*l^2*cos(x1)*sin(x1)` in the numerator of `f`, with **no x2 term**. This is reproduced literally, although conventional cart-pole models typically include an angular-velocity-squared term instead. Confirm the intended expression with the lecturer before using this model for research or physical deployment.

**SMC note:** Exact `sign(s)` may cause numerical chattering with fixed-step integration. To test a smooth boundary layer use `pms.useSat=true; pms.phi=1e-3;` before running, but that is a modification of the lecture's original controller. `k=1 > D=0.02`.
