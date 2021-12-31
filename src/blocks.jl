
"""Find blocks of a given type in a blockgroup. 

$(SIGNATURES)
"""
function blocks(blockgroup::Vector{Block}, blocktype::AbstractString)::Vector{Block}
    filter(blk -> blk.label == blocktype, blockgroup)
end

"Trait for how to parse strings into blocks"
abstract type BlockReaderType end

"Singleton identifying string as CEX data to parse."
struct StringReader <: BlockReaderType end

"Singleton identifying string as URL source for CEX data to parse."
struct UrlReader <: BlockReaderType end

"Singleton identifying string as file source for CEX data to parse."
struct FileReader <: BlockReaderType end


"""Parse `s` into an Array of `Block`s.
$(SIGNATURES)
"""
function blocks(s::AbstractString)::Vector{Block}
    blockgroup = Block[]
    blocks = split(s, "#!")
    for block in blocks
        lines = split(block, "\n")
        tidy = map(ln -> strip(ln), lines) 
        cutcomments = filter(ln -> ! startswith(ln, "//") , tidy)
        nonempty = filter(ln -> ! isempty(ln), cutcomments)
        if isempty(nonempty)
        else
            categorized = blocktype(lines[1])
            if isnothing(categorized)
            else
                push!(blockgroup, Block(categorized, nonempty[2:end]))
            end
        end
    end
    blockgroup
end

"""Parse `s` into an Array of `Block`s.

$(SIGNATURES)
"""
function blocks(s::AbstractString, sreader::Type{StringReader})::Vector{Block}
    blocks(s)
end



"""Parse CEX data from file `fname` into an Array of `Block`s.

$(SIGNATURES)
"""
function blocks(fname::AbstractString, freader::Type{FileReader})::Vector{Block}
    cex =  open(f->read(f, String), fname)
    blocks(cex)
end

"""Parse CEX data from `url` into an Array of `Block`s.

$(SIGNATURES)
"""
function blocks(url, ureader::Type{UrlReader})::Vector{Block}
    data = HTTP.get(url).body |> String
    blocks(data)
end


"""Parse `cexsrc` and find blocks of type `blocktype`.

$(SIGNATURES)
"""
function blocks(cexsrc::AbstractString, blocktype::AbstractString) 
    blocks(blocks(cexsrc), blocktype)
end


"""Find blocks of type `blocktype` in a CEX source to read with reader `T`.

$(SIGNATURES)
"""
function blocks(cexsrc::AbstractString, T::Type{<: BlockReaderType}, blocktype::AbstractString) 
    blockgroup = blocks(cexsrc, T)
    blocks(blockgroup, blocktype)
end