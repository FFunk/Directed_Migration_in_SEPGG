
%% Static ODE + PDE Parameters:

seed = 1; %for reproducibility. 
rng(seed)

%ODE paramters. I don't change these.
b = 1;
d = 1.2;
N = 8;

%PDE parameters.
T = 2000;
dt = 0.01;

L = 75;
pdeN = 200; 
init = 8;

m = pdeN;
n = pdeN;

%% Definition of variable ODE + PDE Parameters:

% Interest.
r= 2.325;

% Diffusion Parameters.
DC = 0.1;
DD = 0.1;

% Advection Parameters
AC = 0;
AD = 0;
RC = 0;
RD = 10;


%Visualization function: image/surface etc., see utility.
plotMode = @imPlot;

%Visualization through movie?
showPlot = true;

% If movie should be saved, generate folder and supply folder.
% Generate a folder with ...\movies\images to save
% Be aware that you need to modify some parts of the code to make that work
% on MAC: e.g. MAC systems use a folder structure with '/' instead of '\'
folderpath = 'C:\Users\Felix\Desktop\movies\image\';



%% Store Parameter in Structure for easier usage.

rParam = struct('b',b,'d',d,'r',r,'N',N);
dParam = struct('DC',DC,'DD',DD);
aParam = struct('AC',AC,'AD',AD,'RC',RC,'RD',RD);
discrParam = struct('dt',dt,'T',T,'L',L,'m',m,'n',n,'init',init);

pde_solve(rParam, dParam, aParam, discrParam, ...
    folderpath, showPlot, plotMode)
