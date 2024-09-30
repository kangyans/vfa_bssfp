clc
clear
close all

T1   = 1.471;  % myocadium @ 3T in second
T2   = .0470;  % myocadium @ 3T in second
TR   = 4.7e-3; % in second
Nrf  = 400;    % #RF pulses for sampling
Nprf = 200;    % #RF pulses for steady state
FAinit = deg2rad(80);
FAmax  = deg2rad(180);
cfa    = deg2rad(47)*ones(Nrf, 1);

x0 = FAinit*ones(Nrf,1);
lb = zeros(Nrf, 1);
ub = FAmax*ones(Nrf, 1);
nonlcon = @(x)SARcon(x, cfa, FAinit, Nprf);
vfa     = fmincon(@(x)myObjFunc(x, T1, T2, TR, cfa(1), Nrf, Nprf), x0, [], [], [], [], lb, ub, nonlcon);

writematrix(rad2deg(vfa), 'vfa.txt','Delimiter','tab');

vfaI = myVFAbSSFP(vfa, T1, T2, TR, FAinit, Nrf, Nprf);
cfaI = myCFAbSSFP(T1, T2, TR, FAinit, Nrf, Nprf);

figure(1), 
subplot(121),plot(rad2deg(vfa));xlabel('#Interleaves'); ylabel('Flip Angle (deg)'); title('Estimated VFA');
subplot(122), plot(cfaI); hold on, plot(vfaI); hold off;legend('Signal of CFA', 'Signal of VFA');
xlabel('#Interleaves'); ylabel('Signal Intensity'); title('Signal Evoluation')
fprintf('The SAR for VFA is %4.2f; The SAR for CFA is %4.2f\n', vfa'*vfa, cfa'*cfa)


function [c, ceq] = SARcon(x, cfa, FAinit, Nprf)
    c = x'*x - (cfa'*cfa) + Nprf*(FAinit.^2 - cfa(1).^2);
    ceq = [];
end

