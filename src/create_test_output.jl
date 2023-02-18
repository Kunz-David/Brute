using Literate

function create_test_output(
    path,
    save_path=pwd(),
    preprocess_function=x -> x |> hide_hidden_blocks |> save_content,
    postprocess_function=x -> x |> x -> save_content(x, fname="before_postprocessed.md") |> process_onlymd |> x -> save_content(x, fname="postprocessed.md") |> remove_empty_code,
    config...)
    Literate.markdown(path, save_path; preprocess=preprocess_function, postprocess=postprocess_function, execute=true, documenter=false, config...)
end



