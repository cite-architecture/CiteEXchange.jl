# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using CitableObject
using HTTP

include("blocks.jl")
include("file.jl")

export blocks, blocktypes, blocksfortype, datafortype
export relations
export cexversion 

end # module
