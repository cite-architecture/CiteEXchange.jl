# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using HTTP

import Base.==

using CitableBase, CitableObject

include("blocks.jl")
include("reader.jl")
include("relations.jl")

export cexversion 

export FileReader, UrlReader, StringReader
# Blocks and raw data
export blocks, blocktypes, blocksfortype
export datafortype, relationsdata


end # module
