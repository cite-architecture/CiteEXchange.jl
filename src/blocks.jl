"""A single block of CEX data."""
struct Block
    label
    lines
end


"""Override `==` for `Block`.

$(SIGNATURES)
"""
function ==(b1::Block, b2::Block)
    b1.label == b2.label && b1.lines == b2.lines
end

"""Serialize `b` to CEX format.
$(SIGNATURES)
"""
function blocktocex(b::Block)
    join(["!#", b.label, "\n"]) * join(b.lines, "\n") * "\n"
end

"""Find data lines for all blocks of a given type in a blockgroup.

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

