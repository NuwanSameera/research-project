function [Q] = computeNoiceCovarianceMatrix(ts, q, sigma_a, sigma_m, sigma_g)

%   computeNoiceCovarianceMatrix
%   Input : ts = Sampling time
%           q  = Quaternian [q1 q2 q3 q4] 
%           sigma_a = Variance of acclerometer
%           sigma_m = Variance of magnetometer
%           sigma_g = Variance of gyroscope
%   Output : Q

    E = [q(4) -q(3) q(2);
         q(3) q(4) -q(1);
         -q(2) q(1) q(4);
         q(1) q(2) q(3)];
    
    I = [1 0 0;
         0 1 0;
         0 0 1]; 
     
    Sigma_g = sigma_g.^2 * I;
    
    Sigma_a = (ts * sigma_a.^2) * I;
          
    Sigma_m = (ts * sigma_m.^2) * I;
    
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
