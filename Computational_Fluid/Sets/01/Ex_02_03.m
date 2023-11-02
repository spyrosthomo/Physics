% solution of the system in Ex_02, Ex_02
%   The solution is found with: - Jacobi       iterative method 
%                               - Gauss-Seidel iterative method
%   Test method with the following. It has solution ones(4,1)
%
%        A = [ 2, -1, 0, 0; -1, 2 , -1, 0; 0, -1, 2, -1; 0, 0, -1 ,2 ]
%        b = [1; 0; 0; 1]
%
%------------------------------------------------------
format compact
% add path to the code 
addpath("../../Linear_Systems")

% define the A X = b, for ex 03,04
A    = [3, -1, 1; 3, 6, 2; 3, 3, 7]
b    = [1; 0; 4]


n    = size(A, 1);

%% Define initial conditions 
% starting point 
x0   = zeros(n, 1);
% tol - Nmax
tol  = 1e-6; 
Nmax = 1e+4;

%% Call Solvers
disp(" ---- Jacobi sol " )
x =      Jacobi(A, b, x0, tol, Nmax); 
disp(" ---- GS     sol " ) 
y = GaussSeidel(A, b, x0, tol, Nmax); 
disp("----------------------------");
disp("    = =  PRINT RESULTS =="   ); 
%% Print
disp("# The Jacobi       solution         is : " ) 
x' 
disp("# The Gauss-Seidel solution         is : " )
y'
disp("# The solution with MATLAB commands is : " ) 
(A\b)'

