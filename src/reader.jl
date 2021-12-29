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

"""Parse a string into an Array of `Block`s.

$(SIGNATURES)
"""
function blocks(s::AbstractString, sreader::Type{StringReader})::Vector{Block}
    blocks(s)
end



"""Parse a file of CEX data into a group of `Block`s.

$(SIGNATURES)
"""
function blocks(fname::AbstractString, ::Type{FileReader})::Vector{Block}
    cex =  open(f->read(f, String), fname)
    blocks(cex)
end


"""Parse CEX data from a URL into a group of `Block`s.

$(SIGNATURES)
"""
function blocks(url, ::Type{UrlReader})::Vector{Block}
    data = HTTP.get(url).body |> String
    blocks(data)
end