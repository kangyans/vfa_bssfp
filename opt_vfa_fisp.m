clc
clear
close all

% (1). parameter setting
T1   = 1.471;  % myocadium @ 3T in second
T2   = .0470;  % myocadium @ 3T in second
TR   = 4.7e-3; % in second
Nrf  = 64 ;    % #RF pulses for sampling
Nprf = 150;    % #RF pulses for steady state

% (2). design PSF
Nx    = Nrf;
FOV   = 20 ;
beta  = 1  ;
alpha = 1.5;
dx = FOV/Nx;
dk = 1/FOV ; % nominal spatial resolution 
Ksamples = ([1:Nx] - (Nx+1)/2)*dk;
target = beta/2 * (1 + cos((2*pi*Ksamples*dx)/alpha));

% (3). Optimization
xpre = deg2rad(80)*ones(Nprf, 1);
x0 = pi/6*ones(Nrf,1);
lb = zeros(Nrf, 1);
ub = deg2rad(80)*ones(Nrf, 1);
opt = optimset('MaxIter', 500, 'MaxFunEvals', 10^6, 'TolFun', 10^(-9));
vfa  = fmincon(@(x)myFISP(x, xpre, T1, T2, TR, target./sum(target)), x0, [], [], [], [], lb, ub,[],opt);

writematrix(rad2deg(vfa), 'vfa.txt','Delimiter','tab');

vfaI = epg_bssfp(vfa, T1, T2, TR);
cfaI = epg_bssfp(cfa, T1, T2, TR);

figure(1), 
subplot(121),plot(rad2deg(vfa));xlabel('#Interleaves'); ylabel('Flip Angle (deg)'); title('Estimated VFA');
subplot(122), plot(cfaI); hold on, plot(vfaI); hold off;legend('Signal of CFA', 'Signal of VFA');
xlabel('#Interleaves'); ylabel('Signal Intensity'); title('Signal Evoluation')
fprintf('The SAR for VFA is %4.2f; The SAR for CFA is %4.2f\n', vfa'*vfa, cfa'*cfa)


