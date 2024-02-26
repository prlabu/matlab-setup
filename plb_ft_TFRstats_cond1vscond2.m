function stat = plb_ft_TFRstats_cond1vscond2(cfg, TF1, TF2)

% required: 
% cfg.
% .latency [beg end] time window over which to evaluate 

% cfg = [];

cfg.channel          = 'all';
cfg.method           = 'montecarlo';
cfg.frequency        = 'all';
% cfg.statistic        = 'ft_statfun_indepsamplesT';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster'; % 'fdr', 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 0;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;



subj = length(TF1);
design = zeros(2,2*subj);
for i = 1:subj
  design(1,i) = i;
end
for i = 1:subj
  design(1,subj+i) = i;
end
design(2,1:subj)        = 1;
design(2,subj+1:2*subj) = 2;

cfg.design   = design;
cfg.uvar     = 1;
cfg.ivar     = 2;

[stat] = ft_freqstatistics(cfg, TF1, TF2); 


    
% nrpts1 = size(TF1.powspctrm, 1); 
% nrpts2 = size(TF2.powspctrm, 1); 
% design = zeros(1,nrpts1 + nrpts2);
% design(1,1:nrpts1) = 1;
% design(1,(nrpts1+1):(nrpts1 + nrpts2)) = 2;
% cfg.design           = design;
% cfg.ivar             = 1;
% 
% [stat] = ft_freqstatistics(cfg, TF1, TF2);
% 
% TF1.stat = stat.mask; 

end


