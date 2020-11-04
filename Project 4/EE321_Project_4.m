%%------------------------------------------------------------------------------
% Name        : EE321_Project_4.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 4)
% Due Date    : 2020-11-13
% Description : Data Classification using Matlab
% ------------------------------------------------------------------------------

%% Part 1 - (Fixed A) Working with received data (TX data + noise) for two data states

% Clear the workspace and console
clear; clc;

% Create transmit data
N = 1000;                      % Number of symbols to be transmitted
A = 1;                         % Data amplitude (relates to signal power)
var_n = 0.01;                  % Noise variance
x = A*(2*(randn(N,1)>0) - 1);  % Generates +A and -A randomly but equally likely

% Plot data on a scatter plot to visualize transmitted symbols
figure
scatter(x, zeros(size(x)))
title("Transmit Signal For Part 1")
xlabel("Amplitude (-A to +A)")

% Generate received signal as transmit signal + noise
n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
r = x + n;                  % Received signal

% Plot data on a scatter plot to visualize received symbols
figure
scatter(r, zeros(size(r)))
title("Received Signal For Part 1")
xlabel("Amplitude (-A to +A)")

% % Visualize data with r = 0 CDL=> Needed?
% r = zeros(size(x));
% plot(r);

% Decision algorithm for receive signal value
r_norm = zeros(size(x));
for i = 1:1:N
    if r(i) > 0             % If positive
        r_norm(i) = A;
    else                    % If negative or 0
        r_norm(i) = -1 * A;
    end
end

% Plot normalized receive data
figure
scatter(r_norm, zeros(size(r_norm)))
title("Normalized Receive Signal For Part 1")
xlabel("Amplitude (-A to +A)")

% Error Characterization

% Find the number of incorrect guesses
incorrectReceive = 0;
for i = 1:1:N
    if x(i) ~= r_norm(i)
        incorrectReceive = incorrectReceive + 1;
    end
end

% Compute the probability of error
Pe = incorrectReceive / N

%% Part 2 - (Varied A) Working with received data (TX data + noise) for two data states

var_n = 0.01;  % Noise variance

for SNR_db = [-20:1:20]
    SNR = 10^(SNR_db/10);   % Calculate Linear SNR (X_db = 10*log(X))
    A = sqrt(SNR*var_n^2);  % Calculate value of A (SNR = (A^2)/(var_n^2))

    % Create transmit data
    x = A*(2*(randn(N,1)>0) - 1);  % Generates +A and -A randomly but equally likely

    % Generate received signal as transmit signal + noise
    n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
    r = x + n;                  % Received signal

    % Decision algorithm for receive signal value
    r_norm = zeros(size(x));
    for i = 1:1:N
        if r(i) > 0             % If positive
            r_norm(i) = A;
        else                    % If negative or 0
            r_norm(i) = -1 * A;
        end
    end

    % Error Characterization

    % Find the number of incorrect guesses
    incorrectReceive = 0;
    for i = 1:1:N
        if x(i) ~= r_norm(i)
            incorrectReceive = incorrectReceive + 1;
        end
    end

    % Compute the probability of error
    Pe = incorrectReceive / N;

    % Add values to array
    PeValues(SNR_db - 9) = Pe;
    SNRValues(SNR_db - 9) = SNR_db;
end

% Plot Probablity of Error vs SNR
figure
scatter(SNRValues, PeValues)
title("Probablity of Error vs SNR")
xlabel("SNR (db)")
ylabel("Probablity of Error (Pe)")

%% Section 3.3
% for SNR_db = [-20:1:20]     % vary SNR from -20 db to 20 db
%     
% end

N = 1000;
A = 5;
x = A*((2*(randn(N,1)>0)) - 1); % Generates +A and -A; both equally likely
y = 2*(randn(N,1)>0) - 1;   % Generates 1 and -1; both equally
                            % this will be used to determine if
                            % if A is placed on the x-axis or the
                            % y axis

% place data points on the x-y axis
for i = 1:1:1000
    if y(i) == 1        % if y = 1 place on y-axis
        y(i) = x(i);
        x(i) = 0;
    elseif y(i) == -1   % if y = -1 place on x-axis
        y(i) = 0;
    end
end

% visualize modal data with four symbols with A = 5
figure;
scatter(x,y);
title("Four Symbols Modal Data with A = 5");

% test noise simulation
var_n = 0.01; % Noise variance
n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
m = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
r = x + n; % Received signal
y = y + m; % create noise in y-axis

% visualize modal data with four symbols with A = 5 and transmission noise
figure;
scatter(r,y);
title("Four Symbol Modal Data with Noise Simulation")


% for N = [1000 5000] %select a large enough value of N for a smooth curve
%     for A = [0.01 1]  %TODO change to neeeded values
%         x = A*((2*(randn(N,1)>0)) - 1); % Generates +A and -A; both equally likely
%         y = 2*(randn(N,1)>0) - 1; % Generates 1 and -1; both equally
%                                      % this will be used to determine if
%                                      % if A is placed on the x-axis or the
%                                      % y axis
%
%
%     end
%
%
% end


