function  loss = myObjFunc(x, T1, T2, TR, FAinit, Nrf, Nprf)
% function loss = myObjFunc(x, T1, T2, TR, FAinit, Nrf)
% 
% [Aim]: the objective function that keep the signal intensity of steady
% state same between variable flip angles and constant filp angles
%
% Input:
%   x: vector of flip angle
%   T1: T1 value of the tissue
%   T2: T2 value of the tissue
%   TR: TR interval
%   FAinit: initial FAs
%   Nrf: the number of RF pulses
%   Nprf: the number of dump RF pulses required to promise steady state
%
% Output:
%   loss: signal intensity differences between VFA and CFA 
%
    p = 2;
    SSI_vfa = myVFAbSSFP(x, T1, T2, TR, FAinit, Nrf, Nprf);
    SSI_cfa = myCFAbSSFP(T1, T2, TR, FAinit, Nrf, Nprf);

    loss = sum(abs(SSI_vfa(end-Nrf + 1: end) - SSI_cfa(end-Nrf + 1:end)).^p);
end