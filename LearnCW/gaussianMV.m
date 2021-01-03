function y = gaussianMV(mu, covar, x)
    [h,d] = size(x);
    [j,k] = size(covar);
    if (j~=d) | (k~=d)
        error('dimension of cov matrix and data should match');
    end
    invcov = inv(covar);
    mu = reshape(mu, 1, d); % ensure mu is a row vector
    
    % replicate mu and subtract from each data point
    x = x - ones(h,1)*mu;
    fact = sum(((x*invcov).*x), 2);
    
    y = exp(-0.5*fact);
    y = y./sqrt((2*pi)^d*det(covar));
end