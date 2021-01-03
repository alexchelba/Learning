%
% Versin 0.9  (HS 06/03/2020)
%
function task1_3(Cov)
% Input:
%  Cov : D-by-D covariance matrix (double)
% Variales to save:
%  EVecs : D-by-D matrix of column vectors of eigen vectors (double)  
%  EVals : D-by-1 vector of eigen values (double)  
%  Cumvar : D-by-1 vector of cumulative variance (double)  
%  MinDims : 4-by-1 vector (int32)  

  [EVecs, EVals] = eig(Cov);
  EVals = diag(EVals);
  [tmp, ridx] = sort(EVals,1,'descend');
  EVals = EVals(ridx);
  EVecs = EVecs(:,ridx);
  EVecs_plot = EVecs;
  d = length(EVecs);
  for i=1:d
      if EVecs(1,i)<0
          EVecs(:,i) = EVecs(:,i).*(-1);
      end
  end 
  Cumvar = cumsum(EVals);
  s = sum(EVals);
  d1 = length(EVals);
  MinDims = zeros(4,1);
  for i=1:d1
    if 100 * Cumvar(i)/ s >=95
      MinDims(4) = i;
      break;
    else
      if 100 * Cumvar(i)/ s >=90
        MinDims(3) = i;
      else
        if 100 * Cumvar(i)/ s >=80
          MinDims(2) = i;
        else
          if 100 * Cumvar(i)/ s >=70
            MinDims(1) = i;
          end
        end
      end
    end
  end
  
  %{
  % plot graph of cumulative variance
  x = [1:d];
  plot(x,Cumvar,'--*');
  % legend(data_names, 'Location', 'southeast');
  title('Cumulative Variance Plot', 'FontSize', 14);
  xlabel('Indices');
  ylabel('Cumulative Variance');
  %}
  
  %{
  % plot 2D-PCA plane
  % needs X and Y as additional parameters
  PC_X = X * EVecs_plot;
  % plot the data in the new basis
  m = length(Y);
  colors = [0.8500, 0.3250, 0.0980;
      0.9290, 0.6940, 0.1250;
      0.4940, 0.1840, 0.5560;
      0, 0.4470, 0.7410;
      0.4660, 0.6740, 0.1880;
      0.3010, 0.7450, 0.9330;
      0.6350, 0.0780, 0.1840;
      0, 0.75, 0.75;
      0, 0.5, 0;
      1, 0, 0];
  for i=1:length(X)
    color1 = colors(Y(i),:);
    p(Y(i))=plot(PC_X(i,1),PC_X(i,2),'Marker','o','MarkerFaceColor',color1);
    p(Y(i)).DisplayName = num2str(Y(i));
    hold on;
  end
  legend(p);
  xlabel('First Principal Component');
  ylabel('Second Principal Component');
  hold on;
  % Plot the first new basis
  hh = refline(EVecs_plot(2,1)/EVecs_plot(1,1), 0);
  hh.Color = 'r';
  hold on;
  % Plot the second new basis
  hh = refline(EVecs_plot(1,2)/EVecs_plot(2,2), 0);
  hh.Color = [0.7 0.7 0.1];
  box on;
  axis([-2.5, 0.5, -1, 1.2]);
  %}
  
  save('t1_EVecs.mat', 'EVecs');
  save('t1_EVals.mat', 'EVals');
  save('t1_Cumvar.mat', 'Cumvar');
  save('t1_MinDims.mat', 'MinDims');
end
