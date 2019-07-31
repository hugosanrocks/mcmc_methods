       program emh

       implicit none
       integer :: iter_max, iter_i, i, j
       real :: cm(10,10), cd(10,10), d(10), dmgm(10), g(10,10)
       real :: cmi(10,10), cdi(10,10), m(10), newm(10)
       real :: p0, plik, prob1, prob2, prod, aprob, sigm, sigd
       integer :: dimen
       real :: a

       dimen = 10
       sigm = 2.
       sigd = 1.

       cm = 0.
       cd = 0.
       m = 1.8

       !data vector
       do i=1,10
          d(i) = i/5.
          g(i,i) = i/10.
          cm(i,i) = sigm**2.
          cd(i,i) = sigd**2.
          cmi(i,i) = 0.25
          cdi(i,i) = 1.
       enddo

       iter_max = 500000

       do iter_i = 1, iter_max

         call proposal(m,sigm,dimen,newm)


         call prior(m,cmi,dimen,p0)
         call likeli(d,g,m,cdi,dimen,plik)

         prob1 = p0 * plik

         call prior(newm,cmi,dimen,p0)
         call likeli(d,g,newm,cdi,dimen,plik)

         prob2 = p0 * plik
         aprob = prob2/prob1

         call unif_value(a)

!print *, aprob, a
         if (  aprob .gt. a) then

           m = newm

         else

           m = m

         endif

         print *, m(1), m(3), m(5), m(7), m(10)


       enddo


       end program emh


       subroutine multip(vect,mat,vec,n,prod)

       implicit none
       integer :: i, n
       real :: vect(n), mat(n,n), vec(n)
       real :: prod
       
       prod = 0
        do i=1,n
          prod = prod + vect(i)*mat(i,i)*vec(i)
        enddo

       end subroutine multip

       subroutine prior(m,covi,dimen,p0)

        implicit none
        integer :: dimen
        real :: m(dimen), covi(dimen,dimen), p0

        call multip(m,covi,m,dimen,p0)

        p0 = exp(-0.5*p0)

       endsubroutine prior


       subroutine likeli(d,g,m,covi,dimen,plik)

       implicit none
       integer :: dimen
       real :: d(dimen), g(dimen,dimen), m(dimen), covi(dimen,dimen)
       real :: dmgm(dimen)
       real :: plik
       integer :: i

       do i=1,dimen
         dmgm(i) = d(i) - g(i,i)*m(i)
       enddo

       call multip(dmgm,covi,dmgm,dimen,plik)

       plik = exp( -0.5 * plik )

       endsubroutine likeli

       subroutine proposal(m,cm,dimen,newm)

       implicit none
       integer :: i, dimen
       real :: m(dimen), cm, newm(dimen)

       do i=1,dimen
         call normal_dist(m(i),cm,newm(i))
       enddo

       end subroutine proposal

SUBROUTINE NORMAL_DIST (a, b, x)

  IMPLICIT NONE

  ! Parameters
  REAL a ! Mean
  REAL b ! Standard Deviaton
  REAL x

  ! Local variables
  REAL, PARAMETER :: PI = 3.141592653589793D+00
  REAL r1, r2

  CALL RANDOM_NUMBER (HARVEST = r1)
  CALL RANDOM_NUMBER (HARVEST = r2)

  x = a + b * (SQRT ( - 2.0D+00 * LOG ( r1 ) ) * COS ( 2.0D+00 * PI * r2 ))

END SUBROUTINE NORMAL_DIST

      subroutine unif_value(val)

      USE init_random_seed_mod
      implicit none
      real, intent(out) :: val
      real*8 :: r8_uniform_01
      integer*8 :: seedi(1)

      call INIT_RANDOM_SEED()
      CALL RANDOM_SEED (GET=seedi(1:1))

       val = r8_uniform_01 ( seedi )


      endsubroutine unif_value


