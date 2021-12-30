
"""Find data lines for all blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function data(blocktype::AbstractString, blockgroup::Vector{Block})
    blks = blocksfortype(blocktype, blockgroup) 
    datalines = map(blk -> blk.lines, blks)
    Iterators.flatten(datalines) |> collect
end
