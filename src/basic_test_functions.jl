path = "Solution.jl"

function file_exists(path)
    isfile(path)
end

function is_file_runnable!(path,
    load_error_message="Something went wrong while loading your code.",
    not_module_error_message="Your code doesn't seem to be a module, .")

    try
        mod = include(path)
        if !(mod isa Module)
            throw(ErrorException("$path is not a module."))
        end

    catch err
        if err isa LoadError
            @error load_error_message exception = (err, catch_backtrace())
        else
            println(err)
            @error not_module_error_message exception = err
            # @info "Put all of your code into a module named 'Student'"
        end
        return false
    end
    return true
end

function definition_exists(x::Symbol, definitionType)
    isdefined(Brute.Student, x) && getproperty(Brute.Student, x) isa definitionType
end
