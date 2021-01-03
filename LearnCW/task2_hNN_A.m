%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_hNN_A(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
  WL1 = [-0.386122, 0.1616192, -0.01;
      -0.667024, 0.127549, 0.1;
      -0.63949, -0.72552, 1;
      0.496765, -0.047359, -0.1];
  WL2 = [-0.75, 0.25, 0.25, 0.25, 0.25];
  [n,d] = size(X);
  Zi = zeros(n,4);
  for i=1:4
      Zi(:,i) = task2_hNeuron(WL1(i,:)', X);
  end
  Y = task2_hNeuron(WL2', Zi);
end
