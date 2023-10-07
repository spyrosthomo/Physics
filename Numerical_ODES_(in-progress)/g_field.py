#---------------
def f(t, x):
    '''  t  : time 
         x  : NumPy array for current x 
         xp : NumPy array for current x'

   Particle in homogeneous gravitational field with drag force ~v  
   	(ax, ay, az) = (-k2*x1, -k2*x2, -k2*x3 - k1 ) 
   		k1 : g 
   		k2 : drag
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
    xp[3] = -k2*v1
    xp[4] = -k2*v2
    xp[5] = -k2*v3 - k1 
    #----- 
    return xp
    #---------------------------------
#===================================================
def energy(t, x):
    ''' t : time 
        x : NumPy array for current position

        computes the mechanical energy of the particle: E = K + U '''
    #imports & ease
    import inc
    import numpy as np
    k1=inc.k1; k2=inc.k2; k3=inc.k3; k4=inc.k4
    #-------------------
    #----- Kinetic
    E = np.inner(x[3:6], x[3:6]) * 0.5
    #----- Potential
    E = E + k1*x[2]
    return E
