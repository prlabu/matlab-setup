function [i] = match_str_array(str1,str2)


i = zeros(size(str1));
for istr1 = 1:length(str1)
    i(istr1) = find(startsWith(str2, str1{istr1}));
end


end

