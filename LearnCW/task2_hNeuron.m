%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_hNeuron(W, X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
%  W : (D+1)-by-1 vector of weights (double)
% Output:
%  Y : N-by-1 vector of output (double)
  [n,d] = size(X);
  for i=1:n
    t = cat(2,[1],X(i,:))';
    su = W' * t;
    if(su >0) 
        Y(i) = 1;
    else
        Y(i) = 0;
    end
  end
  Y = Y';
end
