

"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all collections in a list of `Block`s.
$(SIGNATURES)
"""
function collections(blocklist::Vector{Block})
    nothing
end



"""Gather a (possibly empty) list of `Cite2Urn`s
identifying all datamodels in a list of `Block`s.
$(SIGNATURES)
"""
function datamodels(blocklist::Vector{Block})
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