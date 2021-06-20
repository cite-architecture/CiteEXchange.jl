# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions
using CiteEXchange



makedocs(
    sitename = "CiteEXchange",
    pages = [
        "Home" => "index.md",

        "API documentation" => "apis.md"
    ]
    
)


deploydocs(
    repo = "https://github.com/cite-architecture/CiteEXchange.jl",
)

