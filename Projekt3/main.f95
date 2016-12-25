
program main
    use leapfrog

    real :: cast
    !elektron
    cast = 3e-13
    call simulate(q_e, m_e, cast, "elektron1.txt")
    cast = 3e-10
    call simulate(q_e, m_e, cast, "elektron2.txt")
    cast = 3e-3
    call simulate(q_e, m_e, cast, "elektron3.txt")
    cast = 1e-2
    call simulate(q_e, m_e, cast, "elektron4.txt")

    !argon
    cast = 3e-13
    call simulate(q_e, m_e, cast, "ar1.txt")
    cast = 3e-10
    call simulate(q_e, m_e, cast, "ar2.txt")
    cast = 3e-3
    call simulate(q_e, m_e, cast, "ar3.txt")
    cast = 1e-2
    call simulate(q_e, m_e, cast, "ar4.txt")

end program main

