function [ u2, v2 ] = reactDiffAdv(u0, v0, rParam, dParam, aParam, discrParam)
%REACTDIFFADV computes the next time step.

    b = rParam.b;
    d = rParam.d;
    r = rParam.r;
    N = rParam.N;
    
    DC = dParam.DC;
    DD = dParam.DD;
    
    AC = aParam.AC;
    AD = aParam.AD;
    RC = aParam.RC;
    RD = aParam.RD;
    
    L = discrParam.L;
    m = discrParam.m;
    n = discrParam.n;
    dt = discrParam.dt;
       
    h = L/m;

    [reaU, reaV] = react(u0,v0);   
    [difU, difV] = diff(u0,v0);
    [advU, advV] = advect(u0,v0);
    

    
    u2 = u0 + dt * reaU + dt/h^2 *(difU + advU); %Forward Euler Step
    v2 = v0 + dt * reaV + dt/h^2 *(difV + advV); %Forward Euler Step
    
    
%% utility

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
        fD =  r*(u./(u+v)) .* (1- 1/N * q ) ; %Average payoff from game
        fC =  fD - F;
        du = u .*(w.*(fC + b) - d);
        dv = v .*(w.*(fD + b) - d);
        end
 
    function [ du, dv ] = diff( u,v )
        %DIFFU RHS of the diffusion part.
        %Diffuses u and v.
        assert(m == n)
        
        U = vec2matr(u,m,n);
        V = vec2matr(v,m,n);
        
        idx = [m,1:(m-1)];
        idx2 = [2:m,1];
        
        DU = - 4*U + U(idx,:) + U(:,idx) + U(idx2,:) + U(:,idx2);
        DV = - 4*V + V(idx,:) + V(:,idx) + V(idx2,:) + V(:,idx2);
        
        du = matr2vec(DC*DU);
        dv = matr2vec(DD*DV);
    end

    function [du,dv] = advect(u, v)
        % Calculates the directed movement components.
        DU = zeros(m,n);
        DV = zeros(m,n);
        
        U = vec2matr(u,m,n);
        V = vec2matr(v,m,n);
        W = 1 - U - V;
        
        idx = [2:m,1]; %This will evoke swaps to right/below
        idy = [m, 1:(m-1)]; %This will evoke swaps to left/top

        % Using central differences and laplace stencil to discretize
        % the involved spatial differentials: -(uw u_x)_x = - (uw)_x u_x -
        % (uw) u_xx
        
        DU = DU - ...
            (U(idx,:).*W(idx,:) - U(idy,:).*W(idy,:)) .* ...
            (AC/4 * (U(idx,:)-U(idy,:) - RC/4 * (V(idx,:)- V(idy,:)))) ...
            - U.*W .* ...
            (AC* (U(idx,:)-2*U+U(idy,:)) - RC* (V(idx,:)-2*V+V(idy,:)));

        DU = DU - ...
            (U(:,idx).*W(:,idx) - U(:,idy).*W(:,idy)) .* ...
            (AC/4 * (U(:,idx)-U(:,idy) - RC/4 * (V(:,idx)- V(:,idy)))) ...
            - U.*W .* ...
            (AC* (U(:,idx)-2*U+U(:,idy)) - RC* (V(:,idx)-2*V+V(:,idy)));
  
        DV = DV - ...
            (V(idx,:).*W(idx,:) - V(idy,:).*W(idy,:)) .* ...
            (AD/4 * (U(idx,:)-U(idy,:) - RD/4 * (V(idx,:)- V(idy,:)))) ...
            - V.*W .* ...
            (AD* (U(idx,:)-2*U+U(idy,:)) - RD* (V(idx,:)-2*V+V(idy,:)));

        DV = DV - ...
            (V(:,idx).*W(:,idx) - V(:,idy).*W(:,idy)) .* ...
            (AD/4 * (U(:,idx)-U(:,idy) - RD/4 * (V(:,idx)- V(:,idy)))) ...
            - V.*W .* ...
            (AD* (U(:,idx)-2*U+U(:,idy)) - RD* (V(:,idx)-2*V+V(:,idy)));       
           
             
        %Return to vectors.
        du = matr2vec(DU); 
        dv = matr2vec(DV);       
   
    end
       
end

