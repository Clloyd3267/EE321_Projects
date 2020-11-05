%%------------------------------------------------------------------------------
% Name        : EE321_Project_4.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 4)
% Due Date    : 2020-11-13
% Description : Data Classification using Matlab
% ------------------------------------------------------------------------------

%% Part 1 - (Fixed A) Working with received data (TX data + noise) for two data symbols

% Clear the workspace, console, and close all figures
clear; clc; close all;

% Create transmit data
N = 1000000;                   % Number of symbols to be transmitted
A = 1;                         % Data amplitude (relates to signal power)
x = A*(2*(randn(N,1)>0) - 1);  % Generates +A and -A randomly but equally likely

% Plot data on a scatter plot to visualize transmitted symbols
figure
scatter(x, zeros(size(x)))
title("Transmit Signal For Part 1")
xlabel("Amplitude (-A to +A)")

% Generate received signal as transmit signal + noise
var_n = 0.01;               % Noise variance
n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
r = x + n;                  % Received signal

% Plot data on a scatter plot to visualize received symbols
figure
scatter(r, zeros(size(r)))
title("Received Signal For Part 1")
xlabel("Amplitude (-A to +A)")

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

%% Part 2 - (Varied A) Working with received data (TX data + noise) for two data symbols

% Clear the workspace, console, and close all figures
clear; clc; close all;

N = 1000000;   % Number of symbols to be transmitted
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
    PeValues(SNR_db + 21) = Pe;
    SNRValues(SNR_db + 21) = SNR_db;
end

% Plot Probability of Error vs SNR
figure
semilogy(SNRValues, PeValues)
title("Probability of Error vs SNR")
xlabel("SNR (db)")
ylabel("Probability of Error (Pe)")

%% Part 3 - (Fixed A) Working with received data (TX data + noise) for four data symbols (on axis)

% Clear the workspace, console, and close all figures
clear; clc; close all;

% Create transmit data
N = 1000000;                       % Number of symbols to be transmitted
A = 5;                             % Data amplitude (relates to signal power)
tx_x = A*((2*(randn(N,1)>0)) - 1); % Generates +A and -A; both equally likely
tx_y = 2*(randn(N,1)>0) - 1;       % Generates 1 and -1; both equally
                                   % this will be used to determine if
                                   % if A is placed on the x-axis or the
                                   % y axis

% Place data points on the x-y axis with one coordinate always at 0
for i = 1:1:N
    if tx_y(i) == 1        % if y = 1 place on y-axis
        tx_y(i) = tx_x(i);
        tx_x(i) = 0;
    elseif tx_y(i) == -1   % if y = -1 place on x-axis
        tx_y(i) = 0;
    end
end

% Plot data on a scatter plot to visualize transmitted symbols
figure
scatter(tx_x, tx_y)
title("Transmit Signal For Part 3")
xlabel("Amplitude (-A to +A)")
ylabel("Amplitude (-A to +A)")

% Generate received signal as transmit signal + noise
var_n = 0.01;                 % Noise variance
n_x = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n x
n_y = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n y
rx_x = tx_x + n_x;            % Received x signal
rx_y = tx_y + n_y;            % Received y signal

% Plot data on a scatter plot to visualize received symbols
figure
scatter(rx_x, rx_y)
title("Received Signal For Part 3")
xlabel("Amplitude (-A to +A)")
ylabel("Amplitude (-A to +A)")

% Decision algorithm for receive signal value
rx_norm_x = zeros(size(rx_x));
rx_norm_y = zeros(size(rx_y));
for i = 1:1:N
    if ((rx_x(i) > 0) && (rx_y(i) > rx_x(i))) || ((rx_x(i) < 0) && (rx_y(i) > -1*rx_x(i)))      % Point A (0,A)
        rx_norm_x(i) = 0;
        rx_norm_y(i) = A;
    elseif ((rx_x(i) > 0) && (rx_y(i) < -1*rx_x(i))) || ((rx_x(i) < 0) && (rx_y(i) < rx_x(i)))  % Point C (0,-A)
        rx_norm_x(i) = 0;
        rx_norm_y(i) = -1 * A;
    elseif ((rx_y(i) > 0) && (rx_x(i) < -1*rx_y(i))) || ((rx_y(i) < 0) && (rx_x(i) < rx_y(i)))  % Point B (-A,0)
        rx_norm_x(i) = -1 * A;
        rx_norm_y(i) = 0;
    elseif ((rx_y(i) > 0) && (rx_x(i) > rx_y(i))) || ((rx_y(i) < 0) && (rx_x(i) > -1*rx_y(i)))  % Point D (A,0)
        rx_norm_x(i) = A;
        rx_norm_y(i) = 0;
    else
        rx_norm_x(i) = 0;
        rx_norm_y(i) = A;
    end
end

% Plot normalized receive data
figure
scatter(rx_norm_x, rx_norm_y)
title("Normalized Receive Signal For Part 3")
xlabel("Amplitude (-A to +A)")
ylabel("Amplitude (-A to +A)")

% Error Characterization

% Find the number of incorrect guesses
incorrectReceive = 0;
for i = 1:1:N
    if (tx_x(i) ~= rx_norm_x(i)) || (tx_y(i) ~= rx_norm_y(i))
        incorrectReceive = incorrectReceive + 1;
    end
end

% Compute the probability of error
Pe = incorrectReceive / N

%% Part 4 - (Varied A) Working with received data (TX data + noise) for four data symbols (on axis)

% Clear the workspace, console, and close all figures
clear; clc; close all;

N = 1000000;   % Number of symbols to be transmitted
var_n = 0.01;  % Noise variance

for SNR_db = [-20:1:20]
    SNR = 10^(SNR_db/10);   % Calculate Linear SNR (X_db = 10*log(X))
    A = sqrt(SNR*var_n^2);  % Calculate value of A (SNR = (A^2)/(var_n^2))

    % Create transmit data
    tx_x = A*((2*(randn(N,1)>0)) - 1); % Generates +A and -A; both equally likely
    tx_y = 2*(randn(N,1)>0) - 1;       % Generates 1 and -1; both equally
                                       % this will be used to determine if
                                       % if A is placed on the x-axis or the
                                       % y axis

    % Place data points on the x-y axis with one coordinate always at 0
    for i = 1:1:N
        if tx_y(i) == 1        % if y = 1 place on y-axis
            tx_y(i) = tx_x(i);
            tx_x(i) = 0;
        elseif tx_y(i) == -1   % if y = -1 place on x-axis
            tx_y(i) = 0;
        end
    end

    % Generate received signal as transmit signal + noise
    n_x = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n x
    n_y = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n y
    rx_x = tx_x + n_x;            % Received x signal
    rx_y = tx_y + n_y;            % Received y signal

    % Decision algorithm for receive signal value
    rx_norm_x = zeros(size(rx_x));
    rx_norm_y = zeros(size(rx_y));
    for i = 1:1:N
        if ((rx_x(i) > 0) && (rx_y(i) > rx_x(i))) || ((rx_x(i) < 0) && (rx_y(i) > -1*rx_x(i)))      % Point A (0,A)
            rx_norm_x(i) = 0;
            rx_norm_y(i) = A;
        elseif ((rx_x(i) > 0) && (rx_y(i) < -1*rx_x(i))) || ((rx_x(i) < 0) && (rx_y(i) < rx_x(i)))  % Point C (0,-A)
            rx_norm_x(i) = 0;
            rx_norm_y(i) = -1 * A;
        elseif ((rx_y(i) > 0) && (rx_x(i) < -1*rx_y(i))) || ((rx_y(i) < 0) && (rx_x(i) < rx_y(i)))  % Point B (-A,0)
            rx_norm_x(i) = -1 * A;
            rx_norm_y(i) = 0;
        elseif ((rx_y(i) > 0) && (rx_x(i) > rx_y(i))) || ((rx_y(i) < 0) && (rx_x(i) > -1*rx_y(i)))  % Point D (A,0)
            rx_norm_x(i) = A;
            rx_norm_y(i) = 0;
        else
            rx_norm_x(i) = 0;
            rx_norm_y(i) = A;
        end
    end

    % Error Characterization

    % Find the number of incorrect guesses
    incorrectReceive = 0;
    for i = 1:1:N
        if (tx_x(i) ~= rx_norm_x(i)) || (tx_y(i) ~= rx_norm_y(i))
            incorrectReceive = incorrectReceive + 1;
        end
    end

    % Compute the probability of error
    Pe = incorrectReceive / N;

    % Add values to array
    PeValues(SNR_db + 21) = Pe;
    SNRValues(SNR_db + 21) = SNR_db;
end

% Plot Probability of Error vs SNR
figure
semilogy(SNRValues, PeValues)
title("Probability of Error vs SNR for four symbols (part 4)")
xlabel("SNR (db)")
ylabel("Probability of Error (Pe)")

%% Part 5 - (Fixed A) Working with received data (TX data + noise) for four data states (off axis)

% Clear the workspace, console, and close all figures
clear; clc; close all;

% Create transmit data
N = 10000000;                             % Number of symbols to be transmitted
A = 1;                                    % Data amplitude (relates to signal power)
tx_x = A/sqrt(2)*(2*(randn(N,1)>0) - 1);  % Generates +A/sqrt(2) and -A/sqrt(2) randomly but equally likely
tx_y = A/sqrt(2)*(2*(randn(N,1)>0) - 1);  % Generates +A/sqrt(2) and -A/sqrt(2) randomly but equally likely

% Plot data on a scatter plot to visualize transmitted symbols
figure
scatter(tx_x, tx_y)
title("Transmit Signal For Part 5")
xlabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")
ylabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")

% Generate received signal as transmit signal + noise
var_n = 0.01;                 % Noise variance
n_x = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n x
n_y = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n y
rx_x = tx_x + n_x;            % Received x signal
rx_y = tx_y + n_y;            % Received y signal

% Plot data on a scatter plot to visualize received symbols
figure
scatter(rx_x, rx_y)
title("Received Signal For Part 5")
xlabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")
ylabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")

% Decision algorithm for receive signal value
rx_norm_x = zeros(size(rx_x));
rx_norm_y = zeros(size(rx_y));
for i = 1:1:N
    if (rx_x(i) > 0) && (rx_y(i) > 0)      % Quadrant 1
        rx_norm_x(i) = A/sqrt(2);
        rx_norm_y(i) = A/sqrt(2);
    elseif (rx_x(i) < 0) && (rx_y(i) > 0)  % Quadrant 2
        rx_norm_x(i) = -1*A/sqrt(2);
        rx_norm_y(i) = A/sqrt(2);
    elseif (rx_x(i) < 0) && (rx_y(i) < 0)  % Quadrant 3
        rx_norm_x(i) = -1*A/sqrt(2);
        rx_norm_y(i) = -1*A/sqrt(2);
    elseif (rx_x(i) > 0) && (rx_y(i) < 0)  % Quadrant 4
        rx_norm_x(i) = A/sqrt(2);
        rx_norm_y(i) = -1*A/sqrt(2);
    else
        rx_norm_x(i) = A/sqrt(2);
        rx_norm_y(i) = A/sqrt(2);
    end
end

% Plot normalized receive data
figure
scatter(rx_norm_x, rx_norm_y)
title("Normalized Receive Signal For Part 5")
xlabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")
ylabel("Amplitude (-A/sqrt(2) to +A/sqrt(2))")

% Error Characterization

% Find the number of incorrect guesses
incorrectReceive = 0;
for i = 1:1:N
    if (tx_x(i) ~= rx_norm_x(i)) || (tx_y(i) ~= rx_norm_y(i))
        incorrectReceive = incorrectReceive + 1;
    end
end

% Compute the probability of error
Pe = incorrectReceive / N

%% Part 6 - (Varied A) Working with received data (TX data + noise) for four data symbols (off axis)

% Clear the workspace, console, and close all figures
% clear; clc; close all;

N = 1000000;   % Number of symbols to be transmitted
var_n = 0.01;  % Noise variance

for SNR_db = [-20:1:20]
    SNR = 10^(SNR_db/10);   % Calculate Linear SNR (X_db = 10*log(X))
    A = sqrt(SNR*var_n^2);  % Calculate value of A (SNR = (A^2)/(var_n^2))

    % Create transmit data
    tx_x = A/sqrt(2)*(2*(randn(N,1)>0) - 1);  % Generates +A/sqrt(2) and -A/sqrt(2) randomly but equally likely
    tx_y = A/sqrt(2)*(2*(randn(N,1)>0) - 1);  % Generates +A/sqrt(2) and -A/sqrt(2) randomly but equally likely

    % Generate received signal as transmit signal + noise
    n_x = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n x
    n_y = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n y
    rx_x = tx_x + n_x;            % Received x signal
    rx_y = tx_y + n_y;            % Received y signal

    % Decision algorithm for receive signal value
    rx_norm_x = zeros(size(rx_x));
    rx_norm_y = zeros(size(rx_y));
    for i = 1:1:N
        if (rx_x(i) > 0) && (rx_y(i) > 0)      % Quadrant 1
            rx_norm_x(i) = A/sqrt(2);
            rx_norm_y(i) = A/sqrt(2);
        elseif (rx_x(i) < 0) && (rx_y(i) > 0)  % Quadrant 2
            rx_norm_x(i) = -1*A/sqrt(2);
            rx_norm_y(i) = A/sqrt(2);
        elseif (rx_x(i) < 0) && (rx_y(i) < 0)  % Quadrant 3
            rx_norm_x(i) = -1*A/sqrt(2);
            rx_norm_y(i) = -1*A/sqrt(2);
        elseif (rx_x(i) > 0) && (rx_y(i) < 0)  % Quadrant 4
            rx_norm_x(i) = A/sqrt(2);
            rx_norm_y(i) = -1*A/sqrt(2);
        else
            rx_norm_x(i) = A/sqrt(2);
            rx_norm_y(i) = A/sqrt(2);
        end
    end

    % Error Characterization

    % Find the number of incorrect guesses
    incorrectReceive = 0;
    for i = 1:1:N
        if (tx_x(i) ~= rx_norm_x(i)) || (tx_y(i) ~= rx_norm_y(i))
            incorrectReceive = incorrectReceive + 1;
        end
    end

    % Compute the probability of error
    Pe = incorrectReceive / N;

    % Add values to array
    PeValues(SNR_db + 21) = Pe;
    SNRValues(SNR_db + 21) = SNR_db;
end

% Plot Probability of Error vs SNR
figure
semilogy(SNRValues, PeValues)
title("Probability of Error vs SNR for four symbols (part 6)")
xlabel("SNR (db)")
ylabel("Probability of Error (Pe)")