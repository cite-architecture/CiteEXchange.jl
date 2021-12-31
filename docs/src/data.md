```@setup data
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")

using CitableBase
using CiteEXchange

struct UnstructuredUrn <: Urn
    id::AbstractString
end

import Base: show
function show(io::IO, u::UnstructuredUrn)
    print(io, u.id)
end

struct MyComparable <: UrnComparisonTrait end

import CitableBase: urncomparisontrait
function urncomparisontrait(::Type{UnstructuredUrn})
    MyComparable()
end

import CitableBase: urnequals
function urnequals(::MyComparable, u1::UnstructuredUrn, u2::UnstructuredUrn)
    u1 == u2
end
import CitableBase: urncontains
function urncontains(::MyComparable, u1::UnstructuredUrn, u2::UnstructuredUrn)
    c1 = components(u1.id)
    c2 = components(u2.id)
    c1[3] == c2[3]
end

import CitableBase: urnsimilar
function urnsimilar(::MyComparable, u1::UnstructuredUrn, u2::UnstructuredUrn)
    urncontains(u1, u2)
end

root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "laxlibrary1.cex")

```

# The `data` function

The `data` function can:

- select data lines for a specified block type from a CEX source or from a list of `Block`s 
- optionally filter data by a URN value

It always returns a (possibly empty) Vector of string values representing CEX data lines.

## Select data lines from CEX sources

In this example, we work with a CEX source that has several different kinds of CEX blocks, and two `ctsdata` blocks with passages from two different texts.  We can collect all of the text datalines using the same syntax as for the `blocks` function.
 

```@example data
url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/dev/test/assets/laxlibrary1.cex"
str = read(f, String)

lines1 = data(f, CiteEXchange.FileReader, "ctsdata")
lines2 = data(url, CiteEXchange.UrlReader, "ctsdata")
lines3 = data(str, CiteEXchange.StringReader, "ctsdata")
lines4 = data(str, "ctsdata")
```
```@example data
lines1 == lines2 == lines3 == lines4
```


Note in particular that `citerelationset` blocks have three lines of metadata before the relations data. These three lines appear in the `lines` field of a block, but are not included in the output of `data`.

```@example data
relblocks = blocks(str, "citerelationset")
relblocks[1].lines
```

```@example data
data(str, "citerelationset")
```

## Select data lines from a list of `Block`s

Instead of a CEX source, you can also directly supply a list of blocks (without a "reader" type). 

```@example data
blockgroup = blocks(str)
blocklines = data(blockgroup, "ctsdata")
```

```@example data
blocklines == lines3
```

## Filter data lines by URN

The `data` function optionally accepts a third parameter with a URN value to filter on by URN containment.  The background setup for this page has defined a subtype of `Urn` called `UnstructuredUrn` that accepts any kind of URN string, and has implemented the `UrnComparisonTrait` for the type, so we can use `UnstructuredUrn` values to filter the data from blocks in our source.

!!! note "Realistic URN types"

    The `UnstructuredUrn` is used solely for the purposes of testing the `CiteEXchange` package.  In our experience, we can cover all needs for scholarly citation with either the `CtsUrn` type of [the `CitableText` package](https://cite-architecture.github.io/CitableText.jl/stable/), or the `Cite2Urn` of [the `CitableObject` package](https://github.com/cite-architecture/CitableObject.jl).


When we collected all the `ctsdata` lines, we got five passages from two different texts.  Now we'll filter the request to get data from a single text.

```@example data
urn = UnstructuredUrn("urn:cts:citedemo:gburg")
blks = blocks(f, CiteEXchange.FileReader)
textdata = data(blks, "ctsdata", urn)
``` 
