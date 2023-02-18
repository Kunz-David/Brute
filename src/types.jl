using Markdown
using MarkdownTables

# abstract type AbstractTest end

# abstract type TestType end

# abstract type FileTest <: TestType end
# abstract type TypeTest <: TestType end
# abstract type FunctionTest <: TestType end
# abstract type ImplementationTest <: TestType end
# abstract type TestBlock end


Base.@kwdef struct RunResult
    value::Any
    output::String
    error::Bool
    backtrace::Vector
end

@enum Optionality optional mandatory
@enum Access public private


@enum Runstatus ran skipped not_ran

Base.@kwdef mutable struct Test
    id::Int
    name::String = "Test #$id"
    maxpoints::Int = 1
    optionality::Optionality = mandatory
    access::Access = private
    description::String = "#$id is $access and $optionality (max. $maxpoints point(s))."
    passed_description::String = "Nice! $access test passed! 🎉"
    failed_description::String = "Yikes! $access test failed. 😞 Try the following..."
    runstatus::Runstatus = not_ran
    passed::Bool = false
    student_call::String
    teacher_call::String
    student_result::Union{RunResult,Nothing}
    teacher_result::Union{RunResult,Nothing}
end
"""
    Evaluation

Create an `Evaluation` object to store `Test`s. Madatory keywords are `name` and `url`.
"""
Base.@kwdef mutable struct Evaluation
    name::String
    url::String
    gained_points::Int = 0
    maxpoints::Int = 0
    description::String = "Automatic evaluation of [$name]($url). A maximum of $(maxpoints) points can be acquired."
    testblocks::Dict{Int,Test} = Dict{Int,Test}()
    maxid::Int = 0
end

function named_tuple(e)
    (; (v => getfield(e, v) for v in fieldnames(typeof(e)))...)
end

function passed(e::Evaluation)
    all([t.passed for (_, t) in e.testblocks if t.optionality == mandatory])
end

function gained_points(t::Test)
    return if t.passed
        t.maxpoints
    else
        0
    end
end

function gained_points(e::Evaluation)
    if passed(e)
        return sum([gained_points(t) for (_, t) in e.testblocks])
    else
        return 0
    end
end

function results(e::Evaluation)

    res = [
        (
            name=t.name,
            passed=t.passed,
            status=t.runstatus,
            gained="$(gained_points(t))/$(t.maxpoints)",
            optionality=t.optionality,
            access=t.access,
        )
        for (_, t) in e.testblocks
    ]

    return res
end

function create_summary(e::Evaluation)
    result_table = results(e)
    if passed(e)
        pass_str = "**You have passed!**"
    else
        pass_str = "**You have not passed, please try again.**"
    end

    str = """
        # *$(e.name) - Summary:*

        $pass_str

        $(result_table |> markdown_table(String))

        Total points gained: $(gained_points(e))
        """

    str
end

function Base.show(io::IO, ev::Evaluation)
    print(io,
        """
        # $(ev.name)

        *$(ev.description)*

        """
    )
end


function as_inline_code(str)
    return "`$str`"
end

function as_code(str)
    return """
        ```
        $str
        ```
        """
end

function as_fold(title, content)
    return """
        <details>
            <summary>
            $title
            </summary>

        $content

        </details>
        """
end


function Base.show(io::IO, t::Test)
    student_out = ""
    if t.runstatus == ran
        result_table = [
            (call=t.teacher_call, result=as_inline_code(t.teacher_result.value)),
            (call=t.student_call, result=as_inline_code(t.student_result.value))
        ]
        describe_string = """
            $(if t.passed t.passed_description else t.failed_description end)
            """

        if t.passed # --> hide results in fold
            res_string = """
                $(as_fold("Results", result_table |> markdown_table(String)))
                """
        else # --> show table
            res_string = """
                $(result_table |> markdown_table(String))
                """
        end
        result_string = describe_string * "\n" * res_string

        if t.access == public
            if countlines(IOBuffer(t.student_result.output)) > 5 || t.passed
                student_out = """
                    $(as_fold("Your Output", as_code(t.student_result.output)))
                    """
            else
                student_out = """
                    $(as_code(t.student_result.output))
                    """
            end
        elseif t.access == private
            student_out = ""
        end

    elseif t.runstatus == skipped
        result_string = """
            Skipped ( - a previous mandatory test has failed).
            """
    elseif t.runstatus == not_ran
        result_string = """
            Didn't run ( - this message should not show).
            """
    end

    outstring = """
        ## $(t.name) $(if t.passed "✔️" else "❌" end)

        *$(t.description)*

        ### Result

        $result_string

        $student_out
        """
    print(io, outstring)
end

function continue_testing(e::Evaluation)
    for (_, t) in e.testblocks
        if t.runstatus == ran && !t.passed && t.optionality == mandatory
            return false
        end
    end
    return true
end



# struct TestGroup{}