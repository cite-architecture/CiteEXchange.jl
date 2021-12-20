# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# You can test locally with LiveServer, e.g.,
#
#     julia  -e 'using LiveServer; serve(dir="docs/build")'
#

using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions
using CiteEXchange



makedocs(
    sitename = "CiteEXchange",
    pages = [
        "Overview" => "index.md",
        "Instantiating content from CEX source" => "library.md",
        "Custom text corpus" => "texts.md",
        "Custom relation set" => "relations.md",
        "Custom CITE collection" => "collections.md",

        "API documentation" => "apis.md"
    ]
    
)


deploydocs(
    repo = "github.com/cite-architecture/CiteEXchange.jl.git",
)
