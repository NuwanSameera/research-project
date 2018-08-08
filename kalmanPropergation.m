function [x_k, x_k_bar, p_k_bar] = kalmanPropergation(x_k_1, p_k_1, r_k, params)

%    kalmanPropergation
%    Input : x_k_1 = Previous state estimation
%            p_k_1 = Previous error covariance matrix
%            r_k   = Current readings of IMU [a1; a2; a3; w1; w2; w3; m1; m2; m3]         
%            params = ts        - Sampling interval 
%                     sigma_a   - Variance of acclerometer data
%                     sigma_m   - Variance of magnetomter data
%                     sigma_g   - Variance of gyroscope data
%                     g         - Gravity [g1; g2; g3]
%                     h         - Earth magnetic field [h1; h2; h3]
%    
%    Output : x_k_bar = Next state prediction
%             p_k_bar = Next error covariance matrix
%             x_k = Current updated state

    %Compute the Kalman gain using previous estimation
    
    x_k_1(1:4, 1) = normalize(x_k_1(1:4, 1));
    F = computeJacobian(params.g , params.h, x_k_1);
    
    R = computeMesaurementCovarianceMatrix(params.sigma_a, params.sigma_m);
    
    K = p_k_1 * F.' * (inv(F * p_k_1 * F.' + R));    
    
    %Compute the a posteriori state estimate - Update previous predicted state using
    %   current value
    
    q_k_1 = x_k_1(1:4, 1);
    
    a_k_1 = x_k_1(5:7, 1);
    m_k_1 = x_k_1(8:10, 1);
    
    z_k_1 = computeMeasurmentModel(q_k_1, params.g ,params.h , a_k_1, m_k_1);
    
    a_k = r_k(1:3, 1);
    m_k = r_k(7:9, 1);
    
    z_k = [a_k ; m_k];
    
    x_k = x_k_1 + K *(z_k - z_k_1);   % Updated estimation
  
    x_k(1:4, 1) = normalize(x_k(1:4, 1));   %Normalize updated Quaternian
       
    %Compute the a posteriori error covariance matrix - Update error covariance matrix
    p_k = p_k_1 - K * F * p_k_1;
    
    %Compute the a priori state estimate - Predict next state
    w_k = r_k(4:6, 1);
    shi = computeStateTransitionMatrix(w_k, params.ts);
    x_k_bar = shi * x_k;
    
    x_k_bar(1:4, 1) = normalize(x_k_bar(1:4, 1)); 
    
    %Compute the a priori error covariance matrix - Predict next error covariance matrix
    q = x_k_bar(1:4, 1);      %Estimated quarternian

    Qk = computeNoiceCovarianceMatrix(params.ts, q, params.a_sigma_w, params.m_sigma_w, params.sigma_g);
    
    p_k_bar = shi * p_k * shi.' + Qk;
    
end
