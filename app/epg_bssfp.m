function Iss = epg_bssfp(FAs, T1, T2, TR)
% function Iss = myVFAbSSFP(x, T1, T2, TR, FAinit, Npref)
%
% [Aim]: simulate the signal intensity of bSSFP steady state with given
% constant flip anlge
%
% Input:
%   cfa: Flip angles vector
%   T1: T1 value of given tissue
%   T2: T2 value of given tissue
%   TR: TR interval in second

%
% Output:
%   Iss: the final signal for each of rf.

Nrf = length(FAs);

P = zeros(3, 2*Nrf);
P(3,1) = 1;
Iss = zeros(Nrf,1);

for k = 1:Nrf   
    P = epg_grelax(P, T1, T2, TR);
    P = epg_rf(P, FAs(k), pi/2); 
    M = epg_FZ2spins(P);

    Iss(k,1) = M(1,1) + M(2,1)*1i;
end

Iss = abs(Iss)*4*Nrf;

end