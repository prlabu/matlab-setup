
function s = opts2str(opts)
% convert a struct of options into a string
% intended for use when saving files, eg 
%   exportgraphics([file.Name opts2str(opts)])

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