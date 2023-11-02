# implementation of central differences 1st-order derivative 
function der = der1_central(f, x, h)
    der = ( f(x+h) - f(x-h) ) / (2*h);
endfunction