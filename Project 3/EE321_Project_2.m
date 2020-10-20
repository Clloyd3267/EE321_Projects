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
t = 0.001:0.01:2;
%x calculated by hand
x = 1+1/2*cos(pi*t)+sin(2*pi*t);
plot(t,x)
%% Findung xhat
for n = 1:1000
    xhat=0;
    for k = -n:n
        xk=((1*(t==k))+(1/4*(t==(k-1)|t==(k+1)))+(1/2i*(t==(k-2)|t==(k+2))));
        plot(t,xk)
        %xhat=xhat+
    end
end