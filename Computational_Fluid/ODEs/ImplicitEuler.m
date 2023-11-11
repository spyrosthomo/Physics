%% implements implicit euler method for an equation 
%      dy/dx = f(x,y) , with y(x0) = y0
% Method: 
%       y_(n+1) = y_n + h * f(x_(n+1), y_(n+1))     (1)
%
% so in order to find y_(n+1) we should solve in every step the non-linear
% equation given by (1).
%
% We can do this numerically for the general case, using a Newton_Raphson method
% for the equation 
%          f(y_(n+1)) = 0, where 
%    f(y) = y - h*f(x_(n+1), y) - y_n  
%-------------------
% inputs   :  . a, b    : interval 
%             . y0      : y(x0) " Initial condition" 
%             . Nmax    : maximum steps
%             . hin     : h from input 
%    !!       . func    : the f(x,y) function that defines the problem 
%
% OUTPUT   :  . a vector Nmax x 1 containing the solution y_i at each x_i
%----------------------------------------------------------------------
function y = ImplicitEuler(func, a, b, y0, Nmax)%, hin) 
  % add path to newton raphson 
  addpath("../../Nonlinear_Eqns")
  %% check if Nmax is given. If not set it to a value 
  if nargin < 5
    Nmax = 1e+04
  endif
  %------------------------------------------
  %% Define/initialize parameters/variables
  h    = (b - a)/Nmax ;  % step 
  y    = zeros(Nmax, 1); 
  y(1) = y0;  
  x    = a; 
  tol  = 1e-7; % For newton-raphson 
  %% Define the function which should be solved in every step 
  % yn   = y_n 
  % ynm0 = y_{n-1}
  % xn   = x_n 
  g = @(yn, ynmo) yn - h*func(x, yn) - ynmo;
  %------------------------------------------
  for i = 2:Nmax+1
    x    = a + (i-1) * h ;
    ynmo  = y(i-1);
    g = @(yn) yn - h*func(yn, x) - ynmo;
    y(i) = NewtonRaphson(y(i-1), g);%, y0, y(i-1) , tol)
  endfor
endfunction
