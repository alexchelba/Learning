function [confmat] = comp_confmat(test_labels, test_pred)
    k = unique(test_labels);
    confmat = zeros(length(k));
    for i=1:length(k)
        for j=1:length(k)
            s1 = sum(test_labels==k(i)&test_pred==k(j));
            confmat(i,j) = s1;
        end
    end
end