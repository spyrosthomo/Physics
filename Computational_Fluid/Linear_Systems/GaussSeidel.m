# Gauss-Seidel iterative method for solving linear systems of equations 
# A * x = b 
#  tol : tolerance 
#  x0  : starting point of the iteration
function x = GaussSeidel(A, b, x0, tol, Nmax)
  i=0;
  % check if Nmax is given. If not set it to a value 
  if nargin < 5 
    Nmax = 10^4;
  endif
  if nargin < 4
    Nmax = 1e+04; tol = 1e-5;
  endif
  % find the dimension of the problem
  n = size(A,1);
  for i = 1:Nmax 
    %one step forward
    x = GaussSeidelStep(A, b, x0); 
    %tolerance condition 
    if (norm(x - x0, inf) < tol) && (i > 5) 
      fprintf("# Stopped due to tolerance: || x-x0|| = %.6f\n", norm(x-x0, inf) );
      fprintf("# Steps: i = %d\n", i)
      break;
    endif
    x0 = x;
  endfor
  
  if i == Nmax 
    fprintf("# Ended due to steps: i = %d\n", i) 
  endif
endfunction