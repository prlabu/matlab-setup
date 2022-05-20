function [stars] = pval2stars(pvals, varargin)
%PVAL2STARS convert
%   Detailed explanation goes here


% ---- handle varargin options ----- 
% opts = [];
% opts.hF = gcf;
% opts.isTif = true; % 
% opts.TifResolution = '-r300'; 
% opts.isPDF = false; % 
% opts.isEPS = false;  % 
% opts = get_function_options(opts, varargin);
% ---- handle varargin options ----- 

stars = cell(size(pvals));
for i = 1:length(pvals)
    p = pvals(i);
    
    if p<=1E-3
        stars{i}='***'; 
    elseif p<=1E-2
        stars{i}='**';
    elseif p<=0.05
        stars{i}='*';
    elseif isnan(p)
        stars{i}='n.s.';
    else
        stars{i}='';
    end
end


end

