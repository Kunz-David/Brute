#hideblock begin

using Brute
using Suppressor

# load student code
is_file_runnable!("student.jl")
@suppress include("student.jl")
using .student

# load teacher code
is_file_runnable!("teacher.jl")
@suppress include("teacher.jl")
using .teacher

nothing
#hideblock end


#=================
# Homework #1 Evaluation!
====================#


evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=0) #hide
nothing #hide
#------------------------
test1 = @test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=public) #onlymd

#------------------------


#-------------------------
test2 = @test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=public) #onlymd
#-------------------------

# the following test is for ...

#------------------------
@test evaluation student.pdf_mistake(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=optional, access=private) #onlymd
#------------------------


#------------------------
@test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=private) #onlymd
#------------------------



print(create_summary(evaluation)) #onlymd
