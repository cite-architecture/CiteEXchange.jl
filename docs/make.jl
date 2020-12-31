using Pkg
pkg"activate .."
push!(LOAD_PATH,"../src/")
using Documenter, DocStringExtensions, CiteEXchange

makedocs(sitename = "CiteEXchange Documentation")
