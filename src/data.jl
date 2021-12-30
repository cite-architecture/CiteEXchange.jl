
"""Find data lines for all blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function data(blockgroup::Vector{Block}, blocktype::AbstractString)
    blks = blocks(blockgroup, blocktype) 

    # relationsets have a special multiline header:
    if blocktype == "relationset"
        relationsdata(blks)
    else
        # Other types all have a one-line header
        datalines = map(blk -> blk.lines[2:end], blks)
        Iterators.flatten(datalines) |> collect
    end
end

"""Find data lines for all blocks of type `blocktype` in the CEX string `s`.

$(SIGNATURES)
"""
function data(s::AbstractString, blocktype::AbstractString)
    data(blocks(s), blocktype)
end


"""Find data lines for all blocks of type `blocktype` after parsing the CEX source with reader `T`.

$(SIGNATURES)
"""
function data(src::AbstractString,  T::Type{<: BlockReaderType}, blocktype::AbstractString)
    data(blocks(src, T), blocktype)
end








"""Extract data from all relation sets in a list of blocks.
$(SIGNATURES)
"""
function relationsdata(blocklist)
    relationblocks = filter(b -> b.label == "citerelationset", blocklist)
    relationlines = []
    for blk in relationblocks
        push!(relationlines, blk.lines[3:end])
    end
    relationlines |> Iterators.flatten |> collect
end


"""Extract data from all relation sets where relation belongs to a specified collection.

$(SIGNATURES)
"""
function relationsdata(blocklist, coll::U) where {U <: Urn}
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