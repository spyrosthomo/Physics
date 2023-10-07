print("#Numerical method for ODE system approximation")
print("#------------------------------------------------------")
#-------------------------
#!!!!!!!!
#TO BE MADE INTERACTIVE
#Choose method
#meth = "rk4"
#syst = "double_pen" #"g_field" "hoc" "Bz_E"
#import rk4        as method
#Choose derivatives
#import double_pen as der  # hoc constant_Bz_E

#--------------------------------------------
# initialize methods and systems available :))
#
methods = {1:"rk4"}
systems = {1:"const_Bz_E", 2:"g_field", 3:"hoc", 4:"double_pen"} 
#-------------------------------------------
# standard imports 
import numpy as np
import inc
import importlib 
#--------------------------------------------
inc.dp  = 6
inc.NEQ = 6; NEQ=inc.NEQ

# INPUTS
#--- choose method & system-------
for i in methods:
    print(i, " : ", methods[i])
print("#======================================================")
for i in systems:
    print(i, " : ", systems[i])
print("#------------------------------------------------------")
inc.meth = methods[int(input("Choose method: "))]
inc.syst = systems[int(input("Choose system: "))] 
#------------
inc.k1,inc.k2,inc.k3,inc.k4                   = [float(x) for x in input("Enter coupling constants k1,k2,k3,k4  : \n").split()]
steps                         = int(               input("Enter number of steps                 : \n"))
inc.t0,inc.tf,inc.x10,inc.x20,inc.x30,inc.v10,inc.v20,inc.v30 = [float(x) for x in input("Enter t0,tf, x10,x20,x30, v10,v20,v30 : \n").split()]
# ease - variables from inc.py
k1  =inc.k1 ; k2=inc.k2  ; k3=inc.k3  ; k4=inc.k4
t0  =inc.t0 ; tf=inc.tf
x10 =inc.x10; x20=inc.x20; x30=inc.x30
v10 =inc.v10; v20=inc.v20; v30=inc.v30
meth=inc.meth
syst=inc.syst
dp  =inc.dp
#
# PRINT INPUTS
print( "# Chosen method %s " %(meth))
print( "# Chosen system %s " %(syst))
print( "#    k1 = %.4f, k2= %.4f, k3= %.4f, k4= %.4f, " %(k1,k2,k3,k4))
print(f"# steps = {steps}")
print( "#    t0 = %.4f,  tf = %.4f " % (t0,tf))
print( "#   x10 = %.4f, x20 = %.4f, x30 = %.4f" % (x10,x20,x30))
print( "#   v10 = %.4f, v20 = %.4f, v30 = %.4f" % (v10,v20,v30))
print( "#------------------------------------------------------")
#--------------------------------------------------------------
# !! imports given by user 
method = importlib.import_module(meth)
der    = importlib.import_module(syst)
#---------------------------------------------------------------
# Initial conditions & Initilizations
dt     = (tf - t0 ) / steps
xstart = np.array([x10,x20,x30,v10,v20,v30])
x      = np.zeros(NEQ)
x      = xstart
t      = t0

#----
#
# Write initial data to a file
fname = meth +"." + syst+ ".dat"
dat   = open(fname, "w", encoding="utf-8")
dat.write(f"%.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f\n" %(t0, xstart[0], xstart[1], xstart[2], xstart[3], xstart[4],  xstart[5], der.energy(t0,xstart)))
#------------------------------------------------------------------

# Calculation
for i in range(1,steps+1):
    t = t0 + i*dt
    x = method.m(t,x,dt)
    # write to file
    dat = open(fname, "a", encoding="utf-8")
    dat.write(f"%.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f, %.{dp}f\n" %(t, x[0], x[1], x[2], x[3], x[4],  x[5], der.energy(t0,x)))
