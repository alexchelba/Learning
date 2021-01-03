%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_sNN_AB(X)
% Input:
%  X : N-by-D matrix of input vectors (double)
% Output:
%  Y : N-by-1 vector of output (double)
  WL1 = [-3861.22, 1616.192, -100;
      -6670.24, 1275.49, 1000;
      -639.49, -725.52, 1000;
      4967.65, -473.59, -1000];
  WL2 = [-8000, 2500, 2500, 2500, 2500];
  [n,d] = size(X);
  Zi = zeros(n,4);
  for i=1:4
      Zi(:,i) = task2_sNeuron(WL1(i,:)', X);
  end
  Y1 = task2_sNeuron(WL2', Zi);
  
  WL11 = [3675.70, -466.92, -1000; % BC
      772.25, 394.92, -1000]; % CD
  
  WL12 = [10703.02, -1465.78, -1000; % AB
      1710.13, 1422.81, -1000]; % AD
  
  WL2 = [-4000, 2500, 2500];
  NWL2 = [4000, -2500, -2500];
  [n,d] = size(X);
  
  Zi1h = zeros(n,2); % (~BC, ~ CD)
  for i=1:2
      Zi1h(:,i) = task2_sNeuron(WL11(i,:)', X);
  end
  Zi1 = task2_sNeuron(NWL2', Zi1h);
  
  Zi2h = zeros(n,2); % AB, AD
  for i=1:2
      Zi2h(:,i) = task2_sNeuron(WL12(i,:)', X);
  end
  Zi2 = task2_sNeuron(WL2', Zi2h);
  
  Zi = cat(2,Zi1, Zi2);
  Y2 = task2_sNeuron(WL2', Zi);
  
  Y1 = task2_sNeuron([400; -500], Y1);
  
  Zif = cat(2, Y1, Y2);
  Y = task2_sNeuron(WL2', Zif);
end
