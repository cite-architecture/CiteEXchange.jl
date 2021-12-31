```@setup simple
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")
```


# CiteEXchange

*Parse data in the delimited-text CEX format.*


Cite EXchange format (CEX) is a plain-text format for serializing citable scholarly resources. CEX organizes data in one or more blocks defined by a CEX header line.  Using the `CiteEXchange` package, you can work with data from CEX sources as labelled `Block`s with associated lines of metadata and data, can extract data contents by CEX block type, and can filter contents by URN.



## Quick introduction

You can use the `blocks` function to read source data into a Vector of `Block` objects.  This example reads a file with two blocks, one labelled `ctscatalog` and one labelled `ctsdata`.


```@example simple
using CiteEXchange
blocklist = blocks(f, CiteEXchange.FileReader)
```

!!! note

    The file `f` in the example below is `test/assets/burneyex.cex` in this github repository.


Each `Block` has a label and an array of data lines.  You can work directly with the array of blocks:

```
blocklist[1].label
```

```
blocklist[1].lines
```


## In more detail

The `CiteEXchange` package provides two main functions for working with CEX data:

- the `blocks` function parses and filters CEX sources into lists of `Block`s
- the `data` function parses and filters CEX sources, and extracts only the data lines from the resulting `Block`s


They are documented on the following pages.