function f = ex6_fun(x); 
  # x should be 2x1 column vector 
  if (size(x,1)!=2) 
    printf("# ERROR in ex6_fun; x should be 2x1\n") 
  endif
  #----------------------------------------
  x1 = x(1,1); x2 = x(2,1); 
  f1 = 4*x1^2    - 20*x1 + 0.25*x2^2 + 8 ;
  f2 = 0.5*x1*x2^2 + 2*x1  - 5*x2      + 8 ;
  f = [f1; f2]; 
endfunction