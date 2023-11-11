<<<<<<< HEAD
function x =  NewtonRaphsonND(x0, func, a, b, tol, Nmax)
  % add path to derivative 
  addpath("../../Derivatives")
=======
function NewtonRaphsonND(x0, func, a, b, tol, Nmax)
  % add path to derivative 
  addpath("/media/sthomopo/DATA/MATLAB/1_SCRIPTS/Computational_Fluid/Derivatives")
>>>>>>> 1491a078b435a13e987046c24c352040221f7fe8
  # Check inputs 
    # quantitative
  if (nargin < 6)
    Nmax = 1e+05; 
  endif
  if (nargin < 5) 
    tol = 1e-5; Nmax = 1e+05; 
  endif
  if (nargin < 4)
<<<<<<< HEAD
    fprintf("# !!! ERROR: Number of inputs < 4.\n") 
    return
  endif 
    # qualitative 
  if ( (size(a)!=size(b)) || (size(a)!=size(x0)) || (size(a)!=size(func(x0))) )
=======
    fprintf("# !!! ERROR: Number of inputs < 4.  ;')\n") 
    return
  endif 
    # qualitative 
  if (size(a)!=size(b) || (size(a)!=size(x0)) || (size(a)!=size(func(x0))) )
>>>>>>> 1491a078b435a13e987046c24c352040221f7fe8
    fprintf("# !!! ERRROR:  length of a, b, x0 should be the same.\n")
    return 
  endif
  %--------------------------------------------------
  n = size(a,1);
  x = zeros(n, 1);
  h = abs(b - a)/ Nmax;
  i = 0; 
  for i=1:Nmax
    J = Jacobian(func, x0, h); 
    x = x0 - J\func(x0);
    % exit condition : tolerance 
    if norm(x-x0, inf) < tol 
      fprintf("# Ended due to tolerance : tol = %f\n", tol)
      break;
    endif
    x0 = x;
  endfor
  if i == Nmax 
    fprintf("# Ended due to steps: i = %d\n", i ) 
  endif
  disp("#------------------------------------- NR -end --------------")
endfunction