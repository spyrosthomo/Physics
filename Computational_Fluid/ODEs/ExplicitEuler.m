%% Implementation of explicit Euler method  to solve the eq 
%                 dy/dx = f(x,y) 
% Method: 
%      y_n = y_{n-1} + h * f(x_i, y_i) 
%         y_0 = y0, known 
%---------------------------------------------------------------
% inputs   :  . a, b    : interval 
%             . y0      : y(x0) " Initial condition" 
%             . Nmax    : maximum steps
%             . hin     : h from input 
%    !!       . func    : the f(x,y) function that defines the problem 
%
% OUTPUT   :  . a vector Nmax x 1 containing the solution y_i at each x_i
%---------------------------------------------------------------
function y = ExplicitEuler(func, a, b, y0, Nmax)%, hin) 
  %% check if Nmax is given. If not set it to a value 
  if nargin < 5
    Nmax = 1e+04
  endif
  %------------------------------------------
  %% Define/initialize parameters/variables
  h    = (b - a)/Nmax ;  % step 
  y    = zeros(Nmax, 1); 
  y(1) = y0;  
  x(1) = a; 
  for i = 2:Nmax+1
    x    = a + (i-1) * h ;
    y(i) = y(i-1) + h * func(x, y(i-1));
  endfor
endfunction