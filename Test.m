clear all
close all
clc

%Constants
g = 9.8;

%Read data from file
data = xlsread('2-backward-1.xlsx');
%data = xlsread('1-adl-1.csv');
Gyroscope = data(: , 5 : 7) * (pi / 180);   % degres/sec convert to rad/sec
Accelometer = data(:, 2 : 4) * g;           % Units in 'g'
Magnetometer = data(:, 8 : 10) * 10.^6;             % µT convert to T

time = data(:, 1);

%Initial conditions
x_0 = [0; 0; 0; 1; g; 1; 0; 0; 0; 0];
p_0 = zeros(10);

%Parameters
params.ts = 1/20; 
params.sigma_a = 0.05;
params.sigma_m = 0.001;
params.sigma_g = 0.1;
params.a_sigma_w = 0.5;
params.m_sigma_w = 0.05;
params.g = [-g; 0; 0];    %[x y z]
params.h = [10; 10; 10];

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
    euler(k, :) = abs(computeEularAngles(q) * (180/pi));
    q_out(k, :) = q;
    x_out(k, :) = transpose(x_k);
end

% figure;
% plot(time, q_out(:,1), 'r', time, q_out(:,2), 'g', time, q_out(:,3), 'b', time, q_out(:,4), 'y');grid on;

%euler = quatern2euler(q_out) * (180/pi);

%figure;

norm = sqrt(Accelometer(:,1).^2 + Accelometer(:,2).^2 + Accelometer(:,3).^2);

figure;
plot(time, euler(:,1), 'r', time, euler(:,3), 'b', time, norm(:, 1), 'g');

figure;

subplot(311);
plot(time, euler(:,1), 'r');grid on;
ylabel('\phi (x-axis rotation[Roll])');
 
subplot(312);
plot(time, euler(:,2), 'g');grid on;
ylabel('\theta (y-axis rotation[pitch])');

subplot(313);
plot(time, euler(:,3), 'b');grid on;
ylabel('\psi (z-axis rotation[yaw])');
