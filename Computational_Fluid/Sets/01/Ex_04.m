# Solution of Ex_04 using SOR method 
%   The solution is found with: - SOR iterative method 
%                               
%   Test method with the following. It has solution ones(4,1)
%
%        A = [ 2, -1, 0, 0; -1, 2 , -1, 0; 0, -1, 2, -1; 0, 0, -1 ,2 ]
%        b = [1; 0; 0; 1]
%
%------------------------------------------------------

# add path to code 
addpath("../../Linear_Systems")
#----
format compact
A     = [3, -1, 1; 3, 6, 2; 3, 3, 7]
b     = [1, 0, 4]' 

n     = size(A, 1);

%% Define initial conditions 
% starting point 
x0    = zeros(n, 1);
omega = 1.1;
% tol - Nmax
tol   = 1e-6; 
Nmax  = 1e+4;

%% Call Solvers
disp("# ---- SOR sol " )
fprintf("# omega    = %.4f\n", omega)
x =      SOR(A, b, omega, x0, tol, Nmax); 
disp("#----------------------------");
disp("#    ==  PRINT RESULTS  ==   "); 

%% Print
disp("# The SOR       solution         is : " ) 
x'
disp("# The solution with MATLAB commands is : " ) 
(A\b)'