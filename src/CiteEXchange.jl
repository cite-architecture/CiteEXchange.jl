# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using CitableObject
using HTTP

import CitableLibrary: CitableLibraryTrait

include("blocks.jl")
include("file.jl")
include("blocksparser.jl")

export blocks, blocktypes, blocksfortype, datafortype
export relations
export cexversion 

export collections, datamodels


end # module
