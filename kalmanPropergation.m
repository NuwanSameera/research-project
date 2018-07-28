function [x_k, p_k] = kalmanPropergation(x_k_1, gyro_k, p_k_1, ts, sigma_a, sigma_m, sigma_g, g, h, v_a, v_m)

    %Compute the a priori state estimate
    shi = computeStateTransitionMatrix(gyro_k, ts);
    x_k_bar = shi * x_k_1;
    
    %Compute the a priori error covariance matrix
    q = x_k_bar([1:4], 1);
    
    Qk = computeNoiceCovarianceMatrix(ts, q, sigma_a, sigma_m, sigma_g);
    p_k_bar = shi * p_k_1 * transpose(shi) + Qk;
    
    %Compute the Kalman gain
    F = computeJacobian(g , h, x_k_bar);
    R = computeMesaurementCovarianceMatrix(sigma_a, sigma_m);
    K = p_k_bar * transpose(F) * (inv(F * p_k_bar * transpose(F) + R));
    
    %Compute the a posteriori state estimate
    x_k = x_k_bar + K * [v_a ; v_m];
   
    %Compute the a posteriori error covariance matrix
    p_k = p_k_bar - K * F * p_k_bar;
    
end

