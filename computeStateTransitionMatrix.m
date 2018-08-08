function [shi] = computeStateTransitionMatrix(gyro_k, ts)

%   Compute state transition matrix shi
%   Input  : gyro_k = [w1, w2, w3]
%            ts = Sampling interval 
%   Output : Shi

    I = eye(3);
    
    O1 = zeros(3);
    
    O2 = [zeros(3) [0 0 0].'];
    
    O3 = O2.';
   
    omega_ts = exp(computeOmega(gyro_k) * ts);
       
    shi = [omega_ts O3 O3;
           O2       I  O1;
           O2       O1 I];
end
