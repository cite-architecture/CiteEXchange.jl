
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

"""Gather a (possibly empty) list of `CtsUrn`s
identifying all texts in a list of `Block`s.
$(SIGNATURES)
If `strict` is true, all texts appearing in `ctsdata` blocks must be cataloged in a `ctscatalog`.
"""
function texts(blocklist::Vector{Block}; strict = true, delimiter = "|")::Vector{CtsUrn}
    if strict
        @warn("Strict parsing not yet implemented")
        laxtexts(blocklist, delimiter = delimiter)
    else
        laxtexts(blocklist, delimiter = delimiter)
    end
end