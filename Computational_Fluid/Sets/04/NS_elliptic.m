%% Construction of the Navier-Stokes equation matric in the case of 
%         - Square pipe  
%         - stationary flow 
%         - incompressible fluid
%         - //z flow 
%--------------------------------------------------------
function [A, b] = NS_elliptic(N, h, f)%, method) 
  %% Numerical scheme's parameters 
  x  = ((0:N+1)*h)';
  %x(1:N) = ((0:N-1)*h)';
  %% Define the system's matrices A*w = b: eqns (19), (21) in the text
  M = (N)*(N)       % dim of solution 
  A = zeros(M, M);
  b = zeros(M, 1);
  %-------------------------------
  %------------------------------
  %% construct A, b 
  b = h^2*f(ones(N+2, N+2), h);
  b = reshape(b(2:end-1, 2:end-1), [], 1); 
  % boundary conditions 
  % y 
  for i=1:N
    l1 = lambda(i, 1, N);
    lN = lambda(i, N, N);
      A((i-1)*N+1, l1) = 1; 
      A((i-1)*N+N, lN) = 1; 
  endfor
  % x
  for j=1:N
    l1 = lambda(1, j, N);
    lN = lambda(N, j, N);
      A(l1, j        ) = 1; 
      A(lN, N*(N-1)+j) = 1;
  endfor
  % inner points 
  for i=2:N-1
    %sprintf("#---------- i = %.d ---------------", i) 
    for j=2:N-1 
      %sprintf("#---------- j = %.d ---------------", j) 
      l = lambda(i, j, N);
      if  ( l>=1)% & l<=M )       %( (l>1) & (l<M) )
        A(l, l )  = +4; 
        A(l, l-1) = -1;
        A(l, l+1) = -1; 
        A(l, l-N) = -1;
        A(l, l+N) = -1; 
      endif
      
   endfor
  endfor
endfunction