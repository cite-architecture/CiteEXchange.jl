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
    c1[2] == c2[2]
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

Use the same syntax as for `blocks` to extract data lines from given type of CEX block.  In this example, 

```@example data
url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
str = read(f, String)

lines1 = data(f, CiteEXchange.FileReader, "ctsdata")
lines2 = data(url, CiteEXchange.UrlReader, "ctsdata")
lines3 = data(str, CiteEXchange.StringReader, "ctsdata")
lines4 = data(str, "ctsdata")
```
```@example data
lines1 == lines2 == lines3 == lines4
```

## Select data lines from a list of `Block`s

You can directly supply a list of blocks instead of a CEX source.

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




```@example data
urn = UnstructuredUrn("urn:cts:citedemo:gburg")
blks = blocks(f, CiteEXchange.FileReader)
textdata = data(blks, "ctsdata")
``` 
