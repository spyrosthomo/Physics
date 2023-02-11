# Gamow theory for alpha decay. 
# 
#
#
# INPUTS: A - mass number   of the daughter nucleus 
#         Z - atomic number of the daughter nucleus
#         Q - Q value of reaction in MeV  
#        md - mass of the daugter nucleus / u
#         
# PARAMETERS: u = 931.49 MeV/c^2 
#             a = 1/137
#             ma= 4.002604 / u 
#             r0= 1.1 fm            - for radius: R = r0 * A^(1/3)

# VARS      : b  - min distance from nucleus 
#             G  - Gamow factor
#                   G = G0 * Gtilde 
#             Zd - Atomic number of daughter nucleus 
#             Ad - Mass number of daughter nucleus 
#             mu - reduced mass 
#            Rsum- Sum of Ra and R_daughter
# 
#           G - Gamow coefficient --- G = G0 * Gtilde
#             G0 = pi * Za*Zd*a * math.sqrt(2*mu*u/Q )
#         Gtilde = DEFINED AS FUNCTION

import math 
import numpy as np 
#----------------------------------------------------------
#Declare parameters 
u  = 931.39       # MeV/c^2 
a  = 1/137 
ma = 4.002604  # ma / u 
Aa = 4
Za = 2 
r0 = 1.1          # fm 
#----------------------------------------------------------
A  = int(input("Mass   number of the parent nucleus : "))
Z  = int(input("Atomic number of the parent nucleus : "))
md = float(input("Mass/u of the daughter nucleus    : "))
Q  = float(input("Q-value (MeV) of the reaction     :"))
print("----------------------------------------------------")

Zd    = Z - 2
Ad    = A - 4
mu    = ma*md/(ma+md)               # mu / amu
Rsum  = r0 * (Aa**(1/3) + Ad**(1/3))  # fm 
#---------------------------------------------------------
# DEFINITIONS OF FUNCTIONS 
#---------------------------------------------------------
def gtilde(x):
    y = (math.acos(math.sqrt(x)) - math.sqrt(x*(1-x))) * 2 / math.pi
    return y

def b(Q,Za,Zd):
    # min distance in fm 
    y = 1.44 * Za * Zd / Q  
    return y
#-------------------------------------------------------
# debugging
#print("R ", Rsum)
#print("mu", mu ) 
print("b ", b(Q,Za,Zd))
x=Rsum/b(Q,Za,Zd)
print("x",x )
print("gtilde", gtilde(x))

#----------------
G0    = math.pi*Za*Zd*a * math.sqrt(2*mu*u/Q)
x     = Rsum / b(Q,Za,Zd)
G     = G0 * gtilde(x)
#--- 
print(f"The Gamow factor of the given reaction is {G}")
print("For tau_0=7*10^-23sec, we have that tau = tau_0 * exp(G)s: ")
tau0 = 7*10**(-23)
print("tau = ", tau0*math.exp(G) )
