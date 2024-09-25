function  delI = myObjFunc(x, T1, T2, TR, FAinit, Nrf)
% function delI = myObjFunc(x, T1, T2, TR, FAinit, Nrf)
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
%
% Output:
%   delI: signal intensity differences between VFA and CFA 
%

    vfaI = abs(myVFAbSSFP(x, T1, T2, TR, FAinit, Nrf));
    cfaI = abs(myCFAbSSFP(T1, T2, TR, FAinit, Nrf));

    delI = sum((vfaI(end-Nrf + 1: end) - cfaI(end-Nrf + 1:end)).^2);
end