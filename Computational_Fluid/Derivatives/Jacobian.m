# function to compute the jacobian of the \vec{f}(\vec(x)) multivariate 
#      f    : defines the function 
#      x    : point where the Jacobian is computed 
#      h    :      :) 
# all of the should be in column vector form.
#-----------------------------------------------
function J = Jacobian(f, x, h)
  # check inputs 
  if ( (size(f(x), 1)!=size(x, 1)) ) # We want it to be invertible so J\in R^{nxn}
    fprintf("# ERROR in Jacobian: f, x must have the same size\n")
    return 
  endif
  if ( size(h,1) < size(x, 1) )
    fprintf("# h found with smaller size than n=%d.\n We resized it as a column nx1 = %d x 1 with values equal to h(1) = %f\n", n, n, h(1))
    h = h(1) * ones(size(size(x,1),1));  
  endif
  #----------------------------------------------  
  # size of the function 
  n = size(x, 1);
  J = zeros(n, n);
  #
  xp = x; xm = x;
  for i=1:n
    for j=1:n 
      # f_i(xj+h)
      xp(j)   = x(j, 1) + h(j, 1);
      fp      = f(xp);
      # f_i(xj-h)
      xm(j)   = x(j, 1) - h(j, 1);
      fm      = f(xm);
      # Jacobian (f_i(x_j+h) - f_(x_j-h)) / 2h
      J(i, j) = ( fp(i) - fm(i) )/ ( 2 * h(j) );
      xp = x; xm = x; 
    endfor # j-vars
  endfor   # i-funcs
endfunction