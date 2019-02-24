function [ S ] = vec2matr( v, m, n )
%VEC2MATR Reconstructs matrix from vector given dimensions.
% Assumes v to be a column vector.
    assert(iscolumn(v))
    S = reshape(v', m, n);

end

