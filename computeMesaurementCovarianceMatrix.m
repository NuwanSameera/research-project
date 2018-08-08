function [R] = computeMesaurementCovarianceMatrix(sigma_a, sigma_m)

%   computeMesaurementCovarianceMatrix
%   Input : sigma_a = Variance of acceleration
%           sigma_m = Variance of magnetometer
%   Output : R
% 

    O = zeros(3);
    
    I = eye(3);
     
    R_a = (sigma_a.^2) * I;
    R_m = (sigma_m.^2) * I;
    
    R = [R_a    O;
         O    R_m];
     
end

