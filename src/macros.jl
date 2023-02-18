using IOCapture: capture as iocapture

"""
    macro test(evaluation, stud_call, teach_call, settings)

Test `stud_call` vs `teach_call` to see if the outputs match. Results in a `Test` object.
`evalutation` of type `Evaluation` has to be passed to save the test results in.

Additional `Test` setting passed as a named tuple to `settings`

# Examples
```julia

@test evaluation student.f(1) student.f(2) (access=public)
```
"""
macro test(evaluation::Evaluation, stud_call, teach_call, settings)
    # settings = esc(settings)
    evaluation = esc(evaluation)
    stud_str = string(stud_call)
    teach_str = string(teach_call)
    stud_call = esc(stud_call)
    teach_call = esc(teach_call)
    code = quote
        test = nothing
        if continue_testing($evaluation)
            stud_res = @get_res $stud_call
            teach_res = @get_res $teach_call
            pass = stud_res.value == teach_res.value
            test = Test(id=$(evaluation).maxid + 1,
                student_result=stud_res,
                teacher_result=teach_res,
                student_call=$stud_str,
                teacher_call=$teach_str,
                runstatus=ran,
                passed=pass;
                $settings...)
        else
            test = Test(id=$(evaluation).maxid + 1,
                student_result=nothing,
                teacher_result=nothing,
                student_call=$stud_str,
                teacher_call=$teach_str,
                runstatus=skipped,
                passed=false;
                $settings...)
        end
        add_test!($(evaluation), test)
        test
    end
    return code
end

function add_test!(e::Evaluation, t::Test)
    e.maxid = e.maxid + 1
    if t.passed
        e.gained_points += t.maxpoints
    end
    e.testblocks[t.id] = t
    e.maxpoints += t.maxpoints
end

macro get_res(ex)
    quote
        output = iocapture(color=true, rethrow=Union{}) do
            try
                $(esc(ex))
            catch e
                error_msg = sprint(showerror, e)
                st = sprint((io, v) -> show(io, "text/plain", v), stacktrace(catch_backtrace()))
                @warn "$(error_msg)\n$(st)"
                rethrow(e)
            end
        end
        @warn stacktrace(output.backtrace)
        RunResult(output...)
    end
end

# using Suppressor

# macro get_res_suppress(ex)
#     a = esc(ex)
#     quote
#         local x
#         output = @capture_out begin
#             local e
#             try
#                 x = esc($a)
#             catch e
#                 @warn e
#             end
#             e
#         end
#         output
#     end
# end
