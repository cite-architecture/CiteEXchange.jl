
"""Parse a file of CEX data into a group of `Block`s.

$(SIGNATURES)
"""
function fromfile(fname)
    cex =  open(f->read(f, String), fname)
    blocks(cex)
end


"""Parse CEX data from a URL into a group of `Block`s.

$(SIGNATURES)
"""
function fromurl(url)
    data = HTTP.get(url).body |> String
    #cex =  open(f->read(f, String), fname)
    blocks(data)
end