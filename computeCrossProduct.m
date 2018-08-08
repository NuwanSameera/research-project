function [cross] = computeCrossProduct(p, q, r)
    cross = [0 -r  q ; 
             r  0 -p ;
             -q  p 0];
end

