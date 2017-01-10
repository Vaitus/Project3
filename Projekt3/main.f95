
program main
    use leapfrog

    !TODO
    !dodelat intent(in), intent(out)
    !predavat q/m
    !pridat realum kind (kind=myreal)
    !menit rychlosti a simulovat to
    !pripravit si prezentaci

    real :: Bmag, tc, neco
    real(kind=p16) :: dt
    character :: s
    real, parameter :: PI = 3.141592653589793238462643383279
    real, parameter :: TMUL(9) = (/ 0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0, 10000.0 /)
    integer, parameter :: STEPS = 1000000

    Bmag = sqrt(dot_product(Bindukce((/0.0, 0.0, 0.0/)+0.0_p16), Bindukce((/0.0, 0.0, 0.0/)+0.0_p16)))

    ! Cas gyrace pro elektron
    tc = 2 * PI * m_e / (q_e * Bmag)

    !neco = (-1.0*q_e * Bmag) / (m_e*299792458)
    !print *, "asdads", neco

    do i = 1,9
        dt = TMUL(i) * tc
        write (s, '(I1)') i
        call simulate(q_e, m_e, dt, 'elektron'//s//'.txt', STEPS)
    end do

    ! Cas gyrace pro argonovy iont
    !tc = 2 * PI * m_ar / (q_e * Bmag)

    !do i = 1,9
    !    dt = TMUL(i) * tc
    !    write (s, '(I1)') i
    !    call simulate(q_ar, m_ar, dt, 'argon'//s//'.txt', STEPS)
    !end do

end program main
