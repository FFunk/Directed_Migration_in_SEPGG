function [ converged ] = hasConverged( s, snext, genDelta,m )
%HASCONVERGED Check whether model has converged. Check between to
%successive generations whether the state has not changed significantly.
converged = (norm(s-snext,2)/ m^2 < 10^(-8)); 

end

