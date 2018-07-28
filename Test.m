clear all
close all
clc

%Read data from file
data = xlsread('2-forward-1.xlsx');
Gyroscope = data(: , [5 : 7]) * (pi/180);
Accelometer = data(:, [2 : 4]);
Magnetometer = data(:, [8 : 10]);

time = data(:, 1);

%Initial conditions
q_0 = [1; 1 ;1 ;1];

%Parameters
ts = 1/20;

x_k_1 = zeros(10,1);
gyro_k_1 = zeros(3, 1);

x_out = zeros(length(time), 10);

q_k_1 = q_0;

for k=1:length(time)
    
    gyro_k = transpose(Gyroscope(k,:));
    acc_k = transpose(Accelometer(k,:));
    mag_k = transpose(Magnetometer(k,:));

    x_k_1 = [q_k_1 ; acc_k; mag_k];
    [x_k]  = quaternianEstimate(x_k_1, gyro_k, ts);
    
    x_k_1 = x_k;
    q_k_1 = x_k([1:4] , 1);
    
    x_out(k, :) = x_k_1;
    
end

euler = quatern2euler(quaternConj(x_out)) * (180/pi);

figure;

subplot(311);
plot(time, euler(:,1), 'r');
legend('\phi ');

subplot(312);
plot(time, euler(:,2), 'g');
legend('\theta');

subplot(313);
plot(time, euler(:,3), 'b');

legend('\psi');

