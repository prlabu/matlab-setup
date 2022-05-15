%  [Root]/[Analysis]/[Name]_<Conditions>.[Ext]

file = [];
file.Analysis = 'CuratedData';
file.Root = ['..' filesep 'Database' filesep file.Analysis filesep];
file.Archive = [file.Root 'Archive' filesep char(datetime('today')) filesep];
if ~exist(file.Root, 'dir'); mkdir(file.Root); end
if ~exist(file.Archive, 'dir'); mkdir(file.Archive); end
file.Ext = '.xlsx'; 
file.Conds = ''; 

opts = []; 
opts.Cohort = 'OR'; 
opts.Subset = 100; 
fprintf(opts2str(opts))
%  ----- % 
file.Conds = [file.Conds '']; 


% file.Name = 'clean-patients-overview';
% exportgraphics(gcf, [file.Root file.Name file.Ext]);
% savefig(gcf, [file.Root file.Name]);





