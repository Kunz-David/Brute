using Base: kwarg_decl
using Suppressor

output = @capture_out begin
    out = is_file_runnable!("../student.jl")
end;
print(output)

print(out)

using IOCapture: capture as iocapture

output = iocapture(color=true) do
    out = is_file_runnable!("../student.jl")
end;

print(output.output)
print(output.value)
out



f = x -> x + 1


@macroexpand @show f(1) + 1

@show f(1) + 1





using Brute
using IOCapture: capture as iocapture
is_file_runnable!("tmp_student.jl")
include("tmp_student.jl")

is_file_runnable!("tmp_teacher.jl")
include("tmp_teacher.jl")

student.f(2)
f(2)
teacher.f(2)

evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=10)
named_tuple(evaluation)

@test evaluation student.f(6) teacher.f(1) (optionality=optional,)

test = @test evaluation student.f(1) teacher.f(1) ()

@macroexpand @test evaluation student.f(1) teacher.f(1) (optionality=Brute.optional,)


evaluation.testblocks

print(Brute.summary(evaluation))
passed(evaluation)


a = []

b = (adf=1, as=2,)

push!(a, (b))
using MarkdownTables

tab = [(name="Test #2", passed=false, status=Brute.ran, gained="0/1", optionality=Brute.mandatory, access=Brute.private),
    (name="Test #1", passed=true, status=Brute.ran, gained="1/1", optionality=Brute.optional, access=Brute.private)]

typeof(tab)

tab |> markdown_table(String)
