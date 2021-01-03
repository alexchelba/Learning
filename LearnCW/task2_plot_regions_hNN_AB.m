%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_AB.m
function task2_plot_regions_hNN_AB()

  cmap = [0.255,0.160,0.122;
        0.135,0.206,0.250;
        0.100,0.100,0.200];
    
  A = [2.62005, 3.72683; 
      2.5972, 3.35753; 
      3.01383, 2.82612; 
      3.60945, 3.25826;
      3.11324, 6.1397; 
      7.03536, 0.390731; 
      3.36885, 2.10271; 
      -0.912428, 0.411915];
  
  C = task2_hNN_AB(A);
  Xp = linspace(min(A(:,1)), max(A(:,1)), 2000)';
  Yp = linspace(min(A(:,2)), max(A(:,2)), 2000)';
  % Obtain the grid vectors for the two dimensions
  [Xv Yv] = meshgrid(Xp, Yp);
  gridX = [Xv(:), Yv(:)]; % Concatenate to get a 2-D point.
  cls = task2_hNN_AB(gridX);
  
  figure;
  % This function will draw the decision boundaries
  [CC,h] = contourf(Xp(:), Yp(:), reshape(cls, length(Xp), length(Yp)));
  set(h,'LineColor','g');
  colormap(cmap); hold on;
  
  % Plot the scatter plots grouped by their classes
  scatters = gscatter(A(:,1), A(:,2), C, [0,0,0], 'o', 4);
  % Fill in the color of each point according to the class labels.
  for n = 1:length(scatters)
    set(scatters(n), 'MarkerFaceColor', cmap(n,:));
  end
  axis([-3,9.1,-0.5,7]);
end