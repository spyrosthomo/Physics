# Gauss-Seidel iterative method for solving linear systems of equations 
# A * x = b 
#  tol : tolerance 
#  x0  : starting point of the iteration
#omega : relaxation parameter 
function x = SOR(A, b, omega, x0, tol, Nmax)
  i=0;
  % check if Nmax, tol are given. If not set them to a default 
  if nargin  < 6
    Nmax = 10^4;
  endif 
  if nargin  < 5
    Nmax = 10^4; tol = 1e-6;
  endif
  % check omega 
  if omega <= 0 
    fprintf("# omega MUST be postitive. Current value is omega = %.4f", omega) 
    return;
  endif
  %----------------------------------------------------------------------
  % find the dimension of the problem
  n = size(A,1);
  for i = 1:Nmax 
    %one step forward
    x = SORStep(A, b, omega, x0); 
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