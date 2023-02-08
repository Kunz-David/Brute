using Brute
using Documenter

DocMeta.setdocmeta!(Brute, :DocTestSetup, :(using Brute); recursive=true)

makedocs(;
    modules=[Brute],
    authors="Kunz-David <epicfail.davidkunz@gmail.com> and contributors",
    repo="https://github.com/Kunz-David/Brute.jl/blob/{commit}{path}#{line}",
    sitename="Brute.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Kunz-David.github.io/Brute.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Kunz-David/Brute.jl",
    devbranch="main",
)
