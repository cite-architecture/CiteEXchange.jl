
function collectionsdataforurn(citeblocks::Vector{Block}, u::Cite2Urn; delimiter = "|", strict = true)
    allblocks = blocksfortype("citedata", citeblocks)
    if strict
        @warn("collectionsdataforurn: strict parsing not yet implemented")
    end
    # This is all lazy:
    blocksdata = []
    for blk in allblocks
        for ln in blk.lines[2:end]
            fields = split(ln, delimiter)
            ln_urn = Cite2Urn(fields[1])
            if urncontains(u, ln_urn)
                push!(blocksdata, ln)
            end
        end
    end
    filter(v -> ! isempty(v), blocksdata)
end



function propertydataforurn(citeblocks::Vector{Block}, u::Cite2Urn; delimiter = "|", strict = true)
    allblocks = blocksfortype("citeproperties", citeblocks)
    if strict
        @warn("propertydataforurn: strict parsing not yet implemented")
    end
    # This is all lazy:
    blocksdata = []
    for blk in allblocks
        for ln in blk.lines[2:end]
            fields = split(ln, delimiter)
            ln_urn = Cite2Urn(fields[1])
            if urncontains(u, ln_urn)
                push!(blocksdata, ln)
            end
        end
    end
    filter(v -> ! isempty(v), blocksdata)
end

function instantiatecollections(cexsrc::AbstractString, typesdict; delimiter = "|", strict = false)
    if strict
        @warn("instantiaterelations: strict parsing not yet implemented")
    end
    allblocks = blocks(cexsrc)
    #relseturns = relationsets(allblocks, delimiter = delimiter)
    collectionurns = collections(allblocks, delimiter = delimiter, strict = false)
    
    directlymapped = Dict()
    for seturn in collectionurns
        for k in keys(typesdict)
            if (k isa Cite2Urn) && urncontains(k, seturn)
                directlymapped[seturn] = typesdict[k]
            end
        end
    end


    instantiated = []
    for directurn in keys(directlymapped)
        directdata = collectionsdataforurn(allblocks, directurn, delimiter = delimiter)
        directcex = "#!citedata\n" * join(directdata, "\n") * "\n"
        
        propsdata = propertydataforurn(allblocks, directurn, delimiter = delimiter)
        propscex =  "#!citeproperties\n" * join(propsdata, "\n") * "\n"
        push!(instantiated, fromcex(join([directcex, propscex], "\n\n"), directlymapped[directurn]))
    end
    instantiated
    #citecolls = []
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
    propertyurns = lazycite2urns(propertyblocks, delimiter = delimiter)
    push!(collectionurns, map(p -> dropproperty(p), propertyurns))

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
