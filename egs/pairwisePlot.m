% measures =   {'SPL', 'Aflow', 'Press', 'VE'};
% measures =         {'SPL', 'Aflow', 'Press', 'VE', 'VAAR1', 'VAAR2', 'VAAR3'};
% measures =         {'SPL', 'Aflow', 'Press', 'MPT'};
measures =         {'VRQOL', 'CapevSeverity', 'SPL', 'Aflow', 'Press', 'MPT', 'VE', 'SPLtoAP', 'SPLtoPs', 'SPLtoAflow'};
measuresTitle =    {'VRQOL', 'CAPEV',         'SPL', 'AFLOW', 'Ps',    'MPT', 'VE', 'SPL/AP',  'SPL/Ps',  'SPL/AFLOW'};

% i = 1:6; 
% measures = measures(i);
% measuresTitle = measuresTitle(i);

close all;
hF = figure('position', [157         -11        1220         827]);

hA = tsubplot_wrapper(length(measures)-1, length(measures)-1, 'marg_bottom', 0.1, 'gap_h', 0.03, 'gap_v', 0.03, 'marg_left', 0.1);

il = 1; % loudness = Comf

for im = 2:length(measures)
    for im2 = 1:length(measures)-1
        axes(hA(im-1, im2)); 

        
        if any(strcmp(measures{im}, {'CapevSeverity', 'VRQOL', 'MPT'}))
            ydata = Patients.(['Diff_' measures{im}]);
        else
            ydata = Patients.(['Diff_' measures{im} '_' loudnesses{il}]);
        end
        
        if any(strcmp(measures{im2}, {'CapevSeverity', 'VRQOL', 'MPT'}))
            xdata = Patients.(['Diff_' measures{im2}]);
        else
            xdata = Patients.(['Diff_' measures{im2} '_' loudnesses{il}]);
        end
            

        
        idxs = ~any(ismissing([xdata ydata]), 2);
        [~, irmPre] = rmoutliers(xdata, 'quartiles');
        [~, irmPost] = rmoutliers(ydata, 'quartiles');
        idxs = idxs & ~irmPre & ~irmPost;
        
        xdata = xdata(idxs);
        ydata = ydata(idxs);
        
        fprintf('%s vs %s\n', measures{im2}, measures{im});
        hSc = scatter(xdata, ydata, [], 'k', 'filled');
        hSc.MarkerFaceAlpha = 0.3;

%         ylim([min(ydata) max(ydata)])
%         xlim([min(xdata) max(xdata)]);

        lH = line(xlim(), [mean(ydata) mean(ydata)], 'LineWidth', 1);
        lH.Color = [0 0 0 0.5]; hold on

        lH = line([mean(xdata) mean(xdata)], ylim(), 'LineWidth', 1);
        lH.Color = [0 0 0 0.5]; hold on
        
        [rho, pval] = corr(xdata, ydata);
        [hS] = sigstar({[1 2]}, pval);
        t = hS(2).String;
        if ismember('n.s.', t); t = ''; end
        title(sprintf('%0.2f %s', rho, t), 'fontsize', 12);
        
        delete(hS);
        
        if im2==1
            ylabel(measuresTitle{im});
        end
        
        if im==length(measures)
            xlabel(measuresTitle{im2});
        end
        
%         xticklabels([]);
%         yticklabels([]);
    end
end

% normalize axes for rows
for ir = 1:size(hA, 1)
    lims = get(hA(ir, :), 'ylim');
    low = min(cellfun(@min, lims));
    high = max(cellfun(@max, lims));
    set(hA(ir, :), 'ylim', [low high]);
end

measure = 'SPLtoAP';
yl = [0 0.1]; % hardcoded ylim for some variables
irow = find(strcmp(measures, measure)) - 1;
set(hA(irow, :), 'ylim', yl);

measure = 'VE';
yl = [0 0.2]; % hardcoded ylim for some variables
irow = find(strcmp(measures, measure)) - 1;
set(hA(irow, :), 'ylim', yl);


set(hA(:, 2:end), 'yticklabels', []);
set(hA(1:end-1, :), 'xticklabels', []);
set(hA, 'box', 'on', 'layer', 'top')

% DELETE upper triangle of plot
delete(hA(triu(true(size(hA)), 1)))

%
file = [];
file.Analysis = [char(datetime('today')) ' PreVsPost Pairwise Correlations'];
file.Root = ['..' filesep 'Analysis' filesep file.Analysis filesep];
if ~exist(file.Root, 'dir'); mkdir(file.Root); end
file.Ext = '.tiff'; 

file.Name = ['postMinusPre-pairwise-corr_measures-' strjoin(measures, '-')]; 
exportgraphics(gcf, [file.Root file.Name file.Ext]);