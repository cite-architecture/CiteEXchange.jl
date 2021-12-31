
"""Find data lines for all blocks of type `blocktype` in the CEX string `s` and filter by urn containment on `urn`.

$(SIGNATURES)
"""
function data(s::AbstractString, blocktype::AbstractString, urn::U; delimiter = "|", complement = false) where {U <: Urn}
    data(blocks(s), blocktype, urn, delimiter = delimiter, complement = complement)
end


"""Find data lines for all blocks of type `blocktype` in the CEX string `s`
and filter by urn containment on `urn`.

$(SIGNATURES)
"""
function data(blockgroup::Vector{Block}, blocktype::AbstractString, urn::U; delimiter = "|", complement = false) where {U <: Urn}
    if blocktype == "citerelationset"
        relblocks = blocks(blockgroup, "citerelationset")
        relationsdata(relblocks, urn, complement = complement)
    else
        datalines = data(blockgroup, blocktype)
        matchinglines = []
        otherlines  = []
        #@info("Filter data on $(urn)")
        for line in datalines
            fields = split(line, delimiter)
            try
                urnval = U(fields[1])
                if urncontains(urn, urnval)
                    push!(matchinglines, line)
                else
                    push!(otherlines, line)
                end
            catch
                @warn("Failed testing $(urn) on line $(line) with type $(U)")
            end
        end
        complement ? otherlines : matchinglines
    end
end



"""Extract data from all relation sets where relation belongs to a specified collection.

$(SIGNATURES)
"""
function relationsdata(blocklist, coll::U; complement = false) where {U <: Urn}
    relationblocks = filter(b -> b.label == "citerelationset", blocklist)
    relationlines = []
    exlcudedlines = []
    for blk in relationblocks
        urnstr = replace(blk.lines[1], "urn|" => "")
        try
            objurn = U(urnstr)
            if urncontains(coll, objurn)
                push!(relationlines, blk.lines[4:end])
            else
                push!(exlcudedlines, blk.lines[4:end])
            end
        catch
            @warn("Unable to make URN of type $(U) from $(urnstr)")
        end
    end
    included = relationlines |> Iterators.flatten |> collect
    excluded = exlcudedlines |> Iterators.flatten |> collect
    complement ? excluded : included
end