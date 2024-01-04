clear; format compact
addpath("../../Linear_Systems")
%% Number of points 
N      = [10 30 50 70 90 110] ;%, 10, 50, 100, 10^3]; 
sols   = length(N);
%----------------------------------------------------------
%% Find & plot solutions 
ms = 2; lw1 = 1.5; lw2 = 1;
maxValue = []; maxRow = []; maxCol = []; maxIndex = []; 
umean  = [];
emean  = []; 
for i = 1:sols 
  printf(" ---------------- N = %d ----------------\n", N(i))
  h        = 1/(N(i)+1);
  x        = ((0:N(i)+1)*h)';
  y        = ((0:N(i)+1)*h)';
  [X, Y]   = meshgrid(x, y); 
  % construct & find solutions
  [A, b]   = NS_elliptic(N(i), h, @f1);  
  x0       = (1:N(i)*N(i)).^2';
  w        = A\b;
  %w        = Jacobi(A, b, x0, 1e-5, 2800); 
  u        = reshape(w, N(i) , N(i));
  emean(i) = trapz(trapz(X, 2), 1); 
  umean(i) = 0.5*trapz(w)/emean(i); 
  %-------------------------------------------------
  %% plot Solution
  % 3D-plot
  figure;
  leg = {};
  mesh(X(2:end-1, 2:end-1), Y(2:end-1, 2:end-1) , u)%, "-", "markersize", ms, "linewidth", lw1)
  hold on
  leg = sprintf("N=%d", N(i));
  legend(leg, 'location','northwest', "FontSize", 14)
  xlabel("x^*=x/a")
  ylabel("y^*=y/a")
  zlabel("u_z^*(x^*, y^*)=u_z(x, y)/U")
  title(sprintf("Solution of NS equations in square pipe for N=%d\n",N(i)), 'FontSize', 14) 
  grid on 
  saveas(gcf, sprintf('./plots/NS_elliptic_3sol%d.jpg', N(i)));
  hold off
  %---------------------
  % contour
  figure;
  contour(X(2:end-1, 2:end-1), Y(2:end-1, 2:end-1) , u)
  hold on 
  xlabel("x^*=x/a")
  ylabel("y^*=y/a") 
  title(sprintf("Contour plot for NS solution in square pipe, N=%d\n", N(i)),...
           'FontSize', 14, 'Position', [0.5, 1.05, 0])
  grid on
  % Find the maximum value and its indices
  [maxValue(i), maxIndex(i)] = max(u(:));
  [maxRow(i), maxCol(i)]     = ind2sub(size(u), maxIndex(i));
  % Add a red dot at the maximum point
  hold on
  plot(X(maxRow(i), maxCol(i)), Y(maxRow(i), maxCol(i)), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
  % Display the maximum value near the contour line
  text(X(maxRow(i), maxCol(i)), Y(maxRow(i), maxCol(i)), sprintf('Max: %.4f', maxValue(i)), ...
       'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Color', 'red', 'FontSize', 10);
  colorbar('location', 'eastoutside', 'fontsize', 10);
  fn = sprintf('./plots/NS_elliptic_Contour_sol%d.jpg', N(i));
  saveas(gcf, fn);
  hold off
  %printf("u*_max = %.8f\n", max(abs(u)))
  % sprintf("<u*>   = %.8f\n", 2*trapz(r, abs(r.*u)))
endfor

%% plot max movement 
figure;
%suptitle(sprintf("Movement of maximum velocity with varying number mesh points N")) 
colors = jet(length(N));

% in x direction 
subplot(2, 2, 1) 
for i=1:length(N)
  scatter(X(maxRow, maxCol)(1,i), maxValue(i), 30, colors(i,:), 'filled'   );
  hold on;
endfor
xlabel(sprintf("x^*=x/a"))
ylabel(sprintf("max(u)"))
%legend('location','northwest', "FontSize", 14)

%----
% in y direction 
subplot(2, 2, 2) 
for i=1:length(N)
  scatter(Y(maxRow, maxCol)(i,1), maxValue(i), 30, colors(i,:), 'filled'   );
  hold on;
endfor
xlabel(sprintf("y^*=y/a"))
ylabel(sprintf("max(u)") )
%legend('location','northwest', "FontSize", 14)

% x-y
subplot(2, 2, 3:4)
for i=1:length(N)
  scatter(X(maxRow, maxCol)(1,i), Y(maxRow, maxCol)(i,1), 50, colors(i,:), 'filled', ...
      'DisplayName', sprintf('N=%d',N(i)));
  hold on;
endfor 
legend('location','eastoutside', "FontSize", 14)
ylim([0, 0.6])
xlim([0, 0.6])
line([0.5, 0.5], [0, 0.5], "linestyle", "-", "color", "black", 'HandleVisibility', 'off');
line([0, 0.5], [0.5, 0.5], "linestyle", "-", "color", "black", 'HandleVisibility', 'off');
xlabel(sprintf("x^*=x/a"))
ylabel(sprintf("y^*=y/a"))
axes( 'visible', 'off', 'title',"Movement of velocity maximum with varying mesh points N" );
saveas(gcf, sprintf("./plots/NS_elliptic_max_movement.jpg"));


%-----------------------------------
% figure umean 
figure;
for i=1:length(N)
  scatter(i, umean(i), 30, 'filled', 'DisplayName', sprintf("N=%d",N(i)))
  hold on;
endfor
ylabel(sprintf("<u^*_z>"))
legend('location', 'eastoutside', 'FontSize', 14)
title("Mean velocity value for varying N")
saveas(gcf, sprintf("./plots/NS_elliptic_umean.jpg"))
