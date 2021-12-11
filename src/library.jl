function laxlibrary(citeblocks::Vector{Block}, typesdict; delimiter = "|")
    texturns = texts(citeblocks, delimiter = delimiter, strict = false)
    collectionurns = collections(citeblocks, delimiter = delimiter, strict = false)
    relseturns = relationsets(citeblocks, delimiter = delimiter)
    (texturns, collectionurns, relseturns)
end

function library(citeblocks::Vector{Block}, typesdict; delimiter = "|", strict = true)
    if strict
        @warn("Strict parsing not yet implemented.")
        laxlibrary(citeblocks, typesdict, delimiter = delimiter)
    else
        laxlibrary(citeblocks, typesdict, delimiter = delimiter)
    end
end