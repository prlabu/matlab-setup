function [] = plot_raster(traces, tTr, varargin)
% plot per-trial raster of traces 

% ---- VARARGIN possible function arguments ---- 
opts.CAxis = [];
opts.hA = gca;
opts.Title = '';
opts.YLabels = true; 
opts.XLabels = true; 
opts.IsColorBar = false; 
opts.ColorMap = [ [1 1 1] ; cbrewer('seq', 'Reds', 64) ]; % for sgrams: colormap(gca, flipud(cbrewer('div', 'RdBu', 64)) )
% ---- VARARGIN possible function arguments ---- 
opts = get_function_options(opts, varargin);

t = tTr(1):0.5:tTr(2);


cL = [0 prctile(traces(:), 95);];
% cL = [0 1.5];
traces(traces < cL(1)) = cL(1); 
traces(traces > cL(2)) = cL(2); 

% for k = 1 : size(traces, 3)
%   result(:,:,k) = conv2(traces(:,:,k), ones(3,3)/9, 'same');
% end

% traces = imgaussfilt(traces, 5);

% clipped = max(0.01,min(0.99,(traces-cL(1))/diff(cL)));
% imagesc(t,[],traces,'Parent',opts.hA)
im = imagesc(t,[],traces,'Parent',opts.hA);


% windowSize = 15;
% avg3 = ones(windowSize) / windowSize^2;
% imblur = imfilter(im, avg3, 'conv');

line([0 0],[0 size(traces,1)]+0.5,'Parent',opts.hA,...
    'Color',[0 0 0],'Linewidth',1)
%     line([val(1); val; val(end)],(0:1+size(P1{p},1)),'Parent',hA(hAcur),...
%         'Color',[0 0 0],'Linewidth',0.5)    

set(opts.hA,'XLim',[tTr(1) tTr(2)],'YLim',[0 size(traces,1)]+0.5,...
    'CLim',cL);

colormap(opts.ColorMap);

title(opts.hA, opts.Title, 'FontWeight',"normal", "FontSize", 12, 'Interpreter', 'none');

end

