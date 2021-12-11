"""A single block of CEX data."""
struct Block
    label
    lines
end

"""Find blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function datafortype(blocktype::AbstractString, blockgroup::Vector{Block})
    blks = blocksfortype(blocktype, blockgroup) 
    datalines = map(blk -> blk.lines, blks)
    Iterators.flatten(datalines) |> collect
end

"""Find blocks of a given type in a blockgroup.

$(SIGNATURES)
"""
function blocksfortype(blocktype::AbstractString, blockgroup::Vector{Block})
    filter(blk -> blk.label == blocktype, blockgroup)
end

"""Find list of unique block types in a group.

$(SIGNATURES)
"""
function blocktypes(blockgroup::Vector{Block})::Vector{AbstractString}
    map(blk -> blk.label, blockgroup) |> unique
end

"""Determine block type from first line of a CEX block.

$(SIGNATURES)
"""
function blocktype(s::AbstractString)::Union{AbstractString, Nothing}
    validtypes = [
        "cexversion",
        "citelibrary",
        "ctsdata",
        "ctscatalog",
        "citecollections",
        "citeproperties",
        "citedata",
        "imagedata",
        "relations", # deprecated
        "datamodels",
        "citerelationset",
        "relationsetcatalog"
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
function blocks(s::AbstractString)::Vector{Block}
    blockgroup = Block[]
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

"""Find CEX version for a block group.

$(SIGNATURES)

Return nothing if no version specified.
"""
function cexversion(group)::Union{VersionNumber, Nothing}
    versiondata = datafortype("cexversion", group)
    if length(versiondata) != 1
        @warn "Error: $(length(versiondata)) lines of version data found."
        nothing
    else
        versiondata[1] |> VersionNumber
    end
end

