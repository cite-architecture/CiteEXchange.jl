# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using CitableObject, CitableText
using HTTP

include("blocks.jl")
include("file.jl")
include("blocksparser.jl")
include("relations.jl")
include("collections.jl")
include("texts.jl")
include("library.jl")

export cexversion 

# Blocks and raw data
export blocks, blocktypes, blocksfortype
export datafortype, relationsdata
# Identifying URNs:
export collections, texts, datamodels, relationsets
export library

end # module
