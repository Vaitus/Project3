
program main
    use leapfrog

    real, parameter :: cast = 3e-11

    print *, cast
    call simulate(q_e, m_e, cast, "elektron.txt")

end program main

