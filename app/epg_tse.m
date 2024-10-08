function s = epg_tse(flipangle, etl, T1, T2, esp)
% function s = epg_tse(flipangle, etl, T1, T2, esp)
% 
% A simple version of Brian Hargreaves's epg_cpmg
% 

if isempty(etl) == 1
    etl = length(flipangle);
end

if (isscalar(flipangle)) && (etl > 1) && (abs(flipangle) < pi)
    % -- 1st flip reduced trick (Hennig)
    flipangle(2) = flipangle(1);
    flipangle(1) = (pi*exp(1i*angle(flipangle(2))) + flipangle(2))/2;
end

if (etl > length(flipangle))
    flipangle(end+1:etl) = flipangle(end);
end

P = zeros(3, 2*etl);
P(3,1) = 1;

P = epg_rf(P, pi/2, pi/2);
s = zeros(1, etl);

for ech = 1:etl
    P = epg_grelax(P, T1, T2, esp/2, 1, 0, 1, 1);
    P = epg_rf(P, abs(flipangle(ech)), angle(flipangle(ech)));
    P = epg_grelax(P, T1, T2, esp/2, 1, 0, 1, 1);
    s(ech) = P(1,1);
end

