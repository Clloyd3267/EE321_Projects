% -------------------------------------------------------------------------
% Name        : EE321_Project_2.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 2)
% Due Date    : 2020-10-02
% Description : CDL=> Fill in later
% -------------------------------------------------------------------------

%% Original File ("gen_data.csv"):

% Clear the workspace and console
clear; clc;

% Examine the Data:

% Read in data
data = readmatrix("gen_data.csv");

% Output dimensions of data
[r, c] = size(data)

% Display data in a scatterplot
scatter3(data(:,1),data(:,2),data(:,3));

% Principal Component Analysis (PCA):

% Calculate Mean
m = mean(data);

% Subtract mean from each data sample
dm = data - repmat(m,r,1);

% Find Co-Variance Matrix
cd=(1/(r-1))*(dm.'*dm);

% Do EigenDecomposition
[Qd, Dd] = eig(cd);

% Dimensionality Reduction:

% Sort the eigenvalues in decending order
eigValue = diag(Dd);
[~,ind] = sort(eigValue, "descend");
eigValSorted = eigValue(ind);
eigVecSorted = Qd(:,ind);

% Condition Number
Cd = max(eigValue) / min(eigValue);

% Cd >> 1 indicating Highly ill-conditioned matrix

% Calculate energy for each Eigenvalue
% eigenEnergy(n) = eigValue(n)^2 / (ΣeigValue()^2)
eigenEnergy = eigValSorted.^2./sum(eigValSorted.^2);

% Find number of Eigen values needed to represent 90% of data
eigenEnergySum = 0;
for i = 1:length(eigenEnergy)
  eigenEnergySum = eigenEnergySum + eigenEnergy(i);
  if eigenEnergySum >= 0.9
    num_comp = i;
    break
  end
end

% In this case, 1 Eigen value is enough

% Select the eigenvector(s) corresponding to the highest valued eigenvalue
prinComps = eigVecSorted(:,1:num_comp);
reconstructedData = data * prinComps;

% Visualize data
figure
scatter(reconstructedData,zeros(size(reconstructedData)));

% The plot indicates that there are two clusters of data that resulted from
% the projection of the three dimensional data clusters onto a singular 
% dimension.

%% 3. Higher Dimensional Data
clear; clc;
%load data
newData = readmatrix("gen_data2.csv");

% Find Dimensionality of the data
[row, c] = size(newData);

% Visualize the data

% find the mean of the data
gen2Mean = mean(newData);

% Subtract mean from each data sample
dm = newData - repmat(gen2Mean, row, 1);

% Find Co-Variance Matrix
cd=(1/(row-1))*(dm.'*dm);

% Do EigenDecomposition
[Qd, Dd] = eig(cd);

% Sort the eigenvalues in descending order
eigValue = diag(Dd);
[~,ind] = sort(eigValue, "descend");
eigValSorted = eigValue(ind);
eigVecSorted = Qd(:,ind);

%find sum of squares for the eigenvectors
sumSquares = 0;

%sum the squared eigen values
for eigenVectors = 1:size(eigValue)
    sumSquares = sumSquares + eigValue(eigenVectors, 1) * eigValue(eigenVectors, 1);
end

%display percentage energy contained in eigen vector
percentageEnergy = size(Dd):1;
for eigenVector = 1:size(Dd)
    percentageEnergy(eigenVector, 1) = Dd(eigenVector, eigenVector) / sumSquares; %display percentages as assigning
end

%Apply PCA and find the minimum number of dimensions needed to
%represent > 90% of the energy of the data
Dimensions = 0;
sum = 0;
for i = size(percentageEnergy):-1:1
    sum = sum + percentageEnergy(i, 1);
    if sum < .9
        Dimensions = Dimensions + 1;
    end
end

%Reconstruct the low dimensional data and visualize it.
prin_comps = eigVecSorted(:,1:Dimensions);
reconstructedData = newData * prin_comps;

%display figure of reconstructed data
figure

scatter3(reconstructedData(:,1), reconstructedData(:,2), reconstructedData(:,3));
title('gen data2 Dimensioned plot');

%% 4. Keystroke Data
%clear; clc;
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

eigValue = diag(Dd);
[~,ind] = sort(eigValue, 'descend');
eigValSorted = eigValue(ind);
eigVecSorted = Qd(:,ind);

% Condition Number - Cd >> 1 indicating Highly ill-conditioned matrix
Cd = max(eigValue) / min(eigValue);

[eig_value_nrg, num_comp] = eigValueNRG(eigValue);

prin_comps = eigVecSorted(:,1:num_comp);
reconstructed_data = data*prin_comps;

% Visualize data
figure
scatter(reconstructed_data,zeros(size(reconstructed_data)));
