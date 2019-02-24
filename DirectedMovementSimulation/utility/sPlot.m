function [ h ] = sPlot( t,X1,X2,U,V, L )
%SPLOT Creates a surfaceplot of cooperator and defector densities.
h = figure;

hold on
surf(X1,X2,U,...
    'FaceColor','g','AmbientStrength',.7,'EdgeAlpha',.1);
surf(X1,X2,V, ...
    'FaceColor','r','AmbientStrength',0.7,'EdgeAlpha',.1); 
%alpha 0.8
light('Position',[0 L 1],'Style','local')
xlim( [0 L] )
ylim( [0 L] )
zlim( [0 .6])
zlabel('u (green) and v (red)')
title(sprintf("t = %3.2f",t))
hold off;

end

