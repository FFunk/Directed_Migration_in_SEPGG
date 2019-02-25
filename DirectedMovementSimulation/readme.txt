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
are easier to simulate and more stable which easily allow 80 times the scale
of cooperator diffusion.

Technical details: During the research project, I tried various numerical 
implementations. The current version, which is provided here, uses periodic 
boundaries and forward-Euler time stepping plus central differencing to 
approximate first and second order derivatives. The function reactdiffadv 
in pde informs further about these details.

When simulating also consider that the coexistence equilibrium Q has a limited 
attraction. This impliest hat population can go extinct for unlucky initial
configurations. This dependence can also be observed within the chaotic regime
when population can distribute in a manner which results in extinction. 
The code determining the initial configuration can be found in the utility 
folder.

For further questions, send an email to felix(dot)funk(at)alumni(dot)ubc(dot)ca.