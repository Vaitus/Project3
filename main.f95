

program main

    implicit none
    real :: dt !cast jak velke skoky
    real :: x(3),v(3) !misto a rychlost castice
    real :: B(3), E(3) !pole pro mag. indukci a E. pole
    real :: q = -1.602e-19, m = 9.109e-31 !naboj a hmotnost elektronu
    integer :: i

    dt = 4e-11
    x = startingPositionForX()
    v = startingVelocity()
    B = Bindukce(x)
    E = Efield(x)

    call updateVelocity(x,v,E,B,-0.5) !posunuti castice o 0.5 "dozadu"

    do i = 0, 1000
        E = Efield(x)
        B = Bindukce(x)

        call updateVelocity(x, v, E, B, 1.0)
        call particlePush(x, v)

    end do

contains
    !nastaveni startovni pozice
    function startingPositionForX() result(out)
        implicit none
        real :: out(3)

        out(1) = 0
        out(2) = 0
        out(3) = 0

    end function startingPositionForX

       !nastaveni startovni rychlosti
    function startingVelocity() result(out)
        implicit none
        real :: out(3)

        out(1) = 0
        out(2) = 1e5
        out(3) = 0

    end function startingVelocity

     !vektorovej soucin
    function cross_product(array1, array2) result(out)
        implicit none
        real :: array1(3), array2(3)
        real :: out(3)

        out(1) = array1(2) * array2(3) - array1(3)*array2(2)
        out(2) = -array1(1) * array2(3) + array1(3)*array2(1)
        out(3) = array1(1) * array2(2) - array1(3)*array2(1)

    end function cross_product

    !posunuti castice o rychlost
    subroutine particlePush(x, v)
        real :: x(3)
        real :: v(3)
        real :: dt

        x(1) = x(1) + v(1)*dt
        x(2) = x(2) + v(2)*dt
        x(3) = x(3) + v(3)*dt
    end subroutine particlePush

    !upraveni rychlosti
    subroutine updateVelocity(x, v, E, B, multi)
        real :: x(3), v(3), E(3), B(3), multi
        real :: v_minus(3), v_prime(3), v_plus(3)
        real :: t(3), s(3), t_norma
        real :: v_minus_crossproduct_t(3), v_prime_cross_s(3)
        integer :: i

        !vektor t
        do i = 1, 3
            t(i) = q/m * B(i)*0.5*dt*multi
        end do

        !norma vektoru t
        t_norma = t(1)*t(1) + t(2)*t(2) + t(3)*t(3)

        !vektor 2t/1+t^2
        do i = 1, 3
            s(i) = 2*t(i)/(1+t_norma)
        end do

        !v_minus
        do i = 1, 3
            v_minus(i) = v(i) + q/m * E(i) * 0.5*dt*multi
        end do

        !v_prime
        v_minus_crossproduct_t = cross_product(v_minus, t)
        do i = 1, 3
            v_plus(i) = v_minus(i) + v_minus_crossproduct_t(i)
        end do

        !v_plus
        v_prime_cross_s = cross_product(v_prime, s)
        do i = 1, 3
            v_plus(i) = v_minus(i) + v_prime_cross_s(i)
        end do

        !v^n+1/2
        do i = 1, 3
            v(i) = v_plus(i) + q/m * E(i) * 0.5*dt*multi
        end do

    end subroutine updateVelocity

    !nastaveni magneticke indukce
    function Bindukce(x) result(out)
          implicit none
        real :: x(3)
        real :: out(3)

        out(1) = 0
        out(2) = 0
        out(3) = 0.01
    end function Bindukce
    !elektro. pole
    function Efield(x) result(out)
          implicit none
          real :: x(3)
        real :: out(3)

        out(1) = 0
        out(2) = 0
        out(3) = 0
    end function Efield

end program main
