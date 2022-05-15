function [hA] = pretty_lims(hA, varargin)


% SET defaults
opts.isPrettyX = true;
opts.isPrettyY = true;
% 
opts = get_function_options(opts, varargin);

if length(hA)<2
    hA = [hA];
end

for ihA = 1:length(hA)
    
    axes(hA(ihA));
    ax = gca;

    if opts.isPrettyY
        yl = yticks();
        yticks([yl(1) yl(end)]);
        yticklabels('auto');
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
        xticklabels('auto');
        xlim([xl(1) xl(end)]);
    end

    ax.TickLength = [0.01 0.01];

end

end

