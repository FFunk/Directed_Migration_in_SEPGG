function [ JI ] = getJ( u,v,b,d,r,N )
    w = 1 - u - v;
    term1fD = r* (1./(u+v).^2) .*( 1- 1/N * sum((w).^(0:(N-1))));
    term2fD =  r * (u./(u+v)) * 1/N .* sum((1:N-1).*((w).^(0:(N-2))));
    dfDdu = term1fD .* v     + term2fD;
    dfDdv = term1fD .*(-u)   + term2fD;
    
    dFds = - (r-1)* (N-1) * (w)^(N-2) + r/N * sum((1:N-1).*((w).^(0:(N-2))));
    JI = zeros(2,2);
    JI(1,1) = -u * d/w + u * w * (dfDdu - dFds);
    JI(1,2) = -u * d/w + u * w * (dfDdv - dFds);
    JI(2,1) = -v * d/w + v * w * dfDdu;
    JI(2,2) = -v * d/w + v * w * dfDdv;
end


