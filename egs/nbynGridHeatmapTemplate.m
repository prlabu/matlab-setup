file = [];
file.Analysis = [char(datetime('today')) ' Missing Data Co-ccurrences'];
file.Root = ['..' filesep 'Analysis' filesep file.Analysis filesep];
if ~exist(file.Root, 'dir'); mkdir(file.Root); end
file.Ext = '.tiff'; 


voi = Patients{:, 16:end}; % variables of interest
vnames = Patients.Properties.VariableNames(16:end);

ispres = ~ismissing(voi); 

% probability of occurrence matrix
P = zeros(length(vnames));

for iv = 1:length(vnames)
    % take all rows which are not missing for this variable
    ispresother = ispres(ispres(:, iv), :);

    P(iv, :) = sum(ispresother, 1) ./ height(ispresother);

end


close all
n = height(P);
figure('Position', [ 441    47   875   696]); imagesc(P); % Display correlation matrix as an image
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', vnames); % set x-axis labels
xtickangle(45);
set(gca, 'YTickLabel', vnames); % set y-axis labels
title('Probability of missing data', 'FontSize', 14); % set title
colormap(flipud(gray)); % Choose jet or any other color scheme
colorbar % 
daspect([1 1 1]);


file.Name = ['missing-data-co-occurrences-n' sprintf('%d', height(Patients))];
exportgraphics(gcf, [file.Root file.Name file.Ext]);
savefig(gcf, [file.Root file.Name]);