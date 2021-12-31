"""Find data lines for all blocks of type `blocktype` in a Vector of `Block`s.

$(SIGNATURES)
"""
function data(blockgroup::Vector{Block}, blocktype::AbstractString; delimiter = "|", diff = false)
    blks = blocks(blockgroup, blocktype) 

    @warn("Get data for $(blocktype)")
    # relationsets have a special multiline header:
    if blocktype == "citerelationset"
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
function data(s::AbstractString, blocktype::AbstractString; delimiter = "|", diff = false)
    data(blocks(s), blocktype, delimiter = delimiter)
end


"""Find data lines for all blocks of type `blocktype` after parsing the CEX source with reader `T`.

$(SIGNATURES)
"""
function data(src::AbstractString,  T::Type{<: BlockReaderType}, blocktype::AbstractString; delimiter = "|", diff = false)
    data(blocks(src, T), blocktype, delimiter = delimiter)
end






"""Extract data from all relation sets in a list of blocks.
$(SIGNATURES)
"""
function relationsdata(blocklist)
    relationblocks = filter(b -> b.label == "citerelationset", blocklist)
    relationlines = []
    for blk in relationblocks
        push!(relationlines, blk.lines[4:end])
    end
    relationlines |> Iterators.flatten |> collect
end

