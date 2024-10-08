function Mss = bssfpFunc(M0, T1, T2, TR, FA, eq)
% function Mss = bssfpFunc(M0, T1, T2, FA)
% 
% Input:
%   M0: proton density
%   T1: T1 value of selected tissue in second
%   T2: T2 value of selected tissue in second
%   FA: Flip angles in radius
%   TR: TR interval
%   eq: 1 - eq.(1); 2 - eq.(2);
% 
% Output:
%   Mss: Steady State Intensity
%

    if eq == 1
    % Original equation accroding to Eq.(1) in Ref[1]
        E1 = exp(-TR/T1);
        E2 = exp(-TR/T2);
        Mss = M0*sqrt(E2*(1-E1)*sin(FA))/(1 - (E1 - E2)*cos(FA) - E1*E2);
 
    elseif eq == 2
    % TR << T1, T2,so we can simplify as follows, accroding to Eq.(2)
    % in Ref[1]
        Mss = M0*sin(FA)/(1 + cos(FA) + (1-cos(FA))*(T1/T2));
    end
end