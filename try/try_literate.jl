#hideblock begin

using Brute

evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=0)



include("try/tmp_student.jl")
using .student

typeof(student)
#hideblock end

#-
include("try/tmp_teacher.jl")
using .teacher

#-
@test evaluation student.f(6) teacher.f(1) (optionality=optional, access=public) #hide #onlymd
#-

@test evaluation student.f(6) teacher.f(1) () #hide #onlymd
#-


# @macroexpand @test evaluation student.f(1) teacher.f(1) ()

print(create_summary(evaluation)) #onlymd