function [ v ] = matr2vec( S )
%MATR2VEC Takes matrix of spatial state S and transforms it into a vector
%v. The columns are stacked atop one another.

v = reshape(S, size(S,1)*size(S,2),1);


end

