function [ h ] = imPlot( t,X1,X2,U,V, L )
%SPLOT Creates a surfaceplot of cooperator and defector densities.
m = size(U,1);
u = matr2vec(U);
v = matr2vec(V);

hue = 1/3 * U./(U+V); %1/3 for transformation into hue.
val = min(1.2* sqrt(U+V),1);
sat = ones(size(U));
HSV = cat(3,hue,sat,val);
RGB = hsv2rgb(HSV);

h = image(RGB);
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

title(sprintf("t = %3.0f",t))
hold off;

end

