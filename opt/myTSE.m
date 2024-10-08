function [c,ceq, GC, GCeq] = myTSE(x, etl, T1, T2, esp, target)
    s    = epg_tse(x, etl, T1, T2, esp);
    filt = target./abs(s);
    SNR  = 1/sum(filt.^2);
    c    = -SNR;
    ceq  = [];
    GC   = [];
    GCeq = [];
end