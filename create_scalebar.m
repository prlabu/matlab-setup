function [hA] = create_scalebar(varargin)


% SET defaults
opts.hA = gca; 
opts.ColorMap = gray(64); 
opts.Range = [-1 1]; 
opts = get_function_options(opts, varargin);
% 

cmp = opts.ColorMap; 
lw = opts.Range(1);
hi = opts.Range(1);

figure('Position', [744   904    80   145]); 
for m = 1:size(cmp, 1)
%         A(n,:) = cm(saturate(round((i-range(1))/diff(range)*size(cm,1)),1,size(cm,1)),:,1);
%     n = n+1;

    patch(([m-1 m m m-1]),[0 0 1 1], cmp(m,:),'edgecolor','none')
end

xL = [1 size(cmp,1)];
xlim(xL);
set(gca,'YTick',[],'XTick',[xL(1) xL(end)])


pretty_lims('isPrettyY', false, 'XTickLabels', num2str([lw; hi], '%0.2f'));
hxl = xlabel('\bf β');
hxl.Position = [-0.05 0.5 0];
view([90 -90]);


% %% Get scalebar and write to file
% 
% hF = figure('Color','w','Position',[944   570   591    83]);
% hA = gca; 
% 
% for m = 1:size(byr64,1)
% %     patch([m-1 m m m-1]),[0 0 1 1],A(m,:),'edgecolor','none')
%     rectangle('Position',[m-1,1,1,1], 'FaceColor', byr64(m, :),'EdgeColor','none');
% end
% xlim([0, size(byr64,1)]);
% xticks(gca, [0, size(byr64,1)]);
% % set(gca,'YTick',[],'XTick',[scale(j,1) scale(j,end)])
% 
% xticklabels(gca, range * 100);
% yticks([]);
% 
% set(gca, 'box', 'on', 'layer', 'top', 'fontsize', 30)
% hXlbl = xlabel('BGA % Change');
% 
% set(hXlbl, 'units', 'normalized');
% pXlbl = get(hXlbl, 'position');
% pXlbl(2) = 0; % top of text aligned with axis lower border
% set(hXlbl, 'position', pXlbl);
% 
% figDir = sprintf('../figures/mema/');
% dir = [figDir sprintf('%s_win%03dms_smooth%03d/', fBasename, tW, sigma)];
% fileName = 'scalebar';
% figure(hF);
% export_fig([dir fileName],'-tif','-r300');

% print([dir fileName],'-dpdf');