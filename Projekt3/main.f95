
program main
    use leapfrog

    real :: cast
    !elektron
    cast = 3e-17
    call simulate(q_e, m_e, cast, "elektron1.txt")
    cast = 2e-3
    call simulate(q_e, m_e, cast, "elektron2.txt")
    cast = 1e-2
    call simulate(q_e, m_e, cast, "elektron3.txt")

    !argon
    cast = 3e-11
    call simulate(q_ar, m_ar, cast, "ar1.txt")
    cast = 2e-3
    call simulate(q_ar, m_ar, cast, "ar2.txt")
    cast = 3e-2
    call simulate(q_ar, m_ar, cast, "ar3.txt")

end program main

