# Newton's method for solving non-linear equation
function x = NewtonRaphson(x0, func, a, b, tol, Nmax) 
  % add path to derivative 
  addpath("../../Derivatives")
  % Check inputs 
  if ( nargin < 6 )
    Nmax = 1e+3;
  endif 
  if ( nargin < 5 )
    Nmax = 1e+3; tol = 1e-5;
  endif
  %--------------------------------------------------
  % Newton Raphson method 
  x = 0; funcd = 0; i = 0;
  h = ( b - a ) / Nmax;
  for i = 1:Nmax 
    if (abs(funcd) > tol*1e-4) || (i > 10) 
      funcd = der1_central(func, x0, h);         % derivative of func, given by central diffs  
      x     = x0 - func(x0)/funcd; 
      % tol condition
      if abs(x-x0) < tol 
        fprintf("# Ended due to tol : tol = %f\n", tol)
        break;
      endif
      x0 = x; 
     endif
  endfor
  if i == Nmax 
    fprintf("# Ended due to steps: i = %d\n", i ) 
  endif
  disp("#------------------------------------- NR -end--------------")
endfunction