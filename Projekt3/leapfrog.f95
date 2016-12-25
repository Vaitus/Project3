module leapfrog
    implicit none

    real, parameter :: m_e = 9.109e-31, q_e = -1.602e-19
    real, parameter :: m_ar = 6.6e-26 - m_e, q_ar = -q_e

    !real, parameter :: permitivityOfFreeSpace = 8.854187817e-12
    !real, parameter :: stability_e = 0.1/(sqrt((1*q_e**2)/(m_e*permitivityOfFreeSpace)))
    !real, parameter :: stability_ar = 0.1/(sqrt((17*q_e**2)/(m_e*permitivityOfFreeSpace)))

    contains
    !vypocet
    subroutine simulate(q, m, dt, name)
        implicit none
        real :: dt !cast jak velke skoky
        real :: x(3),v(3) !misto a rychlost castice
        real :: B(3), E(3) !pole pro mag. indukci a E. pole
        real :: q, m  !naboj a hmotnost
        real :: tempEnergy
        !(kind = SELECTED_REAL_KIND(16))
        character (len=*) :: name
        integer :: i

        open(unit=12, file=name, status="replace")
        x = startingPositionForX()
        v = startingVelocity()

        tempEnergy = energy(v, m)
        B = Bindukce(x)
        E = Efield(x)

        call updateVelocity(x,v,E,B,-0.5, q, m, dt) !posunuti castice o 0.5 "dozadu"

        do i = 0, 10000
            E = Efield(x)
            B = Bindukce(x)

            call updateVelocity(x, v, E, B, 1.0, q, m, dt)
            call particlePush(x, v, dt)
            !print *, energy(v,m), tempEnergy
            !write(12,*), x, v, (energy(v,m) - tempEnergy)
            write(12,*), abs(energy(v,m) - tempEnergy)
        end do

        close(12)
    end subroutine simulate
    !vypocet energie
    function energy(v, m) result(energ)
        implicit none
        real :: v(3), m
        real :: energ
        real, parameter :: c_light = 299792458

        energ = 0.5 * m * dot_product(v,v)
        !energ = sqrt( dot_product((v),(v))*m*m*c_light**2 + (m*c_light**2)**2 )
        !energ = ((1/(sqrt(1-(dot_product((v),(v))/c_light**2))))-1)*m*c_light*c_light

    end function energy

    !nastaveni startovni pozice
    function startingPositionForX() result(out)
        implicit none
        real :: out(3)

        out = (/0.0,0.0,0.0/)

    end function startingPositionForX

       !nastaveni startovni rychlosti
    function startingVelocity() result(out)
        implicit none
        real :: out(3)

        out = (/10000.0,0.0,0.0/)

    end function startingVelocity

     !vektorovej soucin
    function cross_product(array1, array2) result(out)
        implicit none
        real :: array1(3), array2(3)
        real :: out(3)

        out(1) = array1(2) * array2(3) - array1(3)*array2(2)
        out(2) = -array1(1) * array2(3) + array1(3)*array2(1)
        out(3) = array1(1) * array2(2) - array1(2)*array2(1)

    end function cross_product

    !posunuti castice o rychlost
    subroutine particlePush(x, v, dt)
        real :: x(3)
        real :: v(3)
        real :: dt

        x = x + v*dt
    end subroutine particlePush

    !upraveni rychlosti
    subroutine updateVelocity(x, v, E, B, multi, q, m, dt)
        real :: q, m
        real :: x(3), v(3), E(3), B(3), multi
        real :: v_minus(3), v_prime(3), v_plus(3)
        real :: t(3), s(3), t_norma
        real :: v_minus_crossproduct_t(3), v_prime_cross_s(3)
        real :: dt

        !vektor t uprav
        t = (q/m) *B*0.5*dt*multi

        !norma vektoru t
        t_norma = t(1)*t(1) + t(2)*t(2) + t(3)*t(3)

        ! 2t/1+t^2
        s = 2*(t/(1.0+t_norma))

        !v_minus
        v_minus = v + q/m * E * 0.5*dt*multi

        !v_prime
        v_minus_crossproduct_t = cross_product(v_minus, t)
        v_prime = v_minus + v_minus_crossproduct_t

        !v_plus
        v_prime_cross_s = cross_product(v_prime, s)
        v_plus = v_minus + v_prime_cross_s

        !v^n+1/2
        v = v_plus + q/m * E * 0.5*dt*multi

    end subroutine updateVelocity

    !nastaveni magneticke indukce
    function Bindukce(x) result(out)
        implicit none
        real :: x(3)
        real :: out(3)

        out = (/0.0,0.02,0.0/)
    end function Bindukce
    !elektro. pole
    function Efield(x) result(out)
        implicit none
        real :: x(3)
        real :: out(3)

        out = (/0.0,0.0,0.0/)
    end function Efield
end module leapfrog
