function Iss = myCFAbSSFP(T1, T2, TR, FAinit, Nrf)
% function Iss = myVFAbSSFP(x, T1, T2, TR, FAinit, N_samp)
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
%
% Output:
%   Iss: the final signal for each of rf.

N_dumpPulSeq = 200;

P = zeros(3, 2*(Nrf + N_dumpPulSeq));
P(3,1) = 1;
Iss  = zeros(N_dumpPulSeq+Nrf,1);

% dump pulse...
for k = 1:N_dumpPulSeq + Nrf
    P = epg_grelax(P, T1, T2, TR);
    P = epg_rf(P, FAinit, pi/2); % do 30 tip
    Iss(k,1) = P(1,1);
end

Iss = abs(Iss);

end