%% Initialize parameter for ODE:

u0 = 0.05;
v0 = 0.01;

b = 1;
d = 1.2;
r = 2.4;
N = 8;
rParam = struct('b',b,'d',d,'r',r,'N',N);


T = 500;
dt = 0.01;

discrParam = struct('dt',dt,'T',T);

%% Simulate ODE:
simulateODE(u0,v0,rParam,discrParam);