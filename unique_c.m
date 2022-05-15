function [U, cnt] = unique_c(S)
  [U, ~, IC] = unique(S);
    
  ngrp = length(unique(IC));
  cnt = zeros(ngrp, 1); 
  for i = 1:ngrp
      cnt(i) = nnz(i==IC);
  end
  
end
