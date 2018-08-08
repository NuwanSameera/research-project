function [euler] = computeEularAngles(q)
    
    theta = asin(2 * (q(4) * q(2) - q(3) * q(1)));

    shi_x = (2 * (q(4) * q(1) + q(2) * q(3)));
    shi_y = (1 - 2 * (q(1)^2 + q(2)^2));
    
    shi = atan(shi_x / shi_y);
    
    phi_x = 2 * (q(4) * q(3) + q(1) * q(3));
    phi_y = 1 - 2 * (q(2)^2 + q(3)^2);
    
    phi = atan(phi_x / phi_y);
    
    euler = [shi theta phi];
    
end
