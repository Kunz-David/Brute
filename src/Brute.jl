module Brute

# Write your package code here.

# return body a markdown
# nastroje pro ucitele aby mohl definovat testy
# otestovat jestli existuje typ a
# pak funkce s typem a



# test makra 
# mandatory tests


include("types.jl")
export named_tuple
export Evaluation, TestBlock, Test, RunResult, create_summary, passed
export Optionality, Access

include("basic_test_functions.jl")
export file_exists, is_file_runnable!, definition_exists

include("macros.jl")
export Test, @get_res, @get_res_suppress

include("pocessing.jl")
export hide_hidden_blocks, remove_comments

include("create_test_output.jl")
export create_test_output


end
