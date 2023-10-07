#-----------------------------------
def f(t,x):
    ''' t : time 
        x : NumPy array for current x 
       xp : NumPy array for current x'

    3d anisotropic Simple Harmonic Oscillator'''
    # imports & ease
    import inc
    import numpy as np
    k1=inc.k1; k2=inc.k2; k3=inc.k3; k4=inc.k4; NEQ=inc.NEQ
    #-----------
    xp = np.zeros(NEQ)
    x1 = x[0];  v1 = x[3]
    x2 = x[1];  v2 = x[4]
    x3 = x[2];  v3 = x[5]
    #---------------------------------
    # velocities
    xp[0] = v1
    xp[1] = v2
    xp[2] = v3
    #---------------------------------
    # accelerations
    xp[3] = -k1*x1
    xp[4] = -k2*x2
    xp[5] = -k3*x3
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
