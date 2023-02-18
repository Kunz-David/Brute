# Brute

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Kunz-David.github.io/Brute.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Kunz-David.github.io/Brute.jl/dev/)
[![Build Status](https://github.com/Kunz-David/Brute.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Kunz-David/Brute.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/Kunz-David/Brute.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/Kunz-David/Brute.jl)


This project aims help teachers evaluate student homework.

It is works very similarly to Literate (on which it is base) and has all of its functionalities plus a couple more.

Most notable extensions:
- `#hideblock begin` and `#hideblock end` - any code between these two comments will evaluate, but not show source code.
- `#onlymd` - a line marked like this will hide sourcecode and show its output as markdown.
- Plus all the testing specific functionalities (covered in the docs).

example use:

```julia
#example.jl

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

```

then call
```julia
create_test_output("example.jl")
```