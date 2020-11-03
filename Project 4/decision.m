clear;
clc;
N = 1000; % Number of symbols to be transmitted
A = 1; % We can adjust this as needed. This is directly related to the transmit power
x = A*(2*(randn(N,1)>0) - 1); % Generates +A and -A; both equally likely

%%Section 3.1
%scatter plot to visualize transmitted symbols
scatter(zeros(size(x)), x);
% scatter(x(:,1),x(:,2));   %KAB => NOT sure if this is the kind of scatterplot that he wants
% plotmatrix(x);
% plot(x);

%received signal generation
var_n = 0.01; % Noise variance
n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
r = x + n; % Received signal
scatter(r,zeros(size(r)));   %KAB => not sure if this is the kind of scatterplot needed but it looks pretty good
% plot(r);

%visualize data with r = 0
% r = zeros(size(x));
% % plot(r);

% receive signal value decision algorithm
for i = 1:1:1000
    if r(i) > 0
        received(i) = A;
    elseif r(i) < 0
        received(i) = -1 * A;
    end
end
    
%plot received data
scatter(received, zeros(size(received)));

%% Section 3.2
%find the number of incorrect guesses
incorrectReceive = 0;
for i = 1:1:1000
   if x(i) ~= received(i)
    incorrectReceive = incorrectReceive + 1;
   end
end

%compute probability of error
Pe = incorrectReceive / N;

%change A to 2
A = 2;
x = A*(2*(randn(N,1)>0) - 1); % Generates +A and -A; both equally likely
r = x + n; % Received signal
scatter(r,zeros(size(r)));   %KAB => not sure if this is the kind of scatterplot needed but it looks pretty good

% receive signal value decision algorithm
for i = 1:1:1000
    if r(i) > 0
        received(i) = A;
    elseif r(i) < 0
        received(i) = -1 * A;
    end
end

%find the number of incorrect guesses
incorrectReceive = 0;
for i = 1:1:1000
   if x(i) ~= received(i)
    incorrectReceive = incorrectReceive + 1;
   end
end

%compute probability of error
%KAB TODO: fix this part of the program
j = 1; % index
% for A = (sqrt(10 * var_n)) : 0.01 : (sqrt(10 .^ 4 * var_n)) %vary A so SNR varies from 10dB to 40dB
    for A = [0.01 1]
%     A = 0.01;
    x = A*(2*(randn(N,1)>0) - 1); % Generates +A and -A; both equally likely
    r = x + n; % Received signal
    
    % receive signal value decision algorithm
    for i = 1:1:1000
        if r(i) > 0
            received(i, 1) = A;
        elseif r(i) < 0
            received(i, 1) = -1 * A;
        end
    end
    
    %find the number of incorrect guesses
    incorrectReceive = 0;
    for k = 1:1:1000
       if x(k) ~= received(k , 1)
        incorrectReceive = incorrectReceive + 1;
       end
    end
    
    % store probabiltity of error and SNR values 
    Pe = incorrectReceive / 1000.000;
    PeValues(j) = incorrectReceive / 1000.000;
    SNRValues(j) = 10 * log10(A ^ 2 / var_n);

    j = j + 1;  %increment stored index
end

%plot probability vs SNR
% semilogy(SNRValues, PeValues);    

%%Section 3.3
% N = 1000;
% A = 5;
% x = A*((2*(randn(N,1)>0)) - 1); % Generates +A and -A; both equally likely
% y = 2*(randn(N,1)>0) - 1;   % Generates 1 and -1; both equally 
%                             % this will be used to determine if 
%                             % if A is placed on the x-axis or the 
%                             % y axis
%                             
% for i = 1:1:1000
%     if y(i) == 1        % if y = 1 place on y-axis 
%         y(i) = x(i);
%         x(i) = 0;
%     elseif y(i) == -1   % if y = -1 place on x-axis
%         y(i) = 0;
%     end
% end
%                                      
% scatter(x,y);
% 
% % test noise simulation
% var_n = 0.01; % Noise variance
% n = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n
% m = randn(N,1)*sqrt(var_n); % Zero-mean Gaussian noise with variance var_n 
% r = x + n; % Received signal
% y = y + m; % 
% 
% scatter(r,y);


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


