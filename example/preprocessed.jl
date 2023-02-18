

using Brute #hide
using Suppressor #hide


is_file_runnable!("student.jl") #hide
@suppress include("student.jl") #hide
using .student #hide


is_file_runnable!("teacher.jl") #hide
@suppress include("teacher.jl") #hide
using .teacher #hide

nothing #hide



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
