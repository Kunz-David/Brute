
function hide_hidden_blocks(content; remove_comments=true)
    re = r"#hideblock begin(.*?)#hideblock end"ms
    matches = eachmatch(re, content)
    for match in matches
        replace_string = add_to_end_of_line(match.match)
        if remove_comments
            replace_string = remove_comments_fun(replace_string)
        end
        content = replace(content, match.match => replace_string)
    end
    content
end

function process_onlymd(content)
    return content |> uncode_onlymd |> delete_onlymd_source
end

function remove_empty_code(content)
    re = r"````julia\n\s*?````"ms
    content = replace(content, re => "")
    return content
end



function uncode_onlymd(content)
    # https://regex101.com/r/cou3Hg/1
    re = r"(?<=#onlymd\n````\n\n).*?\n````"ms
    matches = eachmatch(re, content)
    for match in matches
        replace_string = replace(match.match, "````" => "")
        content = replace(content, match.match => replace_string)
    end
    content
end

function delete_onlymd_source(content)
    re = r"````julia\n.*?````"ms
    matches = eachmatch(re, content)
    for match in matches
        if contains(match.match, "#onlymd")
            content = replace(content, match.match => "")
        end
    end
    content
end



function save_content(content; fname="preprocessed.jl")
    fpath = joinpath(pwd(), fname)
    open(fpath, "w") do file
        write(file, content)
    end
    content
end


# https://regex101.com/r/m9OBx2/1
function remove_comments_fun(content)
    return replace(content, r"^[ ]*#[ ]*\N*"m => "")
end

function add_to_end_of_line(content, added_string::String=" #hide")
    return replace(content, r"\n" => "$added_string\n") * added_string
end
