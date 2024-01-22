function [] = plot_bounded_line(t, y, sem, color, varargin)
% PLOT_HGACHANGE Summary of this function goes here
%   Detailed explanation goes here

% ---- handle varargin options ----- 
opts.hA =  [];
opts.ZerosGrid = false; % plot the x=0 and y=0 line? 
opts.LineWidth = 2; % plot the x=0 and y=0 line? 
opts.DisplayName = '';  % used for adding legends to plots. Set this to condition
opts.Sig = []; % significance (binary vector)
opts.SigTime = [];
opts = get_function_options(opts, varargin);
% ---- handle varargin options ----- 



if isempty(opts.hA); figure(); opts.hA = gca; end

hold(opts.hA, 'on');

curve1 = y + sem;
curve2 = y - sem;
x2 = [t, fliplr(t)];
inBetween = [curve1, fliplr(curve2)];
plot(opts.hA, t, y, 'Color', color, ...
        'LineWidth', opts.LineWidth, ...
        'HandleVisibility', 'on', ...
        'DisplayName', opts.DisplayName); hold on;

if sum(isnan(inBetween))>0; warning("NaNs detected in bounded line. MATLAB won't plot NaNs"); end

fill(opts.hA, x2, inBetween, color, ...
        'FaceAlpha', 0.3, ...
        'LineStyle','none', ...
        'HandleVisibility', 'off', ...
        'DisplayName', opts.DisplayName); 
    
yl = ylim;    
    
    



if opts.ZerosGrid    
    plot(opts.hA, [0 0], ylim(opts.hA)*100, 'color', [1 1 1]*0.7, 'HandleVisibility', 'off');
    plot(opts.hA, xlim(opts.hA)*100, [0 0], 'color', [1 1 1]*0.7, 'HandleVisibility', 'off');    
end



ylim(yl);
xlim(opts.hA, [t(1) t(end)]);
ylabel(opts.hA,'% BGA');
xlabel(opts.hA, 'Time [s]');



if ~isempty(opts.Sig)
    % plot significance
    yl = get(opts.hA, 'ylim');
    sigBarHeight = diff(yl)*0.05;
    
    if ~isempty(opts.SigTime)
        t = opts.SigTime.c;
%         tstep = mean(diff(opts.SigTime));
        tstep = opts.SigTime.w;
    else
        tstep = mean(diff(t));
    end
    cmp=[155 0 227]./255;
    for m = 1:length(opts.Sig)
        if opts.Sig(m)
            % plot at bottom of axis
            hPatch = patch(opts.hA, (([tstep -tstep -tstep tstep])+t(m)), (yl(1)+[0 0 sigBarHeight sigBarHeight]), ...
                cmp,'edgecolor','none', 'HandleVisibility', 'off');    %changed 20 to 90
            hPatch.FaceVertexAlphaData = 0.2;
            hPatch.FaceAlpha = 'flat' ;
            
%             % plot along y=0
%             patch(opts.hA, (([-tstep 0 0 -tstep])+t(m)), (0.5*[-sigBarHeight -sigBarHeight sigBarHeight sigBarHeight]), ...
%                      cmp,...
%                      'edgecolor','none',...
%                      'HandleVisibility', 'off')    %changed 20 to 90
                 
            % shaded significants regions 
%             patch(opts.hA, (([-tstep 0 0 -tstep])+t(m)), (100*[yl(1) yl(1) yl(2) yl(2)]), ...
%                      cmp,...
%                      'edgecolor','none',...
%                      'FaceAlpha', 0.3, ...
%                      'HandleVisibility', 'off')    %changed 20 to 90                 
        end
    end
    plot(opts.hA, xlim(opts.hA), [yl(1)+0.5*sigBarHeight yl(1)+0.5*sigBarHeight], '--', 'LineWidth', 2, 'color', cmp, 'HandleVisibility', 'off');
    
end





% X = [x   fliplr(x)  ];
% Y = [y-r fliplr(y+r)];
% hP = patch(X,Y,c,'facealpha',a,'edgecolor','none','parent',h);
% hL = line(x,y,'color',c,'parent',h);





end

