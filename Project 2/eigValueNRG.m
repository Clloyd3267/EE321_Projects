function [eig_value_nrg] = eigValueNRG(eig_value)
eig_value_sum = 0;
for i=1:length(eig_value)
    eig_value_sum = eig_value_sum + (eig_value(i) * eig_value(i));
end
eig_value_nrg = zeros(length(eig_value):1);
for i=1:length(eig_value)
    eig_value_nrg(i) = (eig_value(i) * eig_value(i))/eig_value_sum;
end
end