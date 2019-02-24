%Parameters:
b = 1;
d = 1.2;
r = 2.4;
N = 8;


AC = 0;
AD = 0;
RC = 0;
RD = 0;
DC = 0.1;
DD = 0.1;

dim1 = 100;
dim2 = 100;
unst = zeros(dim1,dim2);
irreg = zeros(dim1,dim2);

m = dim1;
n = dim2;
Xs = linspace(2.1,3,dim1);
Ys = linspace(0,2.5,dim2);

Xaxis = reshape(repmat(Xs',n,1),m*n,1);
Yaxis = reshape(repmat(Ys,m,1),m*n,1);
for ind1= 1:length(Xs)
    for  ind2 = 1:length(Ys)       
        r = Xs(ind1);
        AC = Ys(ind2);
        
        [u0,v0] = getEquilibrium(b,d,r,N);
        JI = getJ(u0,v0,b,d,r,N);
        w0 = 1 - u0 - v0;        
        JS = 2*[u0 *w0* AC - DC, - u0 * w0 * RC ; AD * v0 * w0, -v0 * w0 * RD - DD];
        R = JI(1,1)*JS(2,2) + JI(2,2)*JS(1,1) -JI(1,2) * JS(2,1) - JI(2,1) * JS(1,2);
        
        if det(JI)>0
            unst(ind1,ind2) = (-R > 2*sqrt(det(JS) * det(JI)));
            unst(ind1,ind2) = unst(ind1,ind2)&((JI(1,1)+JI(2,2) - R/(2*det(JS)) * (JS(1,1)+JS(2,2))<0));
        else
            unst(ind1,ind2) = (-R > 0);
        end
        
        irreg(ind1,ind2) = (AC *u0*w0 > DC);
    end
end
unst = logical(unst);
irreg = logical(irreg);
unst = unst&(~irreg);
c = ['g';'r'];
for k = [0,1]
    ind = find(unst == k);
    scatter(Xaxis(ind),Yaxis(ind),c(k+1))
    hold on
end
ind = find(irreg);
scatter(Xaxis(ind),Yaxis(ind),'k')


        