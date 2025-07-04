# Stability-and-Dynamics-of-Flows-Through-Channels-with-Rough-Wall

The objective of my project is to develop a numerical model to analyse fluid flow through a rectangular channel, considering the effects of surface roughness and temperature.
Roughness is incorporated using sinusoidal waves with amplitude and number of waves as parameter.
I began by defining all the necessary physical and computational parameters, such as channel length, height, Reynolds number, inlet velocity, and mesh resolution. Once these were set, I created the channel geometry and imposed the boundary conditions.
To incorporate roughness, I used sinusoidal waves on the channel walls, with the amplitude and the number of waves as parameters to control the degree of roughness.
For spatial discretisation, I generated an unstructured triangular mesh inside the domain. The finite element spaces were chosen as quadratic elements for velocity and linear elements for pressure.
Next, I derived the weak form of the incompressible Navier-Stokes equations and applied boundary conditions: a Hagen–Poiseuille parabolic velocity profile at the inlet, no-slip conditions (zero velocity) on the channel walls.
A probe point was placed in the domain to verify convergence during the iterative solution process. the computed fields — velocity, pressure, vorticity, and mesh data — were saved for post-processing. 
MATLAB was then used for detailed validation. Ex: I extracted the velocity profile at fixed x-locations and plotted Ux versus y, comparing the numerical results to the analytical Hagen–Poiseuille solution for an ideal smooth channel. The plots were visually exactly coinciding with MSE of order 10^-8.
