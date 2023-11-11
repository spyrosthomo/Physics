%% Solution of the following system with the methods: 
%      1.) Explicit Euler 
%      2.) Implicit Euler 
%      3.) RK2
%      4.) RK3
%      5.) RK4
%  y'(x) = x + y,  with y(0)=0 and 0<=x<=1
%-----------------------------------------------------------------------

%path to ODE functions 
addpath("../../ODEs/")
addpath("./functions/")
%% settings for solution
a    = 0;
b    = 1; 
Nmax = 20; 
y0   = 0; 
h    = (b-a)/Nmax; 
x    = ones(Nmax+1, 1);
for i = 1:Nmax+1
  x(i) = a + (i-1)*h;
endfor

%% solution with different methods 
yExplicitEuler = ExplicitEuler(@fun_ex_set02, a, b, y0, Nmax) ;
yImplicitEuler = ImplicitEuler(@fun_ex_set02, a, b, y0, Nmax) ; 
yRungeKutta2   = RungeKutta2(@fun_ex_set02  , a, b, y0, Nmax);
yRungeKutta3   = RungeKutta3(@fun_ex_set02  , a, b, y0, Nmax); 
yRungeKutta4   = RungeKutta3(@fun_ex_set02  , a, b, y0, Nmax); 
%analytic
yAnalytic = -x - 1 + exp(x);

% plot Solution
figure(1)
ms = 2; lw1 = 2; lw2 = 1.5;
plot(x, yAnalytic, "k-", "markersize", ms, "linewidth", lw1)
hold on
plot(x, yExplicitEuler, "r--o", "markersize", ms, "linewidth", lw2)
plot(x, yImplicitEuler, "g--+", "markersize", ms, "linewidth", lw2)
plot(x, yRungeKutta2  , "b--*", "markersize", ms, "linewidth", lw2)
plot(x, yRungeKutta3  , "m--x", "markersize", ms, "linewidth", lw2)
plot(x, yRungeKutta4  , "c--s", "markersize", ms, "linewidth", lw2)

legend('Analytic', 'Explicit Euler', 'Implicit Euler', 'Runge-Kutta-2',  
        'Runge-Kutta-3', 'Runge-Kutta-4', 'location', 'northwest', 'FontSize', 26)
xlabel("x")
ylabel("y(x)")
ylim([0, 0.85])
title("Solution of y'=y+x wtih different methods", 'FontSize', 18) 
grid on 
hold off

%--------------------------------------------------------------------

%% difference from analytic  
dyExplicitEuler = abs(yAnalytic-yExplicitEuler);
dyImplicitEuler = abs(yAnalytic-yImplicitEuler);
dyRungeKutta2   = abs(yAnalytic-yRungeKutta2);
dyRungeKutta3   = abs(yAnalytic-yRungeKutta3);
dyRungeKutta4   = abs(yAnalytic-yRungeKutta4);

% plot diff prom analytic
figure(2)
ms = 2; lw1 = 2; lw2 = 1.5;
hold on
plot(x, dyExplicitEuler, "r--o", "markersize", ms, "linewidth", lw2)
plot(x, dyImplicitEuler, "g--+", "markersize", ms, "linewidth", lw2)
plot(x, dyRungeKutta2  , "b--*", "markersize", ms, "linewidth", lw2)
plot(x, dyRungeKutta3  , "m--x", "markersize", ms, "linewidth", lw2)
plot(x, dyRungeKutta4  , "c--s", "markersize", ms, "linewidth", lw2)

legend('Explicit Euler', 'Implicit Euler', 'Runge-Kutta-2',  
        'Runge-Kutta-3', 'Runge-Kutta-4', 'location', 'northwest', 'FontSize', 26)
xlabel("x")
ylabel("|y_{num} - y_{analytic}|", 'FontSize',13)
title("Difference |Numerical - Analytic|", 'FontSize', 18)
grid on
hold off

% save data to files
steps = linspace(1, Nmax+1, Nmax+1)';
M1    = [steps, x, fun_ex_set02(x, yAnalytic), yAnalytic];   % i, x, F(x,y), yAnal
M2    = [yExplicitEuler, yImplicitEuler, yRungeKutta2, yRungeKutta3, yRungeKutta4]; % from methods
M3    = [dyExplicitEuler, dyImplicitEuler, dyRungeKutta2, dyRungeKutta3, dyRungeKutta4]; % errrors
dlmwrite('common.txt', M1, 'delimiter', '&','precision','%.2f');
dlmwrite('values.txt', M2, 'delimiter', '&','precision','%.2f'); 
dlmwrite('errors.txt', M3, 'delimiter', '&','precision','%.2f'); 
 