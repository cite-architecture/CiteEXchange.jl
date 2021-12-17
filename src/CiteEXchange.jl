# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using CitableObject, CitableText
import CitableBase: CexSerializable
import CitableBase: fromcex
import CitableBase: CitableTrait
using CitableLibrary
using HTTP

include("blocks.jl")
include("file.jl")
include("blocksparser.jl")
include("relations.jl")
include("collections.jl")
include("datamodels.jl")
include("texts.jl")
include("library.jl")

export cexversion 

# Blocks and raw data
export blocks, blocktypes, blocksfortype
export datafortype, relationsdata
# Identifying URNs:
export collections, texts, datamodels, relationsets
export relationsformodel, collectionsformodel
export library

end # module
