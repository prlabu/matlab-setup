function [] = save_plot(file, varargin)
% file is a struct
%   Detailed explanation goes here


% ---- handle varargin options ----- 
opts.hF = gcf;
opts.isTif = true; % 
opts.isPNG = false; % 
opts.TifResolution = '-r300'; 
opts.isPDF = false; % 
opts.isEPS = false;  %
opts.isArchiveOld = true; 
opts = get_function_options(opts, varargin);
% ---- handle varargin options ----- 

% file.Folder
% file.Name
% file.opts
% file.Ext

if exist([file.Folder file.Name file.Ext], 'file')
    copyfile([file.Folder file.Name file.Ext], [file.Folder filesep 'archive' ...
              file.Name '_' char(datetime('now')) file.Ext])
end

if opts.isTif
    file.Ext = '';
    export_fig([file.Folder file.Name], opts.TifResolution, '-tiff');
end

if opts.isPNG
    file.Ext = '';
    export_fig([file.Folder file.Name], opts.TifResolution, '-m3');
end

if ~exist([file.Folder file.Name], 'dir'); mkdir([file.Folder file.Name]); end
file.Folder = [file.Folder file.Name filesep];

if opts.isPDF
    file.Ext = '';
    exportgraphics(opts.hF, [file.Folder file.Name '.pdf']);
end


file.Ext = '';
export_fig([file.Folder file.Name], '-m3', opts.hF);
% export_fig([PATH_SAVE_DIR filesep 'lombard_runs_elec-type-' ELEC_TYPE '_subset-' elec_subset ...
%             '_camview-' cam_view], '-m3', gcf);
% exportgraphics(opts.hF, [file.Folder file.Name '.pdf']);



% export_fig([figsFolder fileName], '-tiff' );
% exportgraphics(hF, [figsFolder fileName opts2str(opts) '.pdf']);
% print([figsFolder fileName opts2str(opts)],'-depsc');

end

