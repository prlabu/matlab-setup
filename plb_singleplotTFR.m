function plb_singleplotTFR(cfg, TF)
% global SUBJECT TASK TLOCK SESSION TBASEL

figure; hold on; 

% BML_SINGLEPLOTTFR is a thin wrapper over ft_singleplotTFR
% 
% cfg.events - table with events to be marked as vertical lines
% cfg.bands - indicates if cannonical bands should be indicated
%

% if ~isfield(cfg,'channel') || isempty(cfg.channel)
%   error('channel required');
% end

if ~isfield(cfg,'baseline') || isempty(cfg.baseline)
  error('baseline required');
end

if ~isfield(TF,'freq') || isempty(TF.freq)
  error('data.freq required');
end

events           = bml_getopt(cfg,'events',table());
bands            = bml_getopt(cfg,'bands',bml_get_canonical_bands());

statmask = bml_getopt_single(cfg, 'statmask', 'no');
savefig = bml_getopt_single(cfg, 'savefig', 'yes');



cfg.parameter = 'powspctrm'; % what fieldtrip will look to plot

% bml_singleplotTFR(cfg_tmp, ft_freqdescriptives([], TF));
% bml_singleplotTFR(cfg, TF);


cfg.ylim         = bml_getopt_single(cfg,'ylim','maxmin');
cfg.colorbar     = bml_getopt_single(cfg,'colorbar','yes');
cfg.baselinetype = bml_getopt_single(cfg,'baselinetype','db');


cfg.showlabels   = 'no';	
cfg.showscale    = 'no';
cfg.box          = 'no';
cfg.masknans     = 'yes';

% %nyticks          = bml_getopt(cfg,'nyticks',5);
% foi              = data.freq;
% foi_idx          = 1:length(data.freq);
% data.freq        = foi_idx;

toilimbands      = [min(TF.time) max(TF.time)];

cfg.colorbar     = bml_getopt(cfg,'colorbar','yes');

cfg.showlabels   = 'no';	
cfg.showscale    = 'no';
cfg.box          = 'no';
cfg.masknans     = 'yes';

if strcmp(statmask, 'yes') 
    stat = TF.stat; % have to save this separately since FT functions remove the field
end


%% Plot with imagesc

TF = ft_freqdescriptives([], TF);

TF = ft_freqbaseline(cfg, TF); 

imagesc(TF.time, flip(TF.freq), flipud(squeeze(TF.powspctrm)));
set(gca, 'ydir', 'normal');
set(gca, 'yscale', 'log'); 

ticks_wanted = [4,8,12,30,60,120,250];
yticks(ticks_wanted); yticklabels(ticks_wanted);

xline(0, 'LineWidth', 3); 


% add stat countours to the plot
if strcmp(statmask, 'yes') % plot statistically significant areas
    contour(TF.time, TF.freq, squeeze(stat), 1, 'LineWidth', 3, 'Color', 'k'); 
end




% ft_singleplotTFR(cfg, );

% set(gca,'ytick',[])
% set(gca,'yticklabel',[])

% polycoeff = polyfit(log10(foi),foi_idx,1);

% if ~isempty(bands)
%   hold on
%   fstarts_idx = polyval(polycoeff,log10(max(bands.fstarts,min(foi))));
% 	fends_idx =  polyval(polycoeff,log10(min(bands.fends,max(foi))));
%   %fstarts_idx = dsearchn(foi',bands.fstarts)-0.5;
% 	%fends_idx = dsearchn(foi',bands.fends)+0.5;
%   midpoint_idx = 0.5.*(fstarts_idx + fends_idx);
%   yyaxis right
%   yticks(midpoint_idx)
%   yticklabels(bands.symbol)
% 	for i=1:height(bands)
%     fill(toilimbands(2) .* [1,1.05,1.05,1],...
%          [fstarts_idx(i),fstarts_idx(i),fends_idx(i),fends_idx(i)],...
%          hex2rgb(bands.color(i)),'EdgeColor','black','Marker','none');
%   end
% end
% 
% foi_ticks_wanted = [round(min(foi),1),4,8,12,30,60,120,250];
% foi_ticks_idx = polyval(polycoeff,log10(foi_ticks_wanted));
% 
% yyaxis left
% yticks(foi_ticks_idx)
% yticklabels(round(foi_ticks_wanted,2,'signif'))

% hold on
% if ~isempty(events)
%   if ~ismember('color',events.Properties.VariableNames)
%     events.color(:)={'#444444'};
%   end
% 	if ~ismember('starts_color',events.Properties.VariableNames)
%     events.starts_color=events.color;
%   end
% 	if ~ismember('ends_color',events.Properties.VariableNames)
%     events.ends_color=events.color;
%   end
%   if ~ismember('linestyle',events.Properties.VariableNames)
%     events.linestyle(:)={'-'};
%   end
% 
%   for i=1:height(events)
% 
%     if ~ismissing(events.starts_color(i))
%       plot(repmat(events.starts(i),[1,2]),[min(foi_idx)-0.5,max(foi_idx)],...
%         'Color',hex2rgb(events.starts_color{i}),'LineStyle',events.linestyle{i},...
%         'Marker','none');
%       if ismember('starts_error',events.Properties.VariableNames) && ~isnan(events.starts_error(i))
%         errorbar(events.starts(i),max(foi_idx),events.starts_error(i),'horizontal',...
%           'Color',hex2rgb(events.starts_color{i}),'Marker','none','CapSize',4)
%       end
%     end
%     if ~ismissing(events.ends_color(i))
%       plot(repmat(events.ends(i),[1,2]),[min(foi_idx)-0.5,max(foi_idx)],...
%         'Color',hex2rgb(events.ends_color{i}),'LineStyle',events.linestyle{i},...
%         'Marker','none');
%       if ismember('ends_error',events.Properties.VariableNames) && ~isnan(events.ends_error(i))
%         errorbar(events.ends(i),max(foi_idx),events.ends_error(i),'horizontal',...
%           'Color',hex2rgb(events.ends_color{i}),'Marker','none','CapSize',4)
%       end 
%     end
%   end
% end
% 
% 
% 
% 




colormap(flipud(cbrewer2('RdBu')));
hC = colorbar;
cl = get(gca, 'clim');
% clim(min(abs(cl))*[-1 1]);
if string(cfg.zlim)=="auto"
    prc = prctile(abs(TF.powspctrm(:)), 80); 
    clim([-prc, prc]); 
else 
clim(cfg.zlim); % or set zlim
end
% caxis([-5 5]);

if strcmp(cfg.baselinetype, 'db')
cfg.zlabel = '[dB] Power wrt baseline';
elseif strcmp(cfg.baselinetype, 'relchange')
cfg.zlabel = '% change wrt baseline';
elseif strcmp(cfg.baselinetype, 'zscore')
cfg.zlabel = 'z-score wrt baseline';
else 
cfg.zlabel = '';
end
hC.Label.String = cfg.zlabel;
ylim([4 200]);

title(gca, cfg.title, 'Interpreter','none');
xlabel(cfg.xlabel);
ylabel(cfg.ylabel); 
xlim(cfg.xlim);

% xlim([TBASEL(1) toi(2)]);
% rectangle('position', [TBASEL(1) 0 diff(TBASEL) diff(ylim())], 'FaceColor', 'w', 'EdgeColor', 'none')


set(gca, 'Layer', 'top')
box on

if strcmp(savefig, 'yes')
export_fig(cfg.path, '-m3',gcf);
% close(gcf);
end



end
