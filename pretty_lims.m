function [hA] = pretty_lims(varargin)


% SET defaults
opts.hA = gca; 
opts.isPrettyX = true;
opts.XTickLabels = {'', ''};
opts.isPrettyY = true;
opts.YTickLabels = {'', ''};
opts = get_function_options(opts, varargin);
% 

hA = opts.hA
if length(hA)<2
    hA = [hA];
end

for ihA = 1:length(hA)
    
    axes(hA(ihA));
    ax = gca;

    if opts.isPrettyY
        yl = yticks();
        yticks([yl(1) yl(end)]);
        yticklabels(opts.YTickLabels);
%         ylim([yl(1) yl(end)]);
        set(ax, 'TickDir', 'out'); 
        
        hyl = get(ax, 'ylabel');
        set(hyl, 'Units', 'normalized')
%         hyl.Position(1) = hyl.Position(1) - hyl.Position(1)*0.5;
        hyl.Position(1) = -0.05;
    end

    if opts.isPrettyX
        xl = xticks();
        xticks([xl(1) xl(end)]);
        xticklabels(opts.XTickLabels);
        xlim([xl(1) xl(end)]);
        
        hxl = get(ax, 'xlabel');
        set(hxl, 'Units', 'normalized')
%         hyl.Position(1) = hyl.Position(1) - hyl.Position(1)*0.5;
        hxl.Position(2) = -0.05;
    end

    ax.TickLength = [0.01 0.01];

end

end

