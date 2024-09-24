clear
clc;
close all

% ==========================
% Two aims:
%   (1) less SAR;
%   (2) keep steady state
%


T1 = 1.1; % s
T2 = .04; % s
TR = 4.7e-3; % s
N_dumpPulSeq = 200;
N_samp   = 200;
s_target = 0.18;
Nss      = 24;
FAmax    = 60/180*pi;

P = zeros(3, 2*(N_samp + N_dumpPulSeq));
P(3,1) = 1;
s = zeros(N_dumpPulSeq+N_samp,1);

vfa = createVFA(pi/6, FAmax, N_samp);
st = zeros(1, N_samp);
st(1) = 1/2*(1 - exp(-TR/T1) + s_target);
for i = 2: N_samp
    st(i) = 1/2*(st(i-1) + s_target);
end

% dump pulse...
for k = 1:N_dumpPulSeq
    P = epg_grelax(P, T1, T2, TR);
    P = epg_rf(P, pi/6, pi/2); % do 30 tip
    s(k,1) = P(1,1);
end

figure(1), plot(abs(s(1:N_dumpPulSeq)))

% sampling 
for i = 1:N_samp
    
    P = epg_grelax(P, T1, T2, TR);
    P = epg_rf(P, vfa(i), pi/2);
    s(N_dumpPulSeq + i, 1) = P(1,1);
end



figure(2),plot(abs(vfa)/pi*180,'','LineWidth',2);
vFA = abs(vfa)/pi*180;
legend('Flip angle');
set(gca, 'FontSize', 19);
box on

figure(3), plot(abs(s1)); 

