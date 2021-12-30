# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using HTTP

import Base.==

using CitableBase

include("blocks.jl")
include("reader.jl")
include("relations.jl")


include("readers/collections.jl")
include("readers/datamodels.jl")
include("readers/relations.jl")
include("readers/texts.jl")

export cexversion 

export FileReader, UrlReader, StringReader
# Blocks and raw data
export blocks, blocktypes, blocksfortype
export datafortype, relationsdata

# Identifying URNs:
export collections, texts, datamodels, relationsets


end # module
