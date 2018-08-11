function [F] = computeJacobian(g , h, x_k)

%    computeJacobian
%    Input : g = Gravity [g1; g2; g3]   
%            h = Earth magnetic field [h1; h2; h3]
%            x_k = Measurement [q0; q1; q2; q3; a0; a1; a2; m0; m1; m2]    
%    Output : F = Jacobian matrix w.r.t x_k   

    syms q1 q2 q3 q4 a1 a2 a3 m1 m2 m3;
    q = [q1 q2 q3 q4];
    a = [a1 ; a2; a3];
    m = [m1; m2; m3];
    
    measurment = computeMeasurmentModel(q, g ,h , a, m);
    
    x = [q.' ; a ; m];
    
    J = jacobian(measurment, x);
    
    x_k = x_k.';
    
    q1 = x_k(1); q2 = x_k(2); q3 = x_k(3); q4 = x_k(4); 
    a1 = x_k(5); a2 = x_k(6); a3 = x_k(7);
    m1 = x_k(8); m2 = x_k(9); m3 = x_k(10);
    
    F = double(subs(J));
   
end
