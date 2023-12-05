%% Solution of the Navier-Stokes equation in the case of 
%         - Cylindrical symmetry 
%         - stationary flow 
%         - incompressible fluid
%         
%--------------------------------------------------------
function u = NS_cyl(N)
  addpath("../../Linear_Systems")
  %% System's parameters 

  %% Numerical scheme's parameters 
  Dr     = 1/(N-1);
  r(1:N) = ((0:N-1)*Dr)';
  %% Define the system's matrices A*u = b 
  A = zeros(N, N);
  b = zeros(N, 1);
  % boundary conditions: u1+u2 = 0 && uN = 0 
  A(1, 2) = 1; A(1, 1) = -1; 
  b(1)    = 0; 
  A(N, N) = 1;
  b(N)    = 0; 
  % inner points 
  for i=2:N-1     
      A(i, i)   = -4;       % diagonal 
      A(i, i+1) = 2 + Dr/r(i); % diagonal+1
      A(i, i-1) = 2 - Dr/r(i); % diagonal-1
      b(i)      = 2*Dr^2;
  endfor

  u = Thomas(A, b);
endfunction