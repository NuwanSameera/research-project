function [shi] = computeStateTransitionMatrix(gyro_k, ts)
    I = [1 0 0;
         0 1 0;
         0 0 1];
    
    O1 = [0 0 0;
         0 0 0;
         0 0 0];
    
    O2 = [0 0 0 0;
         0 0 0 0;
         0 0 0 0];
    
    O3 = transpose(O2);
     
    omega_ts = Operations.NormalizeV(exp(omega(gyro_k) * ts));
    
    shi = [omega_ts O3 O3;
           O2  I  O1;
           O2  O1 I];

end
