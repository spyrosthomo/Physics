# Solution for Ex_5
#     We want to solve f(x) = 0. The f function is contained in "./functions/ex5_fun.m"
#------------------------------------------
# paths to functions 
addpath("../../Nonlinear_Eqns")
addpath("./functions")
#-------------------------------------------
# Define NR-parameters 
tol  = 1e-6; 
Nmax = 1e+4;
x0   = 2   ; 
a    = 1   ; 
b    = 4   ; 
%---------------------------------------------------
% nr solution 
sol1  = NewtonRaphson(x0, @ex5_fun, a, b, tol, Nmax); 
fprintf("# Solution with NR             : x = %.10f\n", sol1) 
% matlab commmands 
sol2  = fsolve(@ex5_fun, x0);
fprintf("# Solution with matlab commands: x = %.10f\n", sol2)