clear;
clc;
close all;

T1   = 1.471;  % myocadium @ 3T in second
T2   = .0470;  % myocadium @ 3T in second
TR   = 4.7e-3; % in second

N = 96;
a = pi/N;
Nrep = 2;
Nrf  = Nrep*N;
Npre = 100;
n = 0:Nrf-N/2-2;

FAmax  = 60;
FAinit = 28.4204; % default = 28.4204
vfa = (FAmax - FAinit)*abs(sin(a*n)) + FAinit;
vfa = [42.6824 vfa FAmax*ones(1,N/2)];

figure(1), subplot(121),plot(vfa);

xpre = deg2rad(FAmax)*ones(1, Npre);
cfa  = deg2rad(FAmax)*ones(1, Nrf);

vfa  = [xpre deg2rad(vfa)];
cfa1 = [xpre cfa];
cfa2 = deg2rad(47)*ones(1,Npre+Nrf);


vfaI = epg_bssfp(vfa, T1, T2, TR);
cfaI = epg_bssfp(cfa1, T1, T2, TR);

figure(1), subplot(122),plot(vfaI);
hold on; plot(cfaI);

fprintf('SAR of constant flip angle = 60(deg): %4.4f\n', cfa1(1, Npre + 1:end)*cfa1(1, Npre + 1:end)');
fprintf('SAR of variable flip angle = xx(deg): %4.4f\n', vfa(1,  Npre + 1:end)* vfa(1, Npre + 1:end)');
fprintf('SAR of constant flip angle = 47(deg): %4.4f\n', cfa2(1, Npre + 1:end)*cfa2(1, Npre + 1:end)');