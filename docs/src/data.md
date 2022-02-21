```@setup data
root = pwd() |> dirname |> dirname



```

# The `data` function

The `data` function can select data lines for a specified block type from a CEX source or from a list of `Block`s 

It always returns a (possibly empty) Vector of string values representing CEX data lines.

## Select data lines from CEX sources

In this example, we work with a CEX source that has several different kinds of CEX blocks, and two `ctsdata` blocks with passages from two different texts.  We can collect all of the text datalines using the same syntax as for the `blocks` function.


```@example data
using CiteEXchange
f = joinpath(root, "test", "assets", "burneyex.cex")
str = read(f, String)
simplelines = data(str, "ctsdata")
```

```@example data
using CitableBase: StringReader
stringlines = data(str, StringReader, "ctsdata")
```


```@example data
using CitableBase: FileReader
filelines = data(f, FileReader, "ctsdata")
```

```@example data
using CitableBase: UrlReader
url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/dev/test/assets/laxlibrary1.cex"
urllines = data(url, UrlReader, "ctsdata")
```

```@example data
simplelines == stringlines == filelines == urllines
```


Note in particular that `citerelationset` blocks have three lines of metadata before the relations data. These three lines appear in the `lines` field of a block, but are not included in the output of `data`.

```@example data
relationsurl = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/dev/test/assets/laxlibrary1.cex"
relblocks = blocks(relationsurl, UrlReader, "citerelationset")
relblocks[1].lines
```

```@example data
data(relationsurl, UrlReader, "citerelationset")
```

## Select data lines from a list of `Block`s

Instead of a CEX source, you can also directly supply a list of blocks (without a "reader" type). 

```@example data
blockgroup = blocks(relationsurl, UrlReader)
blocklines = data(blockgroup, "ctsdata")
```
