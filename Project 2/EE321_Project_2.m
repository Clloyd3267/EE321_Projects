%%------------------------------------------------------------------------------
% Name        : EE321_Project_2.m
% Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
% Class       : EE321 (Project 2)
% Due Date    : 2020-10-02
% Description : Data analysis using Dimensionality Reduction and PCA techniques
% ------------------------------------------------------------------------------

%% Original File ("gen_data.csv"):

% Clear the workspace and console
clear; clc;

% Examine the Data:

% Read in data
data = readmatrix("gen_data.csv");

% Output dimensions of data
[r, c] = size(data)

% Data dimensions: 200 rows, 3 cols

% Display data in a scatterplot
scatter3(data(:,1),data(:,2),data(:,3));

% Two clusters of data points on top of each other.

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
cNumber = max(eigValue) / min(eigValue);

% cNumber >> 1 indicating Highly ill-conditioned matrix

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

%% Higher Dimensional Data ("gen_data2.csv"):

% Clear the workspace and console
clear; clc;

% Examine the Data:

% Read in data
data = readmatrix("gen_data2.csv");

% Output dimensions of data
[r, c] = size(data)

% Data dimensions: 300 rows, 3 cols

% Display data in a scatterplot
figure
scatter3(data(:,1),data(:,2),data(:,3));

% Three clusters of data points with two next to each other both on top of
% the third.

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
cNumber = max(eigValue) / min(eigValue);

% cNumber >> 1 indicating Highly ill-conditioned matrix

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

% In this case, 2 Eigen values is enough

% Select the eigenvector(s) corresponding to the highest valued eigenvalue
prinComps = eigVecSorted(:,1:num_comp);
reconstructedData = data * prinComps;

% Visualize data
figure
scatter(reconstructedData(:,1),reconstructedData(:,2));

% The plot indicates that there are three clusters of data that resulted from
% the projection of the three dimensional data clusters onto two dimensions.

%% Keystroke Data ("keystroke_data.csv"):

% Clear the workspace and console
clear; clc;

% Examine the Data:

% Read in data
data = readmatrix("keystroke_data.csv");

% Output dimensions of data
[r, c] = size(data)

% Data dimensions: 200 rows, 21 cols

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
cNumber = max(eigValue) / min(eigValue);

% cNumber >> 1 indicating Highly ill-conditioned matrix

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
% the projection of the 21 dimensional data clusters onto a singular 
% dimension.
