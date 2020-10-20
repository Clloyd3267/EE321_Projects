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
% %% Findung xhat
% for n = 1:1000
%     xhat=0;
%     for k = -n:n
%         xk=((1*(t==k))+(1/4*(t==(k-1)|t==(k+1)))+(1/2i*(t==(k-2)|t==(k+2))));
%         plot(t,xk)
%         %xhat=xhat+
%     end
% end
% 
% t = 0.001:0.01:4;
%     xhat=0;
%     for k = -1000:1000
%         xk=((1*(t==k))+(1/4*(t==(k-1)|t==(k+1)))+(1/2i*(t==(k-2)|t==(k+2))));
%         xhat=xhat+xk.*exp(1i*k*pi.*t);
%     end

% n = [-3,-2,-1,0,1,2,3];
% a = dd(n+2);
% 
% stem(n,a)

% t = 0.001:0.01:4;

% CDL=> Working (missing complex terms at -2,2)
% N=5;
% k=-N:N;
% xk = dd(k) + 1/4*dd(k+1) + 1/4*dd(k-1);% + 1/(2*1i)*dd(k-2)-1/(2*1i)*dd(k+2);
% stem(k,xk);

% xhat=0;

% t = 0.001:0.01:4;
% N=1000;
% k=-N:N;
% xk = dd(k) + 1/4*dd(k+1) + 1/4*dd(k-1) + 1/(2*1i)*dd(k-2)-1/(2*1i)*dd(k+2);
% % stem(k,xk); % CDL=> Fails due to complex terms
% 
% xhat=xk.*exp(1i*k*pi.*t);
% 
% plot(t,xhat)

t1 = 0.001:0.01:4;
N=1000000;
l=0;
for k = -N:N
    xk = dd(k) + 1/4*dd(k+1) + 1/4*dd(k-1) + 1/(2*1i)*dd(k-2)-1/(2*1i)*dd(k+2);
    xhat=exp((1i*k*pi).*t1) .* xk;
    l=l + exp((1i*k*pi).*t1);
end
% k=-N:N;

% stem(k,xk); % CDL=> Fails due to complex terms

xhat=xk.*exp(1i*k*pi.*t);

plot(t,xhat)

    
% for k = -N:N
%     xk = dd(k) + 1/4*dd(k+1) + 1/4*dd(k-1);% + 1/(2*1i)*dd(k-2)-1/(2*1i)*dd(k+2);
%     stem(k,xk);
% % %         xk=((1*(t==k))+(1/4*(t==(k-1)|t==(k+1)))+(1/2i*(t==(k-2)|t==(k+2))));
% %     x
% % xhat=xhat+xk.*exp(1i*k*pi.*t);
% end

function y = dd(x)
% x is a vector
% We create an output vector of only 0 (our default value)
y = zeros(1, length(x)); 

% We find indexes of input values equal to 0,
% and make them 1
y(x==0) = 1;
end
