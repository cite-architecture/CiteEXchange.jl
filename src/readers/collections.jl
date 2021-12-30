

#=
"""Gather a (possibly empty) list of `Urn`s
identifying all collections in a list of `CiteEXchange.Block`s.  Use the dictionary in `configuration` to determine how to instantiate `Urn` objects from the results.
$(SIGNATURES)
This needs to examine `citecollections`, `citeproperties`, and `citedata` blocks.  If `strict` is true, all collections appearing in `citedata` blocks must be cataloged in `citecollections`, and header line must match `citeproperties`.
s"""
function collections(blocklist::Vector{CiteEXchange.Block}, configuration; strict = true, delimiter = "|")
    if strict
        @warn("collections: strict parsing not yet implemented")
        laxcollections(blocklist, delimiter = delimiter)
    else
        laxcollections(blocklist, delimiter = delimiter)
    end
end




"""Gather unique set of `Urn`s identifying collections data from a Vector of `CiteEXchange.Block`s,
without applying any cross
checking for consistency of cataloging, property definitions and data sets.
$(SIGNATURES)
"""
function laxcollections(blocklist::Vector{CiteEXchange.Block}, configuration; 
    delimiter = "|")

    special = filter(k -> ( ! (typeof(k) <: AbstractString) && (k <: Urn)), keys(configuration)) |> collect


    #collectionurns = []
    #= Collect unique URNs for citedata blocks
    datablocks = blocksfortype("citedata", blocklist)
    push!(collectionurns, lazyobjecturns(datablocks, delimiter = delimiter))
    =#

    #=
    # Collect unique URNs for citeproperty blocks
    propertyblocks = blocksfortype("citeproperties", blocklist)
    propertyurns = lazycite2urns(propertyblocks, delimiter = delimiter)
    push!(collectionurns, map(p -> dropproperty(p), propertyurns))
    =#

    # Collect unique URNs for citecollection blocks
    catalogblocks = blocksfortype("citecollections", blocklist)
    #push!(collectionurns, lazyobjecturns(catalogblocks, delimiter = delimiter))
    # Iterators.flatten(collectionurns) |> collect |> unique

    urnstrings = lazyobjecturns(catalogblocks, delimiter = delimiter)
   
    # filter by config.  Either of citecollections or by URN
    genericurns = []
    specialurns = []
    for u in urnstrings
        for spec in special
            try
                if urncontains(spec, special(spec))
                    push!(genericurns, special(spec))
                end 
        catch
        end
    end


    urnstrings, special
end




"""Lazily read string values for URNs from `citedatablocks`.  Assume that the first line is a header line to skip, and all other lines have a `Urn` value in the first delimited column.

$(SIGNATURES)
"""
function lazyobjecturns(citedatablocks::Vector{CiteEXchange.Block}; delimiter = "|")
    urnlist = []
    for dblock in citedatablocks
        for ln in dblock.lines[2:end]
            # Assume URN is first field when not strict
            parts = split(ln, delimiter)
            push!(urnlist, parts[1])
        end
    end
    urnlist |> unique
end

=#