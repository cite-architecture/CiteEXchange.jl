```@setup blocks
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")
```


# The `blocks` function

The `blocks` function can:

- parse a CEX data source into `Block`s, optionally filtering it by block type
- filter a list of `Block`s by block type

It always returns a (possibly empty) Vector of `Block`s.

## Parsing a CEX data source

The following examples parse a CEX source with two blocks, one a `ctscatalog` block, the other a `ctsdata` block.  They parse identical data from a URL, a file (`f` in the example below is `test/assets/burneyex.cex` in this github repository), and a string value using `blocks` with a specified "reader".

Parse CEX from a URL:

```@example blocks
using CiteEXchange
using CitableBase
url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
urlblocks = blocks(url, UrlReader)
```

From a file:

```@example blocks
fileblocks = blocks(f, FileReader)
```

From a string:

```@example blocks
cexstring = read(f, String)
stringblocks = blocks(cexstring, StringReader)
```

The default is to parse from a string.

```@example blocks
defaultblocks = blocks(cexstring)
```

The results are equivalent.

```@example blocks
urlblocks == fileblocks == stringblocks == defaultblocks
```


## Filter CEX source by type

Specify the String value of a CEX block type as an additional parameter to filter the resulting Vector of `Block`s to include only blocks of that type.


```@example blocks
urlcatalog = blocks(url, UrlReader, "ctscatalog")
filecatalog = blocks(f, FileReader, "ctscatalog")
stringcatalog = blocks(cexstring, StringReader, "ctscatalog")
defaultcatalog = blocks(cexstring, "ctscatalog")
```


```@example blocks
urlcatalog == filecatalog == stringcatalog == defaultcatalog
```


## Filter a list of `Block`s by type

The `blocks` function can also  be used to select blocks of a given type from a list of `Block`s.


```@example blocks
filteredcatalog = blocks(fileblocks, "ctscatalog")
```


```@example blocks
filteredcatalog == filecatalog
```