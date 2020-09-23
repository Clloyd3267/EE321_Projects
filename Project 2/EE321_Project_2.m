% -------------------------------------------------------------------------
% Name        : EE321_Project_2.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 2)
% Due Date    : 2020-10-02
% Description : CDL=> Fill in later
% -------------------------------------------------------------------------

%% 1. Examine the Data:
% Read in data
data = readmatrix("gen_data.csv");

% Output dimensions of data
[r, c] = size(data)

% Display data in a scatterplot
scatter3(data(:,1),data(:,2),data(:,3));

%% 2. Dimensionality Reduction:

% 2.1. Principal Component Analysis (PCA):

% Calculate Mean
m = mean(data);

% Subtract mean from each data sample
dm = data - repmat(m,r,1);

% Find Co-Variance Matrix
cd=(1/(r-1))*(dm.'*dm);

% Do EigenDecomposition
[Qd, Dd] = eig(cd);

% 2.2. Dimensionality:

% Sort the eigenvalues in decending order
eig_value = diag(Dd);
[~,ind] = sort(eig_value, "descend");
eig_val_sorted = eig_value(ind);
eig_vec_sorted = Qd(:,ind);

% Condition Number - Cd >> 1 indicating Highly ill-conditioned matrix
Cd = max(eig_value) / min(eig_value);

% Select the eigenvector corresponding to the highest valued eigenvalue
num_comp = 1;
prin_comps = eig_vec_sorted(:,1:num_comp);
reconstructed_data = data*prin_comps;

% Visualize data
figure
scatter(reconstructed_data,zeros(size(reconstructed_data)));

%%The plot indicates that there are two clusters of data that resulted from
%%the projection of the three dimensional data clusters onto a singular dimension.

%% 3. Higher Dimensional Data

%load data
newData = readmatrix("gen_data2.csv");

% Find Dimensionality of the data
[row, c] = size(newData)

% Visualize the data

% find the mean of the data
gen2Mean = mean(newData);

% Subtract mean from each data sample
dm = newData - repmat(gen2Mean, row, 1);

% Find Co-Variance Matrix
cd=(1/(row-1))*(dm.'*dm);

% Do EigenDecomposition
[Qd, Dd] = eig(cd);

% Sort the eigenvalues in decending order
eig_value = diag(Dd);
[~,ind] = sort(eig_value, "descend");
eig_val_sorted = eig_value(ind);
eig_vec_sorted = Qd(:,ind);

%find sum of squares for the eigenvectors
sumSquares = 0;
for eigenVectors = 0:size(eig_value)
    sumSquares = sumSquares + eig_value(eigenVectors, 1);
end

%display percentage energy contained in eigen vector
for eigenVector = 0:size(Dd)
    percentageEnergy = Dd(eigenVector, eigenVector) / sumSquares
end


%Apply PCA and find the minimum number of dimensions needed to
%represent > 90% of the energy of the data
%Reconstruct the low dimensional data and visualize it.
%Interpret the data

%% 4. Keystroke Data
clear; clc;
data = readmatrix("keystroke_data.csv");

% Output dimensions of data
[r, c] = size(data);

m = mean(data);

% Subtract mean from each data sample
dm = data - repmat(m,r,1);

% Find Co-Variance Matrix
cd=(1/(r-1))*(dm.'*dm);

% Do EigenDecomposition
[Qd, Dd] = eig(cd);

eig_value = diag(Dd);
[~,ind] = sort(eig_value, 'descend');
eig_val_sorted = eig_value(ind);
eig_vec_sorted = Qd(:,ind);

% Condition Number - Cd >> 1 indicating Highly ill-conditioned matrix
Cd = max(eig_value) / min(eig_value);

[eig_value_nrg, num_comp] = eigValueNRG(eig_value);

prin_comps = eig_vec_sorted(:,1:num_comp);
reconstructed_data = data*prin_comps;

% Visualize data
figure
scatter(reconstructed_data,zeros(size(reconstructed_data)));
