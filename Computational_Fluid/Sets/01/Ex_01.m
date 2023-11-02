% Call and test the Thomas algorithm, which is contained in the file:
%         "Thomas.m" 
format compact
addpath("../../Linear_Systems")
% Define the system of the Ex-1 
A = [ 2, -1, 0, 0; -1, 2 , -1, 0; 0, -1, 2, -1; 0, 0, -1 ,2 ]
d = [1; 0; 0; 1]

x = Thomas(A, d); 

disp("The solution with Thomas algorithm is: " ) 
x' 
disp("The solution given by MATLAB commands is: ") 
(A\d)'