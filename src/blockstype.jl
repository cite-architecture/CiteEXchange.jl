"""A single block of CEX data."""
struct Block
    label::AbstractString
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

"""Find list of unique block types in a group.

$(SIGNATURES)
"""
function blocktypes(blockgroup::Vector{Block})::Vector{AbstractString}
    map(blk -> blk.label, blockgroup) |> unique
end


"""Find list of unique block types in a group.

$(SIGNATURES)
"""
function blocktypes(cexsrc::AbstractString)::Vector{AbstractString}
    blockgroup = blocks(cexsrc)
    map(blk -> blk.label, blockgroup) |> unique
end

"""Determine block type from first line of a CEX block.

$(SIGNATURES)
"""
function blocktype(b::Block)::AbstractString
    blocktype(b.label)
end

"""Check if `s` is in valid list of block labels, and
return `s`if it is.
$(SIGNATURES)
"""
function blocktype(s::AbstractString)::AbstractString
    validtypes = [
        "cexversion",
        "citelibrary",
        "ctsdata",
        "ctscatalog",
        "citecollections",
        "citeproperties",
        "citedata",
        "imagedata",
        "datamodels",
        "citerelationset",
        "relationsetcatalog"
    ]
    if s == "relations"
        @warn("Block type relations is deprecated and will be removed.  Please use `citerelationset`.")
        s
    elseif s in validtypes
        s
    else 
        throw(DomainError("Invalid block type: $s"))
    end
end

