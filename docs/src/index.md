```@setup simple
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")
```


# CiteEXchange

*Parse strings and files in CEX format.*

Cite EXchange format (CEX) is a plain-text format for serializing citable scholarly resources.

## Quick introduction

The plain-text CEX format organizes data in one or more blocks defined by a  CEX header line.  
Reading CEX source data with the `blocks` function creates an array of `Block`s, each of which has a label identifying the block type, followed by a series of data lines.  (Empty or whitespace-only lines are ignored.)  You can use `blocks`:

- with a single argument to parse a string of CEX data
- with a file name and a second parameter `FileReader` to parse CEX data from a file
- with a URL string and a second parameter `UrlReader` to parse CEX retrieved from a URL

This example reads a file with two blocks,  `ctscatalog` and `ctsdata` block.

!!! note

    The file `f` in the example below is `test/assets/burneyex.cex` in this github repository.

```@example simple
using CiteEXchange
blocklist = CiteEXchange.blocks(f, FileReader)
blocklist |> length
```


### Work with contents of an individual block 

You can work directly the array of blocks:

```@example simple
blocklist[1].label
```

```@example simple
blocklist[1].lines
```


### Work with an array of `Block`s

`CiteEXchange` also has functions that work with arrays of `Block`s.  You can see what types of blocks are present.

```@example simple
blocktypes(blocklist)
```

You can find all data for a given type of block.

```@example simple
datafortype("ctscatalog", blocklist)
```

A typical work pattern might be to read an array of blocks, see what types of block are included, and then use an appropriate module to process blocks depending on their type (e.g., use the `CitableCorpus` module to read a `ctsdata` or `ctscatalog` block).