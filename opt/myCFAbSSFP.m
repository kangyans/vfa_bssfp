function Iss = myCFAbSSFP(T1, T2, TR, FAinit, Nrf, Nprf)
% function Iss = myVFAbSSFP(x, T1, T2, TR, FAinit, Npref)
%
% [Aim]: simulate the signal intensity of bSSFP steady state with given
% constant flip anlge
%
% Input:
%   T1: T1 value of given tissue
%   T2: T2 value of given tissue
%   TR: TR interval in second
%   FAinit: the initial FA 
%   Nrf: the number of RF pulses
%   Nprf: the number of dump RF pulses required to promise steady state
%
% Output:
%   Iss: the final signal for each of rf.


P = zeros(3, 2*(Nrf + Nprf));
P(3,1) = 1;
Iss = zeros(Nprf+Nrf,1);

% dump pulse...
for k = 1:Nprf + Nrf   
    P = epg_grelax(P, T1, T2, TR);
    P = epg_rf(P, FAinit, pi/2);
    M = epg_FZ2spins(P);
    Iss(k,1) = M(1,1) + M(2,1)*1i;
end

Iss = abs(Iss)*4*(Nprf + Nrf);

end