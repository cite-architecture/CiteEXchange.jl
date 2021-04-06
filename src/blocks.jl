struct Block
    label::Symbol
    lines
end

function blocktype(s::AbstractString)
    validtypes = [
        "ctscatalog",
        "ctsdata",
        "citecatalog",
        "citedata"
    ]
    if s in validtypes
        s
    else 
        nothing
    end
end


function blocks(s::AbstractString)
    blocks = split(s, "#!")

    for block in blocks
        lines = split(block, "\n")
        categorized = blocktype(lines[1])
    end


    # This gathers data lines.
    #=
    nonempty = filter(b -> length(b) > 4, blocks)
    datablocks = filter(b -> startswith(b, "citedata"), nonempty)
    for db in datablocks
        lns = split(db, "\n")
        for ln in lns[3:end]
            push!(cexdata, ln)
        end
    end
    cexdata
    =#
end

