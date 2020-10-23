%%------------------------------------------------------------------------------
% Name        : EE321_Project_3.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 3)
% Due Date    : 2020-10-23
% Description : Calculating Error in Fourier Series Depending on the number of 
%               terms used.
% ------------------------------------------------------------------------------

%% 1a

% Clear the workspace and console
clear; clc;

% Waveform Period
period = 2;

% Time variable for one period
t = 0.001:0.01:period;

% x(t) (calculated by hand)
x = 1+1/2*cos(pi*t)+sin(2*pi*t);

% Plot x
figure('Name','x(t) Comparison for Part 1A','NumberTitle','off')
subplot(2,1,1)
plot(t,x)
title("x(t) for 1A")
xlabel("t") 
ylabel("x(t)") 

% Number of terms to use for x_hat
n_max = 5;

mse = zeros(n_max, 1);

for N = 1:n_max
    k = -N:N;
    xk = dd(k) + 1/4*dd(k+1) + 1/4*dd(k-1) + 1/(2*1i)*dd(k-2)-1/(2*1i)*dd(k+2);

    % Find x_hat
    x_hat = zeros(size(t));
    for l = 1:length(k)
        x_hat = x_hat + xk(l)*exp(1i*k(l)*pi*t);
    end

    % Plot x_hat
    subplot(2,1,2)
    plot(t,real(x_hat))
    title("x\_hat(t) for 1A")
    xlabel("t") 
    ylabel("x\_hat(t)") 

    % Calculate mean squared error between x and x_hat
    mse(N) = real(mean((x - x_hat).^2));
end

%% 1b
% Clear the workspace and console
clear; clc;

% Waveform Period
period = 2;

% Time variable for one period
t = 0.001:0.01:period;

% x(t) (calculated by hand)
x = -4*sin(2*pi*t)-2*sin(pi*t);

% Plot x
figure('Name','x(t) Comparison for Part 1B','NumberTitle','off')
subplot(2,1,1)
plot(t,x)
title("x(t) for 1B")
xlabel("t") 
ylabel("x(t)") 

% Number of terms to use for x_hat
n_max = 5;

mse = zeros(n_max, 1);

for N = 1:n_max
    k = -N:N;
    xk = k.*(1i*(abs(k) < 3));
    
    % Find x_hat
    x_hat = zeros(size(t));
    for l = 1:length(k)
        x_hat = x_hat + xk(l)*exp(1i*k(l)*pi.*t);
    end

    % Plot x_hat
    subplot(2,1,2)
    plot(t,real(x_hat));
    title("x\_hat(t) for 1B")
    xlabel("t") 
    ylabel("x\_hat(t)") 

    % Calculate mean squared error between x and x_hat
    mse(N) = real(mean((x - x_hat).^2));
end

%% 2a
% Clear the workspace and console
clear; clc;

% Waveform Period
period = 4;
d = 2;
w0 = 2*pi/period;

% Time variable for one period
t = 0.001:0.01:period;

% x(t) (calculated by hand)
x = 1*((t<=1)|((t>=3)&(t<=4)));

% Plot x
figure('Name','x(t) Comparison for Part 2A','NumberTitle','off')
subplot(2,1,1)
plot(t,x)
title("x(t) for 2A")
xlabel("t") 
ylabel("x(t)") 

% Number of terms to use for x_hat
n_max = 200;

mse = zeros(n_max, 1);

for N = 1:n_max
    k = -N:N;
    xk = d./period.*sin(1/2.*k.*w0.*d)./(1/2.*k.*w0.*d);
    xk(isnan(xk)) = 0;  % Remove k=0 term due to div by zero
    
    % Find x_hat
    x_hat = d/period + zeros(size(t));
    
    for l = 1:length(k)
        x_hat = x_hat + real(xk(l)*exp(1i*k(l)*w0.*t));
    end

    % Plot x_hat
    subplot(2,1,2)
    plot(t,x_hat);
    title("x\_hat(t) for 2A")
    xlabel("t") 
    ylabel("x\_hat(t)") 

    % Calculate mean squared error between x and x_hat
    mse(N) = mean((x - x_hat).^2);
    
    % Add small delay to animate graph forming
    pause(0.05)
end

% Plot log(mse(n)) vs n
mse_db = 20*log(mse);
figure('Name','Mean Squared Error Log Plot for Part 2A','NumberTitle','off')
plot(mse_db)
title("Mean Squared Error for 2A")
xlabel("N") 
ylabel("20*log(mse(N))")

N_1 = find(mse<0.01, 1)
N_2 = find(mse<0.001, 1)

%% CDL=> For Part 2B

% Clear the workspace and console
clear; clc;

% Waveform Period
period = 2;
w0 = 2*pi/period;

% Time variable for one period
t = 0.001:0.01:period;

% x(t) (calculated by hand)
x = t.*((0<=t)&(t<1))+(2-t).*((1<=t)&(t<=2));

% Plot x
figure('Name','x(t) Comparison for Part 2B','NumberTitle','off')
subplot(2,1,1)
plot(t,x)
title("x(t) for 2B")
xlabel("t") 
ylabel("x(t)") 

% Number of terms to use for x_hat
n_max = 100;

mse = zeros(n_max, 1);

for N = 1:n_max
    k = -N:N;
    xk = 4.*((-1).^k==-1)./ (-2.*k.^2.*pi^2);
    xk(isnan(xk)) = 0;  % Remove k=0 term due to div by zero

    % Find x_hat
    x_hat = 1/2 + zeros(size(t));
    
    for l = 1:length(k)
        x_hat = x_hat + real(xk(l)*exp(1i*k(l)*w0.*t));
    end

    % Plot x_hat
    subplot(2,1,2)
    plot(t,x_hat);
    title("x\_hat(t) for 2B")
    xlabel("t") 
    ylabel("x\_hat(t)") 

    % Calculate mean squared error between x and x_hat
    mse(N) = mean((x - x_hat).^2);
    
    % Add small delay to animate graph forming
    pause(0.05)
end

% Plot log(mse(n)) vs n
mse_db = 20*log(mse);
figure('Name','Mean Squared Error Log Plot for Part 2B','NumberTitle','off')
plot(mse_db)
title("Mean Squared Error for 2B")
xlabel("N") 
ylabel("20*log(mse(N))")

N_1 = find(mse<0.01, 1)
N_2 = find(mse<0.001, 1)

%% Function Definitions

% Direc-Delta function to imitate a unit impulse
function y = dd(x)
    % x is a vector
    % We create an output vector of only 0's (our default value)
    y = zeros(1, length(x)); 

    % We find indexes of input values equal to 0,
    % and make them 1
    y(x==0) = 1;
end