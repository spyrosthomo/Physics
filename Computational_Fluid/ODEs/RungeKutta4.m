%% Implementation of  Runge-Kutta 4 method  to solve the eq 
%                 dy/dx = f(x,y) 
% : 
%---------------------------------------------------------------
% inputs   :  . a, b    : interval 
%             . y0      : y(x0) " Initial condition" 
%             . Nmax    : maximum steps
%             . hin     : h from input 
%    !!       . func    : the f(x,y) function that defines the problem 
%
% OUTPUT   :  . a vector Nmax x 1 containing the solution y_i at each x_i
%---------------------------------------------------------------
function y = RungeKutta4(func, a, b, y0, Nmax)
  %% check if Nmax is given. If not set it to a value 
  if nargin < 5
    Nmax = 1e+02
  endif
  %------------------------------------------
  %% Define/initialize parameters/variables
  h    = (b - a)/Nmax ;  % step 
  y    = zeros(Nmax+1, 1);
  y(1) = y0;  
  x    = linspace(a, b, Nmax+1);
  for i = 2:Nmax+1
    k1   = func(x(i-1), y(i-1) );
    k2   = func(x(i-1) + 0.5*h, y(i-1) + 0.5*h*k1);
    k3   = func(x(i-1) + h*0.5, y(i-1) + 0.5*h*k2);
    k4   = func(x(i-1) + h    , y(i-1) + h*k3);
    y(i) = y(i-1) + (h/6)*(k1 + 4*k2 +k3);
  endfor
endfunction