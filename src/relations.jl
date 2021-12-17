

"""Instantiate relation sets from CEX source.
$(SIGNATURES)
Keys in `typesdict` may be either of:

1. a `Cite2Urn` identifying the relation set (possibly by URN containment)
2. a `Cite2Urn` identifying a datamodel defined in `cexsrc`

These keys should point to a Julia type implementing the `CitableLibraryTrait` (including the `fromcex` function).
"""
function instantiaterelations(cexsrc::AbstractString, typesdict; delimiter = "|", strict = false)
    if strict
        @warn("instantiaterelations: strict parsing not yet implemented")
    end
    allblocks = blocks(cexsrc)
    relseturns = relationsets(allblocks, delimiter = delimiter)

    # get urns for sets directly mapped to a Julia type
    directlymapped = []
    for seturn in relseturns
        for k in  keys(typesdict)
            @warn("CHECK ", seturn)
            if (k isa Cite2Urn) && urncontains(k, seturn)
                push!(directlymapped, seturn)
            end
        end
    end


    # get urns for sets following a data model
    dmdict = modelleddict(allblocks, delimiter = delimiter)
    modelled = []
    for seturn in relseturns
        for k in keys(dmdict)
            if urncontains(k, seturn)
                push!(modelled, seturn)
            end
        end
    end
    

    relsets = []
    for directurn in directlymapped
        #directdata = dataforsurn(allblocks, regularurn, delimiter = delimiter)
        #regularcex = "#!ctsdata\n" * join(regulardata, "\n") * "\n"
        #push!(corpora, fromcex(regularcex, typesdict["ctsdata"]))
    end

    for modelledurn in setdiff(modelled, diretlymapped)
    end
    
    # temp display
    (directlymapped, modelled)

end


"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all relation sets in a list of `Block`s.
$(SIGNATURES)
If `strict` is true, all relations sets appearing in `relationsets` blocks must appear in a `datamodel` entry.
"""
function relationsets(blocklist::Vector{Block}; delimiter = "|")#::Vector{Cite2Urn}
    relationurns = []
    relsetblocks = blocksfortype("citerelationset", blocklist)
    for relationblock in relsetblocks
        parts = split(relationblock.lines[1], delimiter)
        push!(relationurns, Cite2Urn(parts[2]))
    end
    relationurns
end

"""Extract data from all relation sets where relation belongs to a specified collection.

$(SIGNATURES)
"""
function relationsdata(blocklist, coll::Cite2Urn)
    relationblocks = filter(b -> b.label == "citerelationset", blocklist)
    relationlines = []
    for blk in relationblocks
        urnstr = replace(blk.lines[1], "urn|" => "")
        objurn = Cite2Urn(urnstr)
        if urncontains(coll, objurn)
            push!(relationlines, blk.lines[3:end])
        end
    end
    relationlines |> Iterators.flatten |> collect
end
