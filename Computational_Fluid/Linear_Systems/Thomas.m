% Thomas alogrithm for solving 3-diagonal systems of equations 
function x = Thomas(A, d)
  % dimension of system 
  n = size(A,1);
  
  % obtain the un-primed arrays a, b, c from matrix A 
  a  = [0, diag(A, -1)']';
  b  = diag(A);             # diagonal
  c  = [diag(A, +1)', 0]';
  
  %---------------------------------------------------------------
  % 1st part: forward
  %---------------------------------------------------------------
  % define the primed arrays c', d'
  cp = zeros(n, 1); 
  dp = zeros(n, 1);
  
  % calculate primed arrays
  cp(1, 1) = c(1, 1) / b(1, 1);
  dp(1, 1) = d(1, 1) / b(1, 1);
    % c' 
  for i=2:n-1
    cp(i, 1) = c(i, 1) / ( b(i, 1) - a(i, 1)*cp(i-1, 1) );
  endfor
    % d' 
  for i=2:n
    dp(i, 1) = (d(i, 1) - a(i, 1)*dp(i-1, 1)) / ( b(i, 1) - a(i, 1)*cp(i-1, 1) );
  endfor

  %---------------------------------------------------------------
  %2nd part: backwards
  %    x : contains the solution of the tridiagonal system
  %---------------------------------------------------------------
  x       = zeros(n, 1); 
  x(n, 1) =    dp(n, 1);
  
  for i = n-1:-1:1
    x(i, 1) = dp(i, 1) - cp(i, 1) * x(i+1,1);
  endfor
endfunction
