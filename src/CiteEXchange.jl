# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions

include("blocks.jl")
include("file.jl")

export blocks, blocktypes, blocksfortype, datafortype

end # module
