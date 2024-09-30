% bSSFP: repoduce Fig.5. in Ref[1] in order to test the bSSPF implemented 
% by EPG codes.
%
% Referece:
%
% [1].Klaus Scheffler et al. Principle and applications of balanced SSFP
%     techniques. Eur Radiol(2003)12:2409-2418
%
%

clc
clear
close all


T1 = [.50, .50, .50, .50];   % in second
T2 = [.50, .20, .10, .05];   % in second

TR   = 5e-3;    % in second
Nrf  = 200 ;    % #RF pulses for sampling
Nprf = 200 ;    % #RF pulses for steady state

FlipAng = [1:10:180];

N = length(T1);
L = length(FlipAng);
SSI_epg = zeros(Nrf+Nprf, L, N);
SSI_eqn = zeros(L,N);


for i = 1:L
    for j = 1:N
    % epg
    SSI_epg(:,i,j) = myCFAbSSFP(T1(j), T2(j), TR, deg2rad(FlipAng(i)), Nrf, Nprf);

    % equation
    SSI_eqn(i,j) = bssfpFunc(1, T1(j), T2(j), TR, deg2rad(FlipAng(i)), 2);
    end
end



figure(1), subplot(121),
plot(FlipAng, SSI_epg(end,:,1)); hold on;
plot(FlipAng, SSI_epg(end,:,2)); 
plot(FlipAng, SSI_epg(end,:,3)); 
plot(FlipAng, SSI_epg(end,:,4)); hold off;
legend('T1/T2=500/500 ms', 'T1/T2=500/200ms', 'T1/T2 = 500/100ms', 'T1/T2 = 500/50ms')
xlabel('Flip Angles \alpha'); ylabel('Steady State Intensity (SSI)');

subplot(122),
plot(FlipAng, SSI_eqn(:,1)); hold on;
plot(FlipAng, SSI_eqn(:,2)); 
plot(FlipAng, SSI_eqn(:,3)); 
plot(FlipAng, SSI_eqn(:,4)); hold off;
legend('T1/T2=500/500 ms', 'T1/T2=500/200ms', 'T1/T2 = 500/100ms', 'T1/T2 = 500/50ms')
xlabel('Flip Angle \alpha'); ylabel('Steady State Intensity (SSI)');
