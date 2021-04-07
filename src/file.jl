
"""Parse a file of CEX data into a group of `Block`s.

$(SIGNATURES)
"""
function fromfile(fname)
    cex =  open(f->read(f, String), fname)
    blocks(cex)
end