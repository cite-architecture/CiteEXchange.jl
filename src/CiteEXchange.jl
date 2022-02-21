# A module for parsing data serialized in Cite EXchange format.
module CiteEXchange

using  Documenter, DocStringExtensions
using HTTP

import Base.==

using CitableBase: FileReader
using CitableBase: UrlReader
using CitableBase: StringReader
using CitableBase: ReaderType
using CitableBase: Urn

include("blockstype.jl")
include("blocks.jl")
include("data.jl")
include("headers.jl")

export Block
export blocktypes
export blocks
export blocktype
export data

export cexversion 


end # module
