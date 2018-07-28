function [c_n_b] = computeDirectionCosineMatrix(q)
    c = [(q(1).^2 - q(2).^2 - q(3).^2 + q(4).^2)  2*(q(1)*q(2) + q(3)*q(4)) 2*(q(1)*q(3) - q(2)*q(4));
         2*(q(1)*q(2) - q(3)*q(4)) (-q(1).^2 + q(2).^2 - q(3).^2 + q(4).^2) 2*(q(2)*q(3) + q(4)*q(1));
         2*(q(1)*q(3) + q(2)*q(4)) 2*(q(2)*q(3) - q(4)*q(1)) (-q(1).^2 -q(2).^2 +q(3).^2 + q(4).^2)];

    c_n_b = (1/norm(q)) * c;  
end
