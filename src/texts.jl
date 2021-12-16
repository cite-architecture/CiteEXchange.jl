
"""Extract from a list of `Block`s ctsdata lines with URNs contained
by a given URN.
$(SIGNATURES)
"""
function dataforctsurn(citeblocks::Vector{Block}, u::CtsUrn; delimiter = "|")
    allblocks = blocksfortype("ctsdata", citeblocks)
    data = []
    for blk in allblocks
        for ln in blk.lines
            parts = split(ln, delimiter)
            if urncontains(u, CtsUrn(parts[1]))
                push!(data, ln)
            end
        end
    end
    data
end


"""Instantiate text corpora from CEX source.
$(SIGNATURES)
`typesdict` can map either or both of:

1. a string for the block label `ctsdata`
2. a CtsUrn 

These keys should point to a Julia type implementing the `CitableLibraryTrait` (including the `fromcex` function).
"""
function instantiatetexts(cexsrc::AbstractString, typesdict; delimiter = "|", strict = false)
    if strict
        @warn("instantiatetexts: strict parsing not yet implemented")
    end
    texturns = texts(blocks(cexsrc), delimiter = delimiter, strict = strict)


    corpora = []
    specialcases = filter(k -> k isa CtsUrn, keys(typesdict))
    for special in specialcases
        #data = dataforctsurn(citeblocks, special, delimiter = delimiter)
        #@info(typesdict[special])
        push!(corpora, fromcex(cexsrc, typesdict[special]))
    end
    # Now get corpora that are not special.
    if "ctsdata" in keys(typesdict)
        # collect all copora that are NOT special.
        # Then something similar to:
        #ctsblocks = ....
        #dataforctsurn(ctsblocks,...)
        #push!(corpora, fromcex(cexsrc, typesdict["ctsdata"]))
    end
    corpora
end

"""Read text data from a Vector of `Block`s without any cross
checking for consistency of cataloging, property definitions and data sets.
$(SIGNATURES)
"""
function laxtexts(blocklist::Vector{Block}; delimiter = "|")::Vector{CtsUrn}
    texturns = []
    # Collect unique URNs for ctsdata blocks
    textblocks = blocksfortype("ctsdata", blocklist)
    push!(texturns, lazyctsurns(textblocks, delimiter = delimiter))
    # Collect unique URNs for ctscatalog blocks
    catalogblocks = blocksfortype("ctscatalog", blocklist)
    push!(texturns, lazyctsurns(catalogblocks, delimiter = delimiter))

    Iterators.flatten(texturns) |> collect |> unique
end

"""Gather a (possibly empty) list of `CtsUrn`s
identifying all texts in a list of `Block`s.
$(SIGNATURES)
If `strict` is true, all texts appearing in `ctsdata` blocks must be cataloged in a `ctscatalog`.
"""
function texts(blocklist::Vector{Block}; strict = true, delimiter = "|")::Vector{CtsUrn}
    if strict
        @warn("Strict parsing not yet implemented")
        laxtexts(blocklist, delimiter = delimiter)
    else
        laxtexts(blocklist, delimiter = delimiter)
    end
end