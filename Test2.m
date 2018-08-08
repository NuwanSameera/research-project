clear all;
close all;
clc

syms q1 q2 q3 q4

q = [q1 q2 q3 q4];

q_cross = [0 -q(3) q(2); q(3) 0 -q(1); -q(2) q(1) 0];

I = [1 0 0; 0 1 0; 0 0 1];

C_b_e = I - 2 * q(4) * q_cross + 2 * q_cross.^2

