function [hA, pos] = tsubplot_wrapper(Nh, Nw, varargin)

% [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 
%
%  out:  ha     array of handles of the axes objects
%                   starting from upper left corner, going row-wise as in
%                   subplot
%        pos    positions of the axes objects
% tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])

% SET defaults
opts.gap_h = 0.01;
opts.gap_v = 0.01;

opts.marg_top = 0.1;
opts.marg_bottom = 0.1;
opts.marg_left = 0.1;
opts.marg_right = 0.1;
% 
opts = get_function_options(opts, varargin);


[hA, pos] = tight_subplot(Nh, Nw, ...
    [opts.gap_v opts.gap_h], ...
    [opts.marg_bottom opts.marg_top], ...
    [opts.marg_left opts.marg_right]);
hA = (reshape(hA, Nw, Nh))';

end