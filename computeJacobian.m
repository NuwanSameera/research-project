function [F] = computeJacobian(g , h, x_k)

    syms q0 q1 q2 q3 a0 a1 a2 m0 m1 m2;
    q = [q0 q1 q2 q3];
    a = [a0 ; a1; a1];
    m = [m0; m1; m2];
    
    measurment = computeMeasurmentModel(q, g ,h , a, m);
    
    d = [transpose(q) ; a ; m];
    
    J = jacobian(measurment, d);
    
    x_k = transpose(x_k);
    
    q0 = x_k(1);q1 = x_k(2); q2 = x_k(3); q3 = x_k(4); 
    a0 = x_k(5); a1 = x_k(6); a2 = x_k(7);
    m0 = x_k(8); m1 = x_k(9); m2 = x_k(10);
    
    F = subs(J);
   
end
