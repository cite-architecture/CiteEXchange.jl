
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
