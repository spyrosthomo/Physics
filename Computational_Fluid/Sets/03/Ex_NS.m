clear;format compact

%% Number of points 
N      = [5, 10, 50, 100, 10^3]; 
sols   = length(N);
Nmax   = max(N)
Dr     = 1/(Nmax-1);
r      = ((0:Nmax-1)*Dr)';
%% Analytical Solutions 
uAnal  = @(r) (r.^2 -1)/4;  

%% Find & plot solutions 
figure(1)
ms = 2; lw1 = 1.5; lw2 = 1;
%plot analytical 
plot(r, uAnal(r), "r--", "markersize", ms, "linewidth", lw2)
sprintf("---------- Analytical ------------------\n")
sprintf("u*_max = %.8f\n", max(abs(uAnal(r))))
sprintf("<u*>   = %.8f\n", 2*trapz(r, abs(r.*uAnal(r)))) 

leg = {};%zeros(sols+1); 
leg{1} = "Analyical";
hold on
for i = 1:sols 
  sprintf(" ---------------- N = %d ----------------\n", N(i))
  Dr = 1/(N(i)-1);
  r  = ((0:N(i)-1)*Dr)';
  % find solutions 
  u = NS_cyl(N(i));
  % plot Solution
  plot(r, u, "-", "markersize", ms, "linewidth", lw1)
  hold on
  leg{i+1} = sprintf("N=%d", N(i));
  sprintf("u*_max = %.8f\n", max(abs(u)))
  sprintf("<u*>   = %.8f\n", 2*trapz(r, abs(r.*u)))
endfor
legend(leg, 'location','northwest', "FontSize", 14)
xlabel("r^*=r/R")
ylabel("u_z^*(r^*)=u_z(r)/U")
title("Solution of NS equations with cylindrical symmetry ", 'FontSize', 14) 
grid on 
saveas(gcf, './plots/NS_solutions.jpg');
hold off

%% plot abs diffs
N    = [50, 100, 1000, 10000]; 
sols = length(N);
leg2 = {}; 
figure(2) 
hold on 
for i = 1:sols
  Dr = 1/(N(i)-1);
  r  = ((0:N(i)-1)*Dr)';
  % find solutions 
  u = NS_cyl(N(i));  % plot Solution
  plot(r, abs(u-uAnal(r)), "-", "markersize", ms, "linewidth", lw1)
  hold on
  leg2{i} = sprintf("N=%d", N(i));  
endfor
legend(leg2, 'location','northwest', "FontSize", 14)
xlabel("r^*=r/R")
ylabel("|u_z^*(r^*)-u^*_{analytic}|")
title("Absolute differences ", 'FontSize', 14) 
grid on 
saveas(gcf, './plots/NS_absDiff.jpg');
hold off
