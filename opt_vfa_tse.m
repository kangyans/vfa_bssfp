clc; clear; close all;

etl    = 55          ;
T1     = 1200        ; % T1 of GM @ 3T, ms
T2     = 90          ; % T2 of GM @ 3T, ms    
esp    = 4.36        ; % s 
TR     = 3000        ; % s 
FAmax  = deg2rad(120);

Nx    = etl;
FOV   = 20 ;
beta  = 1  ;
alpha = 1.5;
dx = FOV/Nx;
dk = 1/FOV ; % nominal spatial resolution 
Ksamples = ([1:Nx] - (Nx+1)/2)*dk;
target = beta/2 * (1 + cos((2*pi*Ksamples*dx)/alpha));

lb = zeros(etl, 1);
ub = pi*ones(etl, 1);

[A, b, Aeq, beq] = deal([]);

x0 = deg2rad(100)*ones(etl, 1);

opt = optimset('MaxIter', 500, 'MaxFunEvals', 10^6, 'TolFun', 10^(-9));
vfa = fmincon(@(x)myTSE(x, etl, T1, T2, esp, target./sum(target)), x0, A, b, Aeq, beq, lb, ub, [], opt);

s  = epg_tse(vfa, etl, T1, T2, esp);
s0 = epg_tse(pi, etl, T1, T2, esp);



figure(1), 
subplot(121),plot(rad2deg(vfa));
xlabel('#Echo'); ylabel('Flip Angles')
axis([0 etl 0 180]); axis square

subplot(122), plot(abs(s0)); hold on;
plot(abs(s)); hold off;
xlabel('#Echo'); ylabel('Signal (a.u.)')
axis square