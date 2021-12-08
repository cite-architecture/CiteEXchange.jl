
function lazyurns(citedatablocks::Vector{Block}; delimiter = "|")::Vector{Cite2Urn}
    urnlist = []
    for dblock in citedatablocks
        for ln in dblock.lines[2:end]
            # Assume URN is first field when not strict
            parts = split(ln, delimiter)
            u = Cite2Urn(parts[1])
            push!(urnlist, dropobject(u))
        end
    end
    urnlist |> unique
end

function laxcollections(blocklist::Vector{Block}; delimiter = "|")::Vector{Cite2Urn}
    collectionurns = []
    # Collect unique URNs for citedata blocks
    datablocks = blocksfortype("citedata", blocklist)
    push!(collectionurns, lazyurns(datablocks, delimiter = delimiter))
    # Collect unique URNs for citeproperty blocks
    propertyblocks = blocksfortype("citeproperties", blocklist)
    push!(collectionurns, lazyurns(propertyblocks, delimiter = delimiter))
    # Collect unique URNs for citecollection blocks
    catalogblocks = blocksfortype("citecollections", blocklist)
    push!(collectionurns, lazyurns(catalogblocks, delimiter = delimiter))

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
function datamodels(blocklist::Vector{Block})
    nothing
end

"""Gather a (possibly empty) list of `Block`s for a given data model.
$(SIGNATURES)
This could be multiple blocks for a collection or a relationset.
"""
function blocksformodel(modelurn::Cite2Urn, blocklist::Vector{Block})
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


"""Gather data lines for a specified relation sets
$(SIGNATURES)
"""
function dataforrelations(coll::Cite2Urn, blocklist::Vector{Block})
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
function rawrelations(blocklist::Vector{Block})
    nothing
end



"""
$(SIGNATURES)
"""
function emptycollections(blocklist::Vector{Block})
    nothing
end

"""
$(SIGNATURES)
"""
function emptyrelations(blocklist::Vector{Block})
    nothing
end