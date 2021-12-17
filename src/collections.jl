

function instantiatecollections(cexsrc::AbstractString, typesdict; delimiter = "|", strict = false)
    #    collectionurns = collections(citeblocks, delimiter = delimiter, strict = false)
    citecolls = []
end


"""Gather unique set of `Cite2Urn`s identifying collections data from a Vector of `Block`s,
without applying any cross
checking for consistency of cataloging, property definitions and data sets.
$(SIGNATURES)
"""
function laxcollections(blocklist::Vector{Block}; delimiter = "|")::Vector{Cite2Urn}
    collectionurns = []
    # Collect unique URNs for citedata blocks
    datablocks = blocksfortype("citedata", blocklist)
    push!(collectionurns, lazycite2urns(datablocks, delimiter = delimiter))
    # Collect unique URNs for citeproperty blocks
    propertyblocks = blocksfortype("citeproperties", blocklist)
    push!(collectionurns, lazycite2urns(propertyblocks, delimiter = delimiter))
    # Collect unique URNs for citecollection blocks
    catalogblocks = blocksfortype("citecollections", blocklist)
    push!(collectionurns, lazycite2urns(catalogblocks, delimiter = delimiter))

    Iterators.flatten(collectionurns) |> collect |> unique
end

"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all collections in a list of `Block`s.
$(SIGNATURES)
This needs to examine `citecollections`, `citeproperties`, and `citecdata` blocks.  If `strict` is true, all collections appearing in `citedata` blocks must be cataloged in `citecollections`, and header line must match `citeproperties`.
"""
function collections(blocklist::Vector{Block}; strict = true, delimiter = "|")::Vector{Cite2Urn}
    if strict
        @warn("Strict parsing not yet implemented")
        laxcollections(blocklist, delimiter = delimiter)
    else
        laxcollections(blocklist, delimiter = delimiter)
    end
end


"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all datamodels in a list of `Block`s.
$(SIGNATURES)
"""
function datamodels(blocklist::Vector{Block}; delimiter = "|")
    dmurns = []
    dmblocks = blocksfortype("datamodels", blocklist)
    for blk in dmblocks
        for dm in blk.lines[2:end]
            parts = split(dm, delimiter)
            push!(dmurns, Cite2Urn(parts[1]))
        end
    end
    unique(dmurns)
end


"""Gather a (possibly empty) list of `Block`s for a given data model.
$(SIGNATURES)
This could be multiple blocks for a collection or a relationset.
"""
function blocksformodel(modelurn::Cite2Urn, blocklist::Vector{Block})
    nothing
end

"""
$(SIGNATURES)
"""
function rawcollections( blocklist::Vector{Block})
    nothing
end

"""
$(SIGNATURES)
"""
function emptycollections(blocklist::Vector{Block})
    nothing
end

"""Gather data lines for a specified collection.
$(SIGNATURES)
"""
function dataforcollection(coll::Cite2Urn, blocklist::Vector{Block})
    nothing
end


"""Gather catalog data lines for a specified collection.
$(SIGNATURES)
"""
function catalogforcollection(coll::Cite2Urn, blocklist::Vector{Block})
    nothing
end
