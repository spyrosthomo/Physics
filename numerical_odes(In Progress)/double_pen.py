#-----------------------------------
def f(t,x):
    ''' t : time 
        x : NumPy array for current x 
       xp : NumPy array for current x'

    3d anisotropic Simple Harmonic Oscillator'''
    # imports & ease
    import inc
    import numpy as np
    import math
    k1=inc.k1; k2=inc.k2; k3=inc.k3; k4=inc.k4; NEQ=inc.NEQ
    #-----------
    xp = np.zeros(NEQ)
    th1 = x[0]
    th2 = x[1]
    om1 = x[2]
    om2 = x[3] 
    #---------------------------------
    th1 = math.atan(math.sin(th1)/math.cos(th1))
    th2 = math.atan(math.sin(th2)/math.cos(th2))

    x[0] = th1
    x[1] = th2
    #---------------------------------
    # velocities
    xp[0] = om1 
    xp[1] = om2
    #---------------------------------
    # accelerations
    x1 = math.sin(th1)
    x2 = math.sin(th2)+3.0
    y1 =-math.cos(th1)
    y2 =-math.cos(th2) 
    xp[2] = k1* ( (x1-x2)*y1 + (y2-y1)* x1   - k2*  x1  )
    xp[3] = k2 * ( (x1-x2)*y2 + (y1-y2)*(math.sin(th2))- k2*(math.sin(th2)))
    #xp[5] = -k3*x3
    return xp
#-----------------------------------------------
#==============================================
def energy(t, x):
    ''' t : time 
        x : NumPy array for current position

        computes the energy of the particle: E = K + U '''
    #imports & ease
    import inc
    import numpy as np
    k1=inc.k1; k2=inc.k2; k3=inc.k3; k4=inc.k4
    #-------------------
    #----- Kinetic
    E = np.inner(x[3:6], x[3:6]) * 0.5
    #----- Potential
    E = E + 0.5*(k1*x[0]**2 + k2*x[1]**2 + k3*x[2])
    return E
