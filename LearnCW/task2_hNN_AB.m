%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_hNN_AB(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
  Y1 = task2_hNN_A(X);
  
  WL11 = [0.367570, -0.046692, -0.1; % BC
      0.77225, 0.39492, -1]; % CD
  
  WL12 = [0.1070302, -0.0146578, -0.01; % AB
      0.171013, 0.142281, -0.1]; % AD
  
  WL2 = [-0.4, 0.25, 0.25];
  NWL2 = [0.4, -0.25, -0.25];
  [n,d] = size(X);
  
  Zi1h = zeros(n,2); % (~BC, ~ CD)
  for i=1:2
      Zi1h(:,i) = task2_hNeuron(WL11(i,:)', X);
  end
  Zi1 = task2_hNeuron(NWL2', Zi1h);
  
  Zi2h = zeros(n,2); % AB, AD
  for i=1:2
      Zi2h(:,i) = task2_hNeuron(WL12(i,:)', X);
  end
  Zi2 = task2_hNeuron(WL2', Zi2h);
  
  Zi = cat(2,Zi1, Zi2);
  Y2 = task2_hNeuron(WL2', Zi);
  
  Y1 = task2_hNeuron([0.4; -0.5], Y1);
  
  Zif = cat(2, Y1, Y2);
  Y = task2_hNeuron(WL2', Zif);
end
