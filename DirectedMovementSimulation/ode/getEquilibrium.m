function [ u0,v0 ] = getEquilibrium( b,d,r,N )
%GETEQUILIBRIUM This function returnsthe equilbrium of the ODE to eco publ
%good

%Calc w such that F(w) = 0

%Version 1:
% w0 = rand(1);
% [F,DF] = redFun(w0,r,N);
%     while norm(F,inf) > 10^(-10)
% 
%         w0 = w0 - F./DF;
%         [F,DF] = redFun(w0,r,N);
%     end
%     



w0 = 0.0001;

while abs(fun(w0)) > 10^(-4)
    w0 = w0 + 0.0001;
end

u0 = ((1-w0)/r).* (d./w0 - b) * 1./(1-1/N*sum(w0.^(0:(N-1)) ));
v0 = 1-w0-u0;

if(u0<0 | v0<0 | w0==1)
    warning('negEquilibrium');
    disp(u0)
    disp(v0)
end


    function F = fun(w)
        %calculating (1-w^N)/(1-w) = 1 + w +...+ w^(N-1) but more numerically stable
        q = 1;
        s = 1;
        for i= 1:(N-1)
            s = w.*s; %w^i
            q = q + s; % 1+ w + w^2 + ...
        end

        F = 1 + (r-1) * s - r/N * q; %Difference in payoff, coop to def
    end
end
