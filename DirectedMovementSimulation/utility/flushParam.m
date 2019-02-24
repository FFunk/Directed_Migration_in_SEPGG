function [ introString ] = flushParam( rParam, dParam, aParam, discrParam )
%FLUSHPARAM Summary of this function goes here
%   Detailed explanation goes here

    b = rParam.b;
    d = rParam.d;
    r = rParam.r;
    N = rParam.N;
    
    DC = dParam.DC;
    DD = dParam.DD;
    
    AC = aParam.AC;
    AD = aParam.AD;
    RC = aParam.RC;
    RD = aParam.RD;
    
    L = discrParam.L;
    m = discrParam.m;
    n = discrParam.n;
    dt = discrParam.dt;       
    dx = L/m;
    
    odeStr = sprintf(" # b = %f, \n # d = %f \n # r =%f \n # N = %f \n",b,d,r,N);
    diffStr = sprintf(" # DC = %f \n # DD = %f \n", DC, DD);
    advStr = sprintf(" # AC = %f \n # AD = %f \n # RC = %f \n # RD = %f", AC,AD,RC,RD);
    discrStr = sprintf(" # L = %f \n # m = %f \n # n = %f \n # dt = %f \n # dx = %f \n",L,m,n,dt,dx);
    introString = odeStr + diffStr + advStr + discrStr;
    

end

