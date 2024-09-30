% simulation myocardium/blood contrast

clear
clc
close all

T1 = [1.471, 1.932]; % {myocardium, flowing blood} in second
T2 = [0.047, 0.275]; % {myocardium, flowing blood} in second


TR   = 5e-3;    % in second
Nrf  = 200 ;    % #RF pulses for sampling
Nprf = 200 ;    % #RF pulses for steady state

FlipAng = [1:180];

N = length(T1);
L = length(FlipAng);
SSI_epg = zeros(Nrf+Nprf, L, N);
SSI_eqn = zeros(L,N);


for i = 1:L
    for j = 1:N
        % equation
        SSI_eqn(i,j) = bssfpFunc(1, T1(j), T2(j), TR, deg2rad(FlipAng(i)), 2);
    end
end

figure(1), plot(FlipAng,SSI_eqn(:,1)); hold on;
plot(FlipAng,SSI_eqn(:,2)); hold off;
xlabel('Flip Angle \alpha'); ylabel('Steady State Intensity (SSI)');
legend('myocardium','flowing blood')
