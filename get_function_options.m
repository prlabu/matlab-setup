function [options] = get_function_options(options,inputArgs,varargin)
% gets default options for a function, replaces with inputArgs inputs if they are present
% biafra ahanonu
% 2014.02.17 [22:21:49]
%
% inputs
%   options - structure with options as fieldnames
%   inputArgs - varargin containing name-value pairs passed from parent function.


% Modified Jul 2020 by Latane Bullock 


% list of valid options to accept, simple way to deal with illegal user input
validOptions = fieldnames(options);

% loop over each input name-value pair, check whether name is valid and overwrite fieldname in options structure.
for i = 1:2:length(inputArgs)
    optionName = inputArgs{i};

    % if user passes an 'options' cell, take those as th
    if strcmp('options', optionName)
        inputOptions = inputArgs{i+1};
        for j  = 1:2:length(inputOptions)
            if ~isempty(strmatch(inputOptions{j},validOptions))
                options.(inputOptions{j}) = inputOptions{j+1};
            else
                error(sprintf('There is no field "%s" in the options struct for this function.', optionName));                
            end            
        end
        continue
    end


    if ~isempty(strmatch(optionName,validOptions))
        val = inputArgs{i+1};
        if isa(options.(optionName), 'cell') && ~( isa(val, 'cell') )
            val = {val};
        end
        options.(optionName) = val;
    else % if option name doesn't correspond to a valid option              
        error(sprintf('There is no field "%s" in the options struct for this function.', optionName));                
    end

end



end