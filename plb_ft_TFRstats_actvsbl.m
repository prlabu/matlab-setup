function TF = plb_ft_TFRstats_actvsbl(cfg, TF)

% required: 
% cfg.
% .baseline [beg end]
% .toi_plot [beg end]

perm_duration = diff(cfg.baseline); % FT requires the two TFs to be the same duration

cfg.latency = cfg.baseline(1) + [0 perm_duration];
TF_baseline = ft_selectdata(cfg, TF);


cfg_statsig = [];
cfg_statsig.channel          = 'all';
cfg_statsig.latency          = 'all';
cfg_statsig.method           = 'montecarlo';
cfg_statsig.frequency        = 'all';
cfg_statsig.statistic        = 'ft_statfun_actvsblT';
cfg_statsig.correctm         = 'cluster'; % 'fdr', 'cluster';
cfg_statsig.clusteralpha     = 0.05;
cfg_statsig.clusterstatistic = 'maxsum';
cfg_statsig.minnbchan        = 0;
cfg_statsig.tail             = 0;
cfg_statsig.clustertail      = 0;
cfg_statsig.alpha            = 0.025;
cfg_statsig.numrandomization = 500;

ntrials = size(TF_baseline.powspctrm,1);
design  = zeros(2,2*ntrials);
design(1,1:ntrials) = 1;
design(1,ntrials+1:2*ntrials) = 2;
design(2,1:ntrials) = [1:ntrials];
design(2,ntrials+1:2*ntrials) = [1:ntrials];

% error('This design matrix needs to be rewritten for within-subjects analysis')
cfg_statsig.design   = design;
cfg_statsig.ivar     = 1;
cfg_statsig.uvar     = 2;

TF.stat = false([1, size(TF.powspctrm, 3:4)]); % should be freq x time
twins = [0 perm_duration] + (cfg.toi_plot(1):perm_duration:cfg.toi_plot(2))';
% twins = [0 perm_duration] + (0:perm_duration:1)';
for iwin = 1:height(twins)
    disp(['Analyzing time window ' iwin '/' height(twins)]);

    cfg_activ = [];
    cfg_activ.latency = twins(iwin, :);
    TF_activation = ft_selectdata(cfg_activ, TF);
    
    TF_baseline.time = TF_activation.time;

    [stat] = ft_freqstatistics(cfg_statsig, TF_activation, TF_baseline);
    
    idxs = TF.time > twins(iwin, 1) & TF.time <= twins(iwin, 2); 
    TF.stat(:,:, idxs) = stat.mask(1, :, 1:end-1); % not sure why, but stat.mask has an extra index
end


