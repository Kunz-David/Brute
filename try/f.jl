quote
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:7 =#
    var"#201#stud_res" = begin
        #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:35 =#
        var"#205#output" = Brute.iocapture(color=true) do
            #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:36 =#
            "student.f(1)"
        end
        #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:38 =#
        Brute.RunResult(var"#205#output"...)
    end
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:8 =#
    var"#202#teach_res" = begin
        #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:35 =#
        var"#206#output" = Brute.iocapture(color=true) do
            #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:36 =#
            "teacher.f(1)"
        end
        #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:38 =#
        Brute.RunResult(var"#206#output"...)
    end
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:9 =#
    var"#203#pass" = (var"#201#stud_res").value == (var"#202#teach_res").value
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:10 =#
    var"#204#test" = Brute.Test(id=evaluation.maxid + 1, student_result=var"#201#stud_res", teacher_result=var"#202#teach_res", passed=var"#203#pass")
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:14 =#
    Brute.add_test!(evaluation, var"#204#test")
    #= /Users/MrTrololord/.julia/dev/Brute/src/macros.jl:15 =#
    var"#204#test"
end