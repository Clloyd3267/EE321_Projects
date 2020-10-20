%%------------------------------------------------------------------------------
% Name        : EE321_Project_3.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 3)
% Due Date    : 2020-10-23
% Description : Calculating Error in Fourier Series Depending on the number of 
%               terms used.
% ------------------------------------------------------------------------------

% Clear the workspace and console
clear; clc;

% x1(t) for T=4
t = 0.001:0.01:4;
x = 1*((t<=1)|((t>=3)&(t<=4)));

% Plot x1(t)
plot(t, x);

% Calculate mean squared error (MSE) for x and xhat
mse(N) = mean((x - xhat).^2);
