"""Lazily construct a `CiteLibrary` from CEX source string and 
a dictionary mapping content to Julia types.  Data for text corpora and CITE collections are not required to be cataloged in corresponding CEX blocks.
$(SIGNATURES)
"""
function laxlibrary(cexsrc::AbstractString, typesdict; delimiter = "|")
    citables = []
    corpora = instantiatetexts(cexsrc, typesdict, delimiter = delimiter, strict = false)
    if ! isempty(corpora)
        push!(citables, corpora)
    end

    relsets = instantiaterelations(cexsrc, typesdict, delimiter = delimiter, strict = false)
    if ! isempty(relsets)
        push!(citables, relsets)
    end

    citecolls = instantiatecollections(cexsrc, typesdict, delimiter = delimiter, strict = false)
    if ! isempty(citecolls)
        push!(citables, citecolls)
    end

    #=texturns = texts(citeblocks, delimiter = delimiter, strict = false)
    collectionurns = collections(citeblocks, delimiter = delimiter, strict = false)
    relseturns = relationsets(citeblocks, delimiter = delimiter)
    (texturns, collectionurns, relseturns)
    =#

    # Flatten the citables list:
    citables |> Iterators.flatten |> collect |> citeLibrary
end

"""Construct a `CiteLibrary` from CEX source string and 
a dictionary mapping content to Julia types.
$(SIGNATURES)
"""
function library(cexsrc::AbstractString, typesdict; delimiter = "|", strict = true)
    if strict
        @warn("Strict parsing not yet implemented.")
        laxlibrary(cexsrc, typesdict, delimiter = delimiter)
    else
        laxlibrary(cexsrc, typesdict, delimiter = delimiter)
    end
end