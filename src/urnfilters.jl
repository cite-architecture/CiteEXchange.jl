
"""Find data lines for all blocks of type `blocktype` in the CEX string `s` and filter by urn containment on `urn`.

$(SIGNATURES)
"""
function data(s::AbstractString, blocktype::AbstractString, urn::U; delimiter = "|") where {U <: Urn}
    data(blocks(s), blocktype, urn, delimiter = delimiter)
end


"""Find data lines for all blocks of type `blocktype` in the CEX string `s`
and filter by urn containment on `urn`.

$(SIGNATURES)
"""
function data(blockgroup::Vector{Block}, blocktype::AbstractString, urn::U; delimiter = "|") where {U <: Urn}
    datalines = data(blockgroup, blocktype)
    @warn("$(length(datalines)) lines matched")
    matchinglines = []
    @warn("Filter on $(urn)")
    for line in datalines
        fields = split(line, delimiter)
        try
            urnval = U(fields[1])
            if urncontains(urn, urnval)
                push!(matchinglines, line)
            end
        catch
            @warn("Failed testing $(urn) on line $(line) with type $(U)")
        end
    end
    matchinglines
end