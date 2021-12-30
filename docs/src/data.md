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

- select data lines from a list of `Block`s for a specified block type
- optionally filter data by a URN value

It always returns a (possibly empty) Vector of string values representing CEX data lines.





## Filter by URN

Here's the type we're using:

```@example data
UnstructuredUrn
```


```@example data
urn = UnstructuredUrn("urn:cts:citedemo:gburg")
blks = blocks(f, CiteEXchange.FileReader)
gburgdata = data(blks, "ctsdata", urn)
``` 
