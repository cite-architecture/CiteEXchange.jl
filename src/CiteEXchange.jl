# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using HTTP

import Base.==

using CitableBase

include("blockstype.jl")
include("blocks.jl")
include("data.jl")
include("relations.jl")


export cexversion 
export blocktypes
export blocks
export data

end # module
