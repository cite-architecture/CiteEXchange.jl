"""A single block of CEX data."""
struct Block
    label
    lines
end


"""Find blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function datafortype(blocktype, blockgroup)
    blks = blocksfortype(blocktype, blockgroup) 
    datalines = map(blk -> blk.lines, blks)
    Iterators.flatten(datalines) |> collect
end

"""Find blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function blocksfortype(blocktype, blockgroup)
    filter(blk -> blk.label == blocktype, blockgroup)
end


"""Find list of unique block types in a group.

$(SIGNATURES)
"""
function blocktypes(blockgroup)
    map(blk -> blk.label, blockgroup) |> unique
end

"""Determine block type from first line of a CEX block.

$(SIGNATURES)
"""
function blocktype(s::AbstractString)
    validtypes = [
        "cexversion",
        "citelibrary",
        "ctsdata",
        "ctscatalog",
        "citecollections",
        "citeproperties",
        "citedata",
        "imagedata",
        "relations",
        "datamodels"
    ]
    if s in validtypes
        s
    else 
        @warn "Unrecognized block type: $s. Omitting."
        nothing
    end
end

"""Parse a string into an Array of `Block`s.

$(SIGNATURES)
"""
function blocks(s::AbstractString)
    blockgroup = []
    blocks = split(s, "#!")
    for block in blocks
        lines = split(block, "\n")
        tidy = map(ln -> strip(ln), lines) 
        cutcomments = filter(ln -> ! startswith(ln, "//") , tidy)
        nonempty = filter(ln -> ! isempty(ln), cutcomments)
        if isempty(nonempty)
        else
            categorized = blocktype(lines[1])
            if isnothing(categorized)
            else
                push!(blockgroup, Block(categorized, nonempty[2:end]))
            end
        end
    end
    blockgroup
end

