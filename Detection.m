clear all
close all
clc

%Constants
g = 9.81;

%Read data from file
%data = xlsread('forward/15-forward-1.xlsx');
%data = xlsread('backward/18-backward-1.xlsx');
%data = xlsread('latiral/18-latiral-1.xlsx');
data = xlsread('adl/6-adl-1.xlsx');

Gyroscope = data(: , 5 : 7) * (pi / 180);   % degres/sec convert to rad/sec
Accelometer = data(:, 2 : 4) * g;           % Units in 'g'
Magnetometer = data(:, 8 : 10) * 10.^-6;         % µT convert to T

time = data(:, 1);

%Initial conditions
x_0 = [0; 0; 0; 1; 0; 0; 10; 0; 0; 0];
p_0 = zeros(10);

%Parameters
params.ts = 1/20; 
params.sigma_a = 5 * 10^-2;
params.sigma_m = 0.001;
params.sigma_g = 0.1;
params.a_sigma_w = 5 * 10^-1;
params.m_sigma_w = 0.05;
params.g = [0; 0; 0.1];    %[x y z]
params.h = [10; 0; 10];

%Initialize
x_k_1 = x_0;
p_k_1 = p_0;

acc_norm = zeros(length(time), 1);

count = 0;

fall_detect = 0;

for k=1:length(time)
    
    gyro_k = transpose(Gyroscope(k,:));
    acc_k = transpose(Accelometer(k,:));
    mag_k = transpose(Magnetometer(k,:));

    r_k = [acc_k; gyro_k; mag_k];
    [x_k, x_k_bar, p_k_bar] = kalmanPropergation(x_k_1, p_k_1, r_k, params);
   
    x_k_1 = x_k_bar;
    p_k_1 = p_k_bar;
    
    q = transpose(x_k(1:4,1));
    euler_angles = abs(computeEularAngles(q) * (180/pi));
    
    acc_norm(k) = sqrt(x_k_1(5).^2 + x_k_1(6).^2 + x_k_1(7).^2);
   
    roll = euler_angles(1);
    yaw = euler_angles(3);
    
    if (roll > 20) || (yaw > 20)
        count = count + 1;
    else
        count = 0;
    end  
        
    if (count == 20 && max(acc_norm) > 17)
        fall_detect = 1;
        break;
    else
        fall_detect = 0;
    end
        
end

if (fall_detect == 1) 
    disp('Fall detected')
else
    disp('Not fall detected')
end

