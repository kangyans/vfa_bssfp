clc
clear
close all

T1  = 1.1; % myocadial @ 3T in second
T2  = .04; % in second
TR  = 4.7e-3; % in second
Nrf = 200;
FAinit = pi/6;
FAmax  = 4*pi/9;

x0  = createVFA(FAinit, FAmax, Nrf);
cfa = FAinit*ones(Nrf, 1);
lb = zeros(Nrf, 1);
ub = FAmax*ones(Nrf, 1);
nonlcon = @(x)SARcon(x, cfa);
vfa  = fmincon(@(x)myObjFunc(x, T1, T2, TR, FAinit, Nrf), x0, [], [], [], [], lb, ub, nonlcon);

writematrix(vfa/pi*180, 'vfa.txt','Delimiter','tab');

vfaI = myVFAbSSFP(vfa, T1, T2, TR, FAinit, Nrf);
cfaI = myCFAbSSFP(T1, T2, TR, FAinit, Nrf);

figure(1), 
subplot(121),plot(vfa/pi*180);
subplot(122), plot(cfaI); hold on, plot(vfaI); hold off;
fprintf('The SAR for VFA is %4.2f; The SAR for CFA is %4.2f\n', vfa'*vfa, cfa'*cfa)


function [c, ceq] = SARcon(x, cfa)
    c = x'*x - 0.5*(cfa'*cfa);
    ceq = [];

end