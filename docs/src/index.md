```@setup simple
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")
```


# CiteEXchange

*Parse data in the delimited-text CEX format.*


## Quick introduction

Cite EXchange format (CEX) is a plain-text format for serializing citable scholarly resources. CEX organizes data in one or more blocks defined by a CEX header line.  You can use the `blocks` function to read source data into a Vector of `Block` objects.  
This example reads a file with two blocks, one labelled `ctscatalog` and one labelled `ctsdata`.


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


The `blocks` function and the `data` function provide a variety of ways to select data.  They are documented on the following pages.