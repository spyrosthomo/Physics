function f = test(x); 
  # x should be 2x1 column vector 
  if (size(x,1)!=2) 
    printf("# ERROR in test: x should be 2x1\n") 
  endif
  #----------------------------------------
  x1 = x(1); x2 = x(2); 
  f1 = x1^2 *x2 + x2^3;
  f2 = x1 - x2^4 ;
  f = [f1; f2];
endfunction