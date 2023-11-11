function f = fun_ex_set02(x, y)
  if nargin < 2 
    fprintf("# !!! ERROR <2 arguments in f(x,y) function") 
  endif
  %---------------------------------
  f = x + y; 
endfunction