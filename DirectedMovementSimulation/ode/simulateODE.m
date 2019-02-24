function [ ] = simulateODE(u0,v0,rParam,discrParam)
%SIMULATE Simulates the reaction diffusion directed migration system
%(short advection here).

dt = discrParam.dt;
T = discrParam.T;

b = rParam.b;
d = rParam.d;
r = rParam.r;
N = rParam.N;

outputState = 0.1; %output State every ... generations. T/outputState should be integer.
state = zeros(T/outputState + 1, 3);


%% Solving the PDE using the differential equation.

curTime = 0; %This variable keeps track of 
printTime = 0; %This timer keeps track when to output.

%% Forward Euler Iterations
u = u0;
v = v0;
j = 1;

while (curTime <= T + 10^(-6))
   
    if (curTime >= printTime- 10^(-6))        
        disp(curTime)
        %output
        state(j,:) = [curTime, u, v];
        
        %for next output iteration
        printTime = printTime + outputState;        
        j = j+1;
    end
    [du,dv] = react(u,v);
    % Forward step
    u = u + dt * du;
    v = v + dt * dv;
    curTime = curTime + dt; % move time forward by dt
end

disp(u)
disp(v)

plot(state(:,1),state(:,2),'g', state(:,1),state(:,3),'r', state(:,1),state(:,2)+state(:,3),'k');
ylim( [0,0.5]);
%set(gca,'YTickLabel',[]);
%set(gca,'xTickLabel',[]);

function [du,dv] = react(u, v)
        %reactU: Calculates the RHS of the reaction term for the cooperation density u. 
        % input: 
        %   vector u density of cooperators at different positions
        %   vector v density of defectors at different positions
        %   const b, birthrate of cooperators
        %   const d, deathrate of cooperators
        %   const r, denotes the amplification of resource invested in public good
        %   const N, population size in which the public goods game is played.
        %   
        % output:
        %   rhs of the reaction part, change of u.

        w = (1 - u - v);
        %calculating (1-w^N)/(1-w) = 1 + w +...+ w^(N-1) but more numerically stable
        q = ones(size(u)) + w;
        s = w;
        for i= 2:(N-1)
            s = s.*w; %s^i
            q = q + s;
        end

        F = 1 + (r-1) * s - r/N * q; %Difference in payoff, coop to def
        fD =  r*(u./(u+v)) .* (1- 1/N* q ) ; %Average payoff from game
        fC =  fD - F;
        du = u .*(w.*(fC + b) - d);
        dv = v .*(w.*(fD + b) - d);
end

end

 