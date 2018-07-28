function [Q] = computeNoiceCovarianceMatrix(ts, q, sigma_a, sigma_m, sigma_g)

    E = [q(4) -q(3) q(2);
         q(3) q(4) -q(1);
         -q(2) q(1) q(4);
         q(1) q(2) q(3)];
     
    Sigma_g = [sigma_g.^2 0 0;
               0 sigma_g.^2 0;
               0 0 sigma_g.^2];
    
    Sigma_a = [sigma_a.^2 0 0;
               0 sigma_a.^2 0;
               0 0 sigma_a.^2];
          
    Sigma_m = [sigma_m.^2 0 0;
               0 sigma_m.^2 0;
               0 0 sigma_m.^2];
    
    O1 = [0 0 0;
         0 0 0;
         0 0 0];
    
    O2 = [0 0 0 0;
         0 0 0 0;
         0 0 0 0];
    
    O3 = transpose(O2);
    
    Q = [((ts/2).^2) * E * Sigma_g * transpose(E) O3 O3;
         O2            Sigma_a                       O1;
         O2            O1                       Sigma_m];
    
end
