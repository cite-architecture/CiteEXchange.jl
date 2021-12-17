
"""Map models to URNs of implementations as collections or relationsets.
$(SIGNATURES)
"""
function modeldict(blocklist::Vector{Block}; delimiter = "|")
    mappings = Dict()
    dms = blocksfortype("datamodels", blocklist)
    for dm in dms
        # skip header:
        for mapping in dm.lines[2:end]
            cols = split(mapping, delimiter)
            dmurn = Cite2Urn(cols[2])
            target = Cite2Urn(cols[1])
            #mappings[target] = dmurn
            if haskey(mappings, dmurn)
                prev = mappings[dmurn]
                curr = push!(prev, target)
            else
                mappings[dmurn] = [target]
            end
        end
    end
    mappings
end


function instantiaterelations(cexsrc::AbstractString, typesdict; delimiter = "|", strict = false)
    if strict
        @warn("instantiaterelations: strict parsing not yet implemented")
    end
    allblocks = blocks(cexsrc)
    models = datamodels(allblocks, delimiter = delimiter)
    relseturns = relationsets(allblocks, delimiter = delimiter)



    relsets = []
end

function relationsformodel(blocklist::Vector{Block}, model::Cite2Urn; delimiter = "|")
    relseturns = relationsets(allblocks, delimiter = delimiter)


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
