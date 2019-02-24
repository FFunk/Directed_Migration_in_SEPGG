function [h ] = redPlot(t,X1,X2,U,V, L )
%SPLOT Creates a surfaceplot of cooperator and defector densities.
m = size(U,1);
u = matr2vec(U);
v = matr2vec(V);

h = figure;
hold on;

hue = 1/3 * U./(U+V); %1/3 for transformation into hue.
val = 1.2* sqrt(U+V);
sat = ones(size(U));
HSV = cat(3,hue,sat,val);


RGB = hsv2rgb(HSV);

surf(X1,X2,U+V,RGB,...
    'AmbientStrength',.7,'EdgeAlpha',.1);
%alpha 0.8

light('Position',[0 L 1],'Style','local')
xlim( [0 L] )
ylim( [0 L] )
zlim( [0 .6])
zlabel('u (green) and v (red)')
title(sprintf("t = %3.2f",t))
hold off;

end

