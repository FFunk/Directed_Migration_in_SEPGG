b = 1;
d = 1.2;
r = 2.4;
N = 8;
L = 75; 

f = figure;

sampMax = 5 * 10^1;
sampMin = 1;
%%      

DC = 0.1;
DD = 0.5;
AC = 0;
AD = 0;
RC = 0;
RD = 0;

[u0,v0] = getEquilibrium(b,d,r,N); 
J = getJ(u0,v0,b,d,r,N);

K = (sampMin:1/50:sampMax) * pi/L;
lenK = length(K);


colorInd = 1;
val = [0,2,4];
colorMax = 3;
ColorSet = [0 0 1; 1 0 1; 1 0 0]; 

offset = 0.1;

%Dispersion relation - change AC/AD/RC/RD to check.
for RD = val
    
    lamb = zeros(lenK,1);
    
        ind = 1;
        for k = K
            disp(k)
            JS = getJSpatial(u0,v0,DC, DD, AC, AD, RC, RD, L, k);
            [~,D] = eig(J + JS);
            d = real(diag(D));
            lamb(ind) = max(d);
            ind = ind +1;
        end


    loglog(K,- offset + lamb,'Color', ColorSet(colorInd,:))
    colorInd = colorInd +1;
    hold on

end
ylabel(sprintf("Largest Real Eigenvalue Component - %1.1f",offset))
xlim([sampMin,sampMax]*pi/L);
ylim(-[1,5* 10^(-2)])
colormap(ColorSet) 
caxis([valMin valMax])

loglog(K,-offset + 0*lamb,'k--')

%% you have to take care of scaling for this function for the result to make
% sense: *pi/L  

function JS = getJSpatial(u0,v0,DC, DD, AC, AD, RC, RD, L, k)
w0 = 1 - u0 - v0;
K  = (k)^2;
JS = 2*K*[u0 *w0* AC - DC, - u0 * w0 * RC ; AD * v0 * w0, -v0 * w0 * RD - DD];
end
