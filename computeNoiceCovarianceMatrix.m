function [Q] = computeNoiceCovarianceMatrix(ts, q, sigma_a, sigma_m, sigma_g)

%   computeNoiceCovarianceMatrix
%   Input : ts = Sampling time
%           q  = Quaternian [q1 q2 q3 q4] 
%           sigma_a = Variance of acclerometer
%           sigma_m = Variance of magnetometer
%           sigma_g = Variance of gyroscope
%   Output : Q

    I = eye(3); 

    e_cross = computeCrossProduct(q(1), q(2), q(3));
    
    e = [q(1) q(2) q(3)];
    
    E = [e_cross + q(4) * I ; -e];
    
    Sigma_g = (sigma_g^2) * I;
    
    Sigma_a = (ts*sigma_a^2) * I;
          
    Sigma_m = (ts*sigma_m^2) * I;
    
    O1 = zeros(3);
    
    O2 = [zeros(3) [0 0 0].'];
    
    O3 = O2.';
    
    Q = [((ts/2)^2) * E * Sigma_g * E.'     O3                   O3;
         O2                                 Sigma_a              O1;
         O2                                 O1             Sigma_m];

end
