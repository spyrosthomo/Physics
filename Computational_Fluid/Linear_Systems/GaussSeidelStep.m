% Gauss-Seidel one step forward 
%   Ax = b 
%  x0 === x@(n  ) 
%  x  === x@(n+1)
%----------------------------------------------------
function xGS = GaussSeidelStep(A, b, x0) 
  % find dimension
  n  = size(A, 1);
  xx = x0 ;
  %define x array nx1
  xx  = zeros(n, 1); 
  ax  = 0;
  % Jacobi Step 
  for i=1:n
    ax1 = 0; ax2 = 0 ; 
    % find  terms ~ A * x  
    for j=1:n
      if     j <= i-1
        ax1 += A(i, j)*xx(j, 1);
      elseif j >= i+1
        ax2 += A(i, j)*x0(j, 1);
      endif
    endfor
    ax = ax1 + ax2 ;
    %-------
    xx(i, 1) = (1/A(i, i)) * (  b(i, 1) -  ax );
  endfor
  xGS = xx ; 
endfunction