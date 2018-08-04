clear all
close all
clc

%Constants
g = 9.8;

%Read data from file
data = xlsread('2-forward-1.xlsx');
%data = xlsread('1-adl-1.csv');
Gyroscope = data(: , 5 : 7) * (pi / 180);   % degres/sec convert to rad/sec
Accelometer = data(:, 2 : 4) * g;           % Units in 'g'
Magnetometer = data(:, 8 : 10) * 0;     % �T convert to T

time = data(:, 1);

norm = sqrt(Accelometer(:,1).^2 + Accelometer(:,2).^2 + Accelometer(:,3).^2);

%Initial conditions
x_0 = [0; 0; 0; 1; g; 0; 0; 0; 0; 0];
p_0 = zeros(10);

%Parameters
params.ts = 1/20;
params.sigma_a = 0.0000001;
params.sigma_m = 0.0000001;
params.sigma_g = 0.0000001;
params.a_sigma_w = 0.0000001;
params.m_sigma_w = 0.0000001;
params.g = [-g; 0; 0];    %[x y z]
params.h = [0; 0; 0];

%Initialize
x_k_1 = x_0;
p_k_1 = p_0;

euler = zeros(length(time), 3);
q_out = zeros(length(time), 4);
x_out = zeros(length(time), 10);

for k=1:length(time)
    
    gyro_k = transpose(Gyroscope(k,:));
    acc_k = transpose(Accelometer(k,:));
    mag_k = transpose(Magnetometer(k,:));

    r_k = [acc_k; gyro_k; mag_k];
    [x_k, x_k_bar, p_k_bar] = kalmanPropergation(x_k_1, p_k_1, r_k, params);
   
    x_k_1 = x_k_bar;
    p_k_1 = p_k_bar;
    
    q = transpose(x_k(1:4,1));
    euler(k, :) = computeEularAngles(q) * (180/pi);
    q_out(k, :) = q;
    x_out(k, :) = transpose(x_k_bar);
    
end

figure;
plot(time, Accelometer(:,1), 'r', time, x_out(:, 5), 'b');
title('X - axis Accelometer')

figure;
plot(time, Accelometer(:,2), 'r', time, x_out(:, 6), 'b');
title('Y - axis Accelometer')

figure;
plot(time, Accelometer(:,3), 'r', time, x_out(:, 7), 'b');
title('Z - axis Accelometer')

norm1 = sqrt(x_out(:, 5).^2 + x_out(:, 6).^2 + x_out(:, 7).^2);

figure;
plot(time, norm1, 'b', time, norm, 'r');
title('Norm Accelometer')
