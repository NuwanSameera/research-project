function [z_k] = computeMeasurmentModel(q_k, g ,h , a_k, m_k)

%    computeMeasurmentModel
%    Input : q_k = Quartanian [q1 q2 q3 q4]
%            g = Gravity    [g1; g2; g3]
%            h = Earth magnetic field [h1 ; h2 ; h3]
%            a_k = Current measurement of accelation   
%            m_k = Current measurement of magnetometer   
%    Output : z_k
% 

    O = [0 0 0; 
         0 0 0; 
         0 0 0];
     
    C_b_n = computeDirectionCosineMatrix(q_k);
    z_k = [C_b_n O; O C_b_n] * [g ; h] + [a_k; m_k];

end
