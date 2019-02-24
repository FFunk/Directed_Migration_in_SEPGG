function [ U, V, X1, X2 ] = initialState( init, m, n, L)
%INITIALSTATE Takes an integer and returns an initial state. I follow Prof.
%Christoph Hauert's EvoLudo notation to not unnecessarily confuse myself.
%Implemented initial conditions are:
% 0: Randomized
% 5: Gaussian Initial Condition
% 6: Noise Overlay
% Returns state matrices cooperator and defector frequencies.

X1 = ones(n,1)* (1:m) / m * L;
X2 = (1:n)' * ones(1,m) / n * L;

uSpread = 16;
vSpread = 16; 
uBonus = 1/4;
vBonus = 1/4;
switch init
        
        
    case 5
        U = uBonus * exp(  - ((X1 - L/2 )/uSpread ).^2 - ((X2 - L/2 )/uSpread ).^2 );
        V = vBonus * exp(  - ((X1 - L/2 )/vSpread ).^2 - ((X2 - L/2 )/vSpread ).^2 );
    case 6 
        U = uBonus * exp(  - ((X1 - L/2)/uSpread ).^2 - ((X2 - L/2 )/uSpread ).^2 ) + ...
            0.05 * rand(m,n);
        V = vBonus * exp(  - ((X1 - L/2)/vSpread ).^2 - ((X2 - L/2 )/vSpread ).^2 ) + ...
            0.05 * rand(m,n);
    case 7
        U = 1/5 * exp(  - ((X1 - L/2)/16 ).^2 - ((X2 - L/2 )/16 ).^2 );
        V = 1/5 * exp(  - ((X1 - L/2)/16 ).^2 - ((X2 - L/2 )/16 ).^2 );
            
    case 8
        U = 1/5 * exp(  - ((X1 - L/2)/16 ).^2 - ((X2 - L/2 )/16 ).^2 ) + ...
            0.05 * rand(m,n);
        V = 1/5 * exp(  - ((X1 - L/2)/16 ).^2 - ((X2 - L/2 )/16 ).^2 ) + ...
            0.05 * rand(m,n);
         
    otherwise 
        error("Wrong initial state")        
end
end



