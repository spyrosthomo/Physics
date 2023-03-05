!========================================================
!Program to solve a 6 ODE system using Runge-Kutta Method
!Output is written in file rk3.dat
!========================================================
program rk3_solve
 include 'rk3.inc'
 real(8) :: T0,TF,theta0, j0, TT0, T1, T2
 real(8) :: t,dt,tstep
 integer(8) :: STEPS
 integer :: i
 real(8) :: energy
 real(8) :: omegabar1, omegabar2, jres1, jres2, jres1k, jres2k
!Arrays/variables needed by rksuite:
 real(8) TOL,THRES(NEQ),WORK(LENWRK),Y(NEQ),YMAX(NEQ),&
      YP(NEQ),YSTART(NEQ),HSTART
 logical  ERRASS, MESSAGE
 integer  UFLAG
 real(8),parameter :: pi =3.1415926535897932
!.. External Subroutines ..
 EXTERNAL          F, SETUP, STAT, UT
 !Input:
 print *, '# Enter omega_bar, OMEGA, k '
 read  *,          omega_bar, OMEGA, k
 print *, '# omega_bar = ',omega_bar, ' OMEGA = ',OMEGA, 'k=',k
 !-----
 print *, '# Enter v1, v2'
 read  *,          v1, v2
 print *, '# v1 = ',v1, ' v2 = ', v2
 !-----
 print *, '# Enrer n1, m1, n2, m2 '
 read  *,          n1, m1, n2, m2
 print *, '# n1 = ',n1, ' m1 = ',m1
 print *, '# n2 = ',n2, ' m2 = ',m2
 !--------------------------
 !print *, '#-----------------------------------'
 !jres1k = 0.25; jres2k = 0.5
 !print *, '#jres1k = ', jres1k, ' jres2k = ', jres2k
 !omegabar1 = (m1*OMEGA-n1*k*jres1k)/n1
 !omegabar2 = (m2*OMEGA-n2*k*jres2k)/n2
 !print *, '#omegabar1=',omegabar1, ' omegabar2=',omegabar2
 !--
 print *, '#-------------------------------------'
jres1k = (m1*OMEGA-n1*omega_bar)/(n1*k)
jres2k = (m2*OMEGA-n2*omega_bar)/(n2*k)
jres1  = jres1k**(1/(k-1))
jres2  = jres2k**(1/(k-1))
print *, '#jres1  = ', jres1 , ' jres2  = ', jres2
print *, '#jres1k = ', jres1k, ' jres2k = ', jres2k
!-----------------------------------
T1 = 2*pi/(m1*OMEGA)
T2 = 2*pi/(m2*OMEGA)
TT0=m1*T1
print *, '#T1 = ',T1, 'T2 = ', T2
print *, '#T0 = ', TT0
 print *, '#-----------------------------------' 
 print *, '# Enter STEPS, t0, tf, theta0, j0'
 read  *,          STEPS, t0, tf, theta0, j0
 print *, '# STEPS = ', STEPS
 print *, '# t0    = ', t0, ' tf = ', tf
 print *, '# theta0= ', theta0, ' j0 = ', j0
 !--------------------------------------------------
!Initial Conditions
 dt        = (TF-T0)/STEPS
 YSTART(1) = theta0
 YSTART(2) = j0
 !TT0=0.0_dp; call TT0(
!
!  Set error control parameters.
!
 TOL = 5.0D-6
 do i = 1, NEQ
  THRES(i) = 1.0D-10
 enddo
 MESSAGE = .TRUE.
 ERRASS  = .FALSE.
 HSTART  = 0.0D0
!Initialization:
 call SETUP(NEQ,T0,YSTART,TF,TOL,THRES,METHOD,'Usual Task',&
      ERRASS,HSTART,WORK,LENWRK,MESSAGE)
 open(unit=11,file='rk3.dat')
 write(11,100) T0,MOD(YSTART(1),(2*pi)),YSTART(2)
! open(unit=newunit,file='poincare.dat')
! write(newunit,100) T0, YSTART(1), YSTART(2)
!Calculation:
 do i=1,STEPS
  t = T0 + i*dt
  call UT(F,t,tstep,Y,YP,YMAX,WORK,UFLAG)
  if(UFLAG.GT.2) exit !exit the loop: go after enddo
  if ( MOD(t,TT0) < dt) then
     write(11,100) tstep,MOD(Y(1),(2*pi)),Y(2)
  end if
 ! if(ABS(t%TT0-k)<1e-4) then 
 !    write(newunit,100) t, Y(1), Y(2)
 !    k=k+1
 ! end if
enddo
 close(11)
100 format(3E25.15)
end program rk3_solve
