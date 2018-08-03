function [omega] = computeOmega( w )

%     Calculate omega
%     Input  : w = [w1 w2 w3] Gyroscope reading
%     Output : Omega 4x4 matrix

    o = [0     -w(3) w(2)   w(1);
         w(3)  0     -w(1)  w(2);
         -w(2) w(1)    0    w(3);
         -w(1) -w(2) -w(3)  0];
    omega = 0.5 * o; 
    
end

