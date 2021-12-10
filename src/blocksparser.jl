"""Lazily read URN values from `Blbck`s.  Assume that the first line is a header line to skip, and all other lines have a Cite2Urn in the first delimited column.

$(SIGNATURES)
"""
function lazycite2urns(citedatablocks::Vector{Block}; delimiter = "|")::Vector{Cite2Urn}
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



"""Lazily read URN values from `Blbck`s.  Assume that the first line is a header line to skip, and all other lines have a Cite2Urn in the first delimited column.

$(SIGNATURES)
"""
function lazyctsurns(citedatablocks::Vector{Block}; delimiter = "|")::Vector{CtsUrn}
    urnlist = []
    for dblock in citedatablocks
        for ln in dblock.lines[2:end]
            # Assume URN is first field when not strict
            parts = split(ln, delimiter)
            u = CtsUrn(parts[1])
            push!(urnlist, droppassage(u))
        end
    end
    urnlist |> unique
end

"""Gather unique collection identifiers for collections data from a Vector of `Block`s without any cross
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

"""Read text data from a Vector of `Block`s without any cross
checking for consistency of cataloging, property definitions and data sets.
$(SIGNATURES)
"""
function laxtexts(blocklist::Vector{Block}; delimiter = "|")::Vector{CtsUrn}
    texturns = []
    # Collect unique URNs for ctsdata blocks
    textblocks = blocksfortype("ctsdata", blocklist)
    push!(texturns, lazyctsurns(textblocks, delimiter = delimiter))
    # Collect unique URNs for ctscatalog blocks
    catalogblocks = blocksfortype("ctscatalog", blocklist)
    push!(texturns, lazyctsurns(catalogblocks, delimiter = delimiter))

    Iterators.flatten(texturns) |> collect |> unique
end


"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all collections in a list of `Block`s.
$(SIGNATURES)
This needs to examine `citecollections`, `citeproperties`, and `citecdata` blocks.  If `strict` is true, all collections appearing in `citedata` blocks must be cataloged in `citecollections`, and header line must match `citeproperties`.
"""
function texts(blocklist::Vector{Block}; strict = true, delimiter = "|")::Vector{CtsUrn}
    if strict
        @warn("Strict parsing not yet implemented")
        laxtexts(blocklist, delimiter = delimiter)
    else
        laxtexts(blocklist, delimiter = delimiter)
    end
end

"""
$(SIGNATURES)
"""
function laxrelations(blocklist::Vector{Block}; delimiter = "|")#::Vector{Cite2Urn}
    # Collect unique URNs for citerelationset blocks
    relsetblocks = blocksfortype("citerelationset", blocklist)
    relations(relsetblocks, delimiter = delimiter) |> unique
end

"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all relation sets in a list of `Block`s.
$(SIGNATURES)
If `strict` is true, all relations sets appearing in `relationsets` blocks must appear in a `datamodel` entry.
"""
function relationsets(blocklist::Vector{Block}; strict = true, delimiter = "|")#::Vector{Cite2Urn}
    if strict
        @warn("Strict parsing not yet implemented")
        laxrelations(blocklist, delimiter = delimiter)
    else
        laxrelations(blocklist, delimiter = delimiter)
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