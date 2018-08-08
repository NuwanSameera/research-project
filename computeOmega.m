function [omega] = computeOmega( w )

%     Calculate omega
%     Input  : w = [w1; w2 ;w3] Gyroscope reading
%     Output : Omega 4x4 matrix

    p = w(1);
    q = w(2);
    r = w(3);

    w_cross = computeCrossProduct(p , q, r);
    
    o = [w_cross      w;
         -w.'         0];
    
    omega = 0.5 * o; 
    
end

