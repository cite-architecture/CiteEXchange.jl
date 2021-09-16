# CiteEXchange

*Parse strings and files in CEX format.*

Cite EXchange format (CEX) is a plain-text format for serializing citable scholarly resources.

## Quick example

Plain-text CEX files are composed of one or more blocks defined by a  CEX header line.  

Reading a CEX file creates an array of `Block`s, each of which has a label identifying the block type, and a series of data lines. This example reads a file with `ctscatalog` and `ctsdata` blocks.

```@setup simple
f = string(pwd() |> dirname, "/data/burneyex.cex")
```
```@example simple
using CiteEXchange
blocklist = CiteEXchange.fromfile(f)
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

CiteEXchange also has functions that work with arrays of `Block`s.  You can see what types of blocks are present.

```@example simple
blocktypes(blocklist)
```

You can find all data for a given type of block.

```@example simple
datafortype("ctscatalog", blocklist)
```

A typical work pattern might be to read an array of blocks, see what types of block are included, and then use an appropriate module to process blocks depending on their type (e.g., use the `CitableCorpus` module to read a `ctsdata` or `ctscatalog` block).