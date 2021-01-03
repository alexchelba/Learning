%
% Versin 0.9  (HS 06/03/2020)
%
function task1_1(X, Y)
% Input:
%  X : N-by-D data matrix (double)
%  Y : N-by-1 label vector (int32)
% Variables to save
%  S : D-by-D covariance matrix (double) to save as 't1_S.mat'
%  R : D-by-D correlation matrix (double) to save as 't1_R.mat'
  [n,d] = size(X);
  mu = sum(X)/n;
  X_shift = X;
  for i=1:n
       X_shift(i,:) = X_shift(i,:) - mu;
  end
  S = 1/(n) * (X_shift' * X_shift);
  
  s_c = sqrt(1/(n-1) * sum((X-mu).^2)); % standard deviation
  z_cm = bsxfun(@rdivide, X_shift, s_c);
  R = zeros(d,d);
  for i = 1:d
    for j = 1:d
      R(i,j) = (1/(n-1)) .* sum(z_cm(:,i) .* z_cm(:,j));
    end
  end
  
  %{
  % plot correlation matrix R
  imagesc(R);
  set(gca, 'XTick', 1:d); % center x-axis ticks on bins
  set(gca, 'YTick', 1:d); % center y-axis ticks on bins
  str = string(1:d);
  set(gca, 'XTickLabel', str); % set x-axis labels
  set(gca, 'YTickLabel', str); % set y-axis labels
  title('Correlation between samples', 'FontSize', 14); % set title
  colormap('jet'); % Choose jet or any other color scheme
  colorbar;
  %}
  save('t1_S.mat', 'S');
  save('t1_R.mat', 'R');
  
end
