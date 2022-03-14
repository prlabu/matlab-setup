% raincloud_plot - plots a combination of half-violin, boxplot,  and raw
% datapoints (1d scatter).
% Use as h = raincloud_plot(X), where X is a data vector is a cell array of handles for the various figure parts.
% See below for optional inputs.
% Based on https://micahallen.org/2018/03/15/introducing-raincloud-plots/
% Inspired by https://m.xkcd.com/1967/
% v1 - Written by Tom Marshall. www.tomrmarshall.com
% v2 - Updated inputs to be more flexible - Micah Allen 12/08/2018
%
% Thanks to Jacob Bellmund for some improvements


function [h, u] = raincloud(X0, varargin)

% ---------------------------- INPUT ----------------------------
%
% X - vector of data to be plotted, required.
%
% --------------------- OPTIONAL ARGUMENTS ----------------------
%
% color             - color vector for rainclouds (default gray, i.e. = [.5 .5 .5])
% band_width         - band_width of smoothing kernel (default = 1)
% density_type       - choice of density algo ('ks' or 'rath'). Default = 'ks'
% box_on             - logical to turn box plots on/off (default = 1)
% box_dodge          - logical to turn on/off box plot dodging (default = 1)
% box_dodge_amount    - mutiplicative value to increase dodge amount (default = 0)
% alpha             - scalar positive value to increase cloud alpha (defalut = 1)
% dot_dodge_amount    - scalar value to increase dot dodge amounts (defalut =0.6)
% box_col_match       - logical to set it so that boxes match the colour of clouds (default = 0)
% line_width         - scalar value to set global line width (default = 2)
% lwr_bnd        - mutiplicative value to increase spacing at bottom of plot(default = 1)
% bxcl           - color of box outline
% bxfacecl       - color of box face
%
% ---------------------------- OUTPUT ----------------------------
% h - figure handle to change more stuff
% u - parameter from kernel density estimate
%
% ------------------------ EXAMPLE USAGE -------------------------
%
% h = raincloud('X', myData, 'box_on', 1, 'color', [0.5 0.5 0.5])
%

%% check all the inputs and if they do not exist then revert to default settings
% input parsing settings
p = inputParser;
p.CaseSensitive = true;
p.Parameters;
p.Results;
p.KeepUnmatched = true;
validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);

% set the desired and optional input arguments
addRequired(p, 'X0');
addOptional(p, 'color', [0.5 0.5 0.5], @iscell)
addOptional(p, 'band_width', [])
addOptional(p, 'density_type', 'ks', @ischar)
addOptional(p, 'box_on', 1, @isnumeric)
addOptional(p, 'box_dodge', 1, @isnumeric)
addOptional(p, 'dodge_amount', 0.2, @isnumeric)
addOptional(p, 'alpha', 1, validScalarPosNum)
addOptional(p, 'box_col_match', 0, @isnumeric)
addOptional(p, 'line_width', 2, validScalarPosNum)
addOptional(p, 'lwr_bnd', 1, @isnumeric)
addOptional(p, 'bxcl', [0 0 0], @isnumeric)
addOptional(p, 'bxfacecl', [1 1 1], @isnumeric)
addOptional(p, 'cloud_edge_col', [0 0 0], @isnumeric)
addOptional(p, 'is_rain_drops', true, @islogical)
addOptional(p, 'data_labels', '', @iscell)
addOptional(p, 'is_paired_data', false, @islogical)
addOptional(p, 'hA', [], @isgraphics) % axis handle


% parse the input
parse(p,X0,varargin{:});
% then set/get all the inputs out of this structure
X0                   = p.Results.X0;
color0               = p.Results.color;
density_type        = p.Results.density_type;
box_on              = p.Results.box_on;
dodge_amount        = p.Results.dodge_amount;
alpha               = p.Results.alpha;
box_col_match       = p.Results.box_col_match;
line_width          = p.Results.line_width;
lwr_bnd             = p.Results.lwr_bnd;
bxcl                = p.Results.bxcl;
bxfacecl            = p.Results.bxfacecl;
cloud_edge_col      = p.Results.cloud_edge_col;
band_width          = p.Results.band_width;
is_rain_drops       = p.Results.is_rain_drops;
data_labels         = p.Results.data_labels;
is_paired_data      = p.Results.is_paired_data;

%%
if ~iscell(X0); X0 = {X0}; end
if ~iscell(color0); color0 = {color0}; end
if ~iscell(data_labels); data_labels = {data_labels}; end
if is_paired_data
    assert(length(X0)==2, 'paired data must come in twos'); 
    assert(length(X0{1})==length(X0{2}), 'inputted datasets must match in length for paired data'); 
end

for ii = 1:length(X0)
    X = X0{ii};
    if length(X0)==length(color0)        
        color = color0{ii};
    else
        color = color0{1};
    end
    
    % calculate kernel density
    switch density_type
        case 'ks'
            [f, Xi, u] = ksdensity(X, 'bandwidth', band_width);
            
        case 'rash'
            % must have https://github.com/CPernet/Robust_Statistical_Toolbox
            % for this to work
            
            % check for rst_RASH function (from Robust stats toolbox) in path, fail if not found
            assert(exist('rst_RASH', 'file') == 2, 'Could not compute density using RASH method. Do you have the Robust Stats toolbox on your path?');
            
            [Xi, f] = rst_RASH(X);
            u = NaN; % not sure how to handle this with RASH yet
    end
    
    % density plot    
    if is_paired_data && ii==1
        h(ii).density = patch(-(5*f./sum(f)) + ii + -(dodge_amount*0.75), Xi, color); hold on
    else
        h(ii).density = patch((5*f./sum(f)) + ii + (dodge_amount*0.75), Xi, color); hold on
    end
    % set(h(ii).density, 'FaceColor', color);
    % set(h(ii).density, 'EdgeColor', cloud_edge_col);
    set(h(ii).density, 'EdgeColor', 'none');
    set(h(ii).density, 'LineWidth', line_width);
    set(h(ii).density, 'FaceAlpha', alpha);
    
    % jitter for raindrops
    jit = (rand(size(X)) - 0.5) * (dodge_amount*0.4);
    
    % info for making boxplot
    quartiles   = quantile(X, [0.25 0.75 0.5]);
    iqr         = quartiles(2) - quartiles(1);
    Xs          = sort(X);
    whiskers(1) = min(Xs(Xs > (quartiles(1) - (1.5 * iqr))));
    whiskers(2) = max(Xs(Xs < (quartiles(2) + (1.5 * iqr))));
    Y           = [quartiles whiskers];
    
    % raindrops
    if is_paired_data && ii==1
        drops_pos{ii} = ii + jit + dodge_amount;
    else
        drops_pos{ii} = ii + jit - dodge_amount;
    end
    
    if is_paired_data && ii==2    
       clr = [0.5 0.5 0.5]; 
       fAlpha = 0.2; 
       for iobs = 1:length(X0{2})
          plot([drops_pos{ii-1}(iobs) drops_pos{ii}(iobs)], [X0{1}(iobs) X0{2}(iobs)], ...
              'Color', clr);
       end
    end
    
    
    if is_rain_drops
        h(ii).raindrops = scatter(drops_pos{ii}, X, 'HandleVisibility','off');
        h(ii).raindrops.SizeData = 10;
        h(ii).raindrops.MarkerFaceColor = color;
        h(ii).raindrops.MarkerEdgeColor = 'none';
    end
    
    if box_on
        
        box_pos = [ii-(dodge_amount/2) Y(1) dodge_amount Y(2)-Y(1)];
        % mean line
        h(ii).mean_line = line(ones(1,2).*ii + [-dodge_amount dodge_amount]./2, [Y(3) Y(3)],  'col', bxcl, 'LineWidth', line_width, 'HandleVisibility','off');
        
        % whiskers
        h(ii).whiskers{1} = line(ones(1,2).*ii, [Y(2) Y(5)],  'col', bxcl, 'LineWidth', line_width/2, 'HandleVisibility','off');
        h(ii).whiskers{2} = line(ones(1,2).*ii, [Y(1) Y(4)],  'col', bxcl, 'LineWidth', line_width/2, 'HandleVisibility','off');
        
        % 'box' of 'boxplot'
        h(ii).boxplot = rectangle('Position', box_pos, 'HandleVisibility','off');
        set(h(ii).boxplot, 'EdgeColor', color)
        set(h(ii).boxplot, 'LineWidth', line_width);
        %set(h{3}, 'FaceColor', bxfacecl);
        % could also set 'FaceColor' here, etc
    end
    
end


set(gca, 'xtick', 1:length(X), 'xticklabels', data_labels); % set data labels

