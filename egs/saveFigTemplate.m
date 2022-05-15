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



function s = opts2str(opts)
    s = '';
    fields = fieldnames(opts);
    for ifields = 1:length(fields)
        field = fields{ifields}; 
        val = opts.(fields{ifields}); 
        if isa(val, 'char')
            s = [s sprintf('_%s-%s', field, val)];
        elseif isa(val, 'double') && mod(val, 1) == 0
            s = [s sprintf('_%s-%d', field, val)];
        elseif isa(val, 'double')
            s = [s sprintf('_%s-%0.2f', field, val)];
        end
    end
end


