

program main

    implicit none
    real :: dt !cast jak velke skoky
    real :: x(3),v(3) !misto a rychlost castice
    real :: B(3), E(3) !pole pro mag. indukci a E. pole
    real :: q = -1.602e-19, m = 9.109e-31 !naboj a hmotnost elektronu

    x = startingPositionForX()
    v = startingVelocity()
    B = Bindukce(x)
    E = Efield(x)

    updateVelocity(x,v,E,B,-0.5*dt) !posunuti castice o 0.5 "dozadu"


    write (*,*) "Input number of points to average:", q

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

    end function startingPositionForX

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
    subroutine particlePush(x, v, dt)
        x(1) += v(1)*dt
        x(2) += v(2)*dt
        x(3) += v(3)*dt
    end subroutine particlePush
    !upraveni rychlosti
    subroutine updateVelocity(x, v, E, B, dt)

    end subroutine updateVelocity
    !nastaveni magneticke indukce
    function Bindukce(x) result(out)
          implicit none
        real :: out(3)

        out(1) = 0
        out(2) = 0
        out(3) = 0.01
    end function Bindukce
    !elektro. pole
    function Efield(x) result(out)
          implicit none
        real :: out(3)

        out(1) = 0
        out(2) = 0
        out(3) = 0
    end function Eforce

end program main
