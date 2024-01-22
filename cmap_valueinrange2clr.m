function [clr, idx] = cmap_valueinrange2clr(val, range, cmap)

nclr = size(cmap, 1); 

perc = (val - range(1))./(diff(range)); 

idx = round(perc*(nclr-1) + 1); 
idx(idx<0) = 0; 
idx(idx>nclr) = nclr; 

clr = cmap(idx, :); 

end
