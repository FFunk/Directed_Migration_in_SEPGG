function [ ] = pde_solve(rParam, dParam, aParam, discrParam, ...
    folderpath, showPlot, plotMode)
%SIMULATE Core function which simulates the reaction diffusion directed 
% migration system
%rParam, dParam, aParam, discrParam are structures combining the parameters
%of the reaction/social conflict, the diffusion/undirected movement, 
%the directed movement, and discretization.

L = discrParam.L;
m = discrParam.m;
n = discrParam.n;
dt = discrParam.dt;
init = discrParam.init;
T = discrParam.T;

%This sets the initial conditions. 
[U0,V0,X1,X2] = initialState(init, m, n, L); 

% Transforms the matrix into long column vectors for forward step.
u0 = matr2vec(U0);
v0 = matr2vec(V0);



if (showPlot)
    vid = VideoWriter(strcat(folderpath, 'video.avi'),'Uncompressed AVI');
    open(vid)
end

%% Solving the PDE using the differential equation.

curTime = 0;        % This variable keeps track of current time.
printTime = 0;      % Temp variable
outputState = 1;    % How regular output should be visualized.

%% Forward Euler Iterations
u = u0;
v = v0;

lastU = zeros(size(u));
lastV = zeros(size(v));

converged = false;
iter = 1;
while (curTime <= T + 10^(-6) )
       
    
    if (curTime >= printTime - 10^(-6))        
        if(hasConverged([lastU;lastV],[u;v],outputState,m))
            converged = true;
            %This quickly terminates the rest of the 
            %calculations if there is not a noticable change.
        end
        
        %for convergence check
        lastU = u;
        lastV = v;
        
        %visualization
        if (showPlot == true)            
            plotMode(round(curTime),X1,X2,vec2matr(u,m,n),vec2matr(v,m,n),L);
            drawnow
            frame = getframe(gcf);
            writeVideo(vid,frame);
        end
        
        %for next output iteration
        printTime = printTime + outputState;
        iter = iter + 1;
    end
    
    % Simulate next time step
    
    % Convergence criterion. Avoids computation if converged.
    if (converged == false)
        [u2,v2] = reactDiffAdv(u, v, rParam, dParam, aParam, discrParam);
    else 
        u2 = u;
        v2 = v;
    end
        
    % Prepare for next iteration
    u = u2;
    v = v2;
    curTime = curTime + dt;   
end

%for plotting
if (showPlot == true)            
    plotMode(round(curTime-1),X1,X2,vec2matr(u,m,n),vec2matr(v,m,n),L);
    drawnow
    close(vid)
end
    
%    imwrite(imPlotRaw(vec2matr(u,m,n),vec2matr(v,m,n)), ...
%         strcat(imagepath, identifier, '.tiff'),'tiff');
end

