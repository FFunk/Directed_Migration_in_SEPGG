function [ RGB ] = imPlotRaw( U,V )
%SPLOT Outputs the RGB version to color image.

hue = 1/3 * U./(U+V); %1/3 for transformation into hue.
val = min(1.2* sqrt(U+V),1);
sat = ones(size(U));
HSV = cat(3,hue,sat,val);
RGB = hsv2rgb(HSV);

end

