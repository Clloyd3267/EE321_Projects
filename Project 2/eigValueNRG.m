function [eig_val_nrg, num_comp, eig_val_sorted] = eigValueNRG(eig_value)
% sort eigenvalues
[~,ind] = sort(eig_value, "descend");
eig_val_sorted = eig_value(ind);

% find energy of sorted eigenvalues
eig_val_sum = 0;
for i=1:length(eig_val_sorted)
    eig_val_sum = eig_val_sum + (eig_val_sorted(i)^2);
end
eig_val_nrg = zeros(length(eig_val_sorted):1);
for i=1:length(eig_value)
    eig_val_nrg(i) = (eig_val_sorted(i)^2)/eig_val_sum;
end
eig_val_nrg = eig_val_nrg(:);

% find number of eigenvalues to represent 90% of data
eig_nrg_sum = 0;
for i=1:length(eig_val_nrg)
    eig_nrg_sum = eig_nrg_sum + eig_val_nrg(i);
    if eig_nrg_sum >= 0.9
        num_comp = i;
        break
    end
end
end