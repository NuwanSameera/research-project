function [R] = computeMesaurementCovarianceMatrix(sigma_a, sigma_m)
    O = [0 0 0;
         0 0 0;
         0 0 0];
    
    I = [1 0 0;
         0 1 0;
         0 0 1];
     
    R_a = (sigma_a.^2) * I;
    R_m = (sigma_m.^2) * I;
    
    R = [R_a O;
         O R_m];
end

