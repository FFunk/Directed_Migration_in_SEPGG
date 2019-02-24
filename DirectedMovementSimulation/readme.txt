Matlab simulation of the selection-migration model.

Folder overview:
ode: Simulation of the selection system.
pde: Simulation of the spatial dynamics.
disp_rel: Dispersion relation and necessary criterion predictions.
utility: Utility functions. Primarily needed for pde/disp_rel package.

The primary simulation script is in the folder pde/pde_simulate. There the 
selection/migration/discretization parameters can be adjusted. Also movies
and figures can be print of the end states.

Be aware that diffusion is required for directed migration to remain stable.
I would suggest to keep the rates AC and AD at most 10-40 times of the scale
of cooperator diffusion DC. Fleeing cooperators, RC, and spreading defectors,
are easier to simulate and more stable.

Technical details: During the project, I tried various numerical implementations. The current 
version, which is provided here, uses periodic boundaries and forward-Euler
time stepping plus central differencing to approximate first and second 
order derivatives. The function reactdiffadv in pde informs further about
these details.
