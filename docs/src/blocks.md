# The `blocks` function

The `blocks` function returns a Vector of `Blocks`.  It's main uses are:

- parse a CEX data source into `Block`s, optionally filtering it by block type
- filter a list of `Block`s by block type


## Reading a CEX data source
 
 Specify a type of reader to parse CEX data from a URL, a file or string.


```@example blocks
using CiteEXchange
url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
urlblocks = blocks(url, CiteEXchange.UrlReader)
```
```@example blocks
fileblocks = blocks(f, CiteEXchange.FileReader)
```
```@example blocks
fileblocks == urlblocks
```
```@example blocks
cexstring = read(f, String)
stringblocks = blocks(cexstring, CiteEXchange.FileReader)
```
```@example blocks
fileblocks == stringblocks
```

!!! note

    The file `f` in the example above is `test/assets/burneyex.cex` in this github repository.



The default is to parse from a string.

```@example blocks
defaultblocks = blocks(cexstring)=
```
```@example blocks
defaultblocks == stringblocks
```
