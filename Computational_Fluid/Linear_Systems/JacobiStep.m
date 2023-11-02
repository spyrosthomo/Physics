function xJS = JacobiStep(A, b, x) 
  % find dimension
  n = size(A, 1);
  
  %define x array nx1
  xx  = zeros(n, 1); 
  
  % Jacobi Step 
  for i=1:n
    ax = 0; 
    % find A(i,j) * x(j)
    for j=1:n
      if j ~= i 
        ax += A(i, j) * x(j, 1);
      endif
    endfor
    %-------
    xx(i, 1) = (1/A(i, i)) * (  b(i, 1) -  ax );
  endfor
  xJS = xx ; 
endfunction