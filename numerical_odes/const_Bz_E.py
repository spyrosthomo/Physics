#---------------
def f(t, x):
    '''  t  : time 
         x  : NumPy array for current x 
         xp : NumPy array for current x'

    Particle in constant E & B field: 
    q B/m = k1 \hat{z}   q E/m = k2\hat{x} + k3 \hat{y} + k4 \hat{z}
   '''
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
    # accelerations
    xp[3] = inc.k2 + k1 * v2
    xp[4] = k3 - k1 * v1
    xp[5] = k4
    return xp
    #---------------------------------
#===================================================
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
    E = E - k2*x[0] - k3*x[1] - k4*x[2]
    return E
