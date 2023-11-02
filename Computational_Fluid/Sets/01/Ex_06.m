# solution for Ex 06 
# Solution of the system F(x) =0. 
# F(x) is provided in the file "./functions/ex6_fun.m")
#----------------------------------
# add paths to the functions 
addpath("../../Nonlinear_Eqns")
addpath("./functions") 
#-------------------------------
%% Define NR-parameters 
tol  = 1e-6; 
Nmax = 1e+4;
x0   = [0.5, 2]'; 
a    = [0, 1]'; 
b    = [1, 3]';
#----------------------------------

%% NR  solution 
sol1 = NewtonRaphsonND(x0, @ex6_fun, a, b, tol, Nmax);
fprintf("#-------------------------------------------------------\n")
fprintf("# Solution with NR             : x = (%.10f, %,10f\n", sol1(1), sol1(2)) 
% matlab commmands 
options = optimset('Display', 'off');  % Optional: suppress output
[sol2, fval] = fsolve(@ex6_fun, x0, options);
fprintf("#-------------------------------------------------------\n") 
fprintf("# Solution with matlab commands: x = %.10f\n", sol2)