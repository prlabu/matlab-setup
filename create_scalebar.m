%% Get scalebar and write to file

hF = figure('Color','w','Position',[944   570   591    83]);
hA = gca; 
% step = 0.005;
% scale = [-scalelim:step:scalelim];%:-0.1; 0.1:step:0.3];
% j=1;
% % for j=1:2
% n=1;
% for i=scale(j,:)
%     A(n,:) = byr64(max(1,min(64,round((i-range(1))/diff(range)*64))),:);
%     n=n+1;
% end

% % subplot(1,2,j)
% for m = 2:size(scale,2)
%     patch(scale(j,[m-1 m m m-1]),[0 0 1 1],A(m,:),'edgecolor','none')
% end
% set(gca,'YTick',[],'XTick',[scale(j,1) scale(j,end)])

for m = 1:size(byr64,1)
%     patch([m-1 m m m-1]),[0 0 1 1],A(m,:),'edgecolor','none')
    rectangle('Position',[m-1,1,1,1], 'FaceColor', byr64(m, :),'EdgeColor','none');
end
xlim([0, size(byr64,1)]);
xticks(gca, [0, size(byr64,1)]);
% set(gca,'YTick',[],'XTick',[scale(j,1) scale(j,end)])

xticklabels(gca, range * 100);
yticks([]);

set(gca, 'box', 'on', 'layer', 'top', 'fontsize', 30)
hXlbl = xlabel('BGA % Change');

set(hXlbl, 'units', 'normalized');
pXlbl = get(hXlbl, 'position');
pXlbl(2) = 0; % top of text aligned with axis lower border
set(hXlbl, 'position', pXlbl);

figDir = sprintf('../figures/mema/');
dir = [figDir sprintf('%s_win%03dms_smooth%03d/', fBasename, tW, sigma)];
fileName = 'scalebar';
figure(hF);
export_fig([dir fileName],'-tif','-r300');
print([dir fileName],'-dpdf');