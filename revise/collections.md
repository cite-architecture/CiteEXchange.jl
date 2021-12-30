

```@setup library
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "critsigns.cex")
```



# Building a library from CEX using customized CITE collections


There are two ways to map a CITE collection to a Julia type:


1. directly map a collection by its URN (possibly using URN containment)
1. map the datamodel defined for the collection in the source CEX data








## Define the custom types

Invent a URN type.
```@example library
using CiteEXchange
using CitableBase

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
function urnequals(u1::UnstructuredUrn, u2::UnstructuredUrn)
    u1 == u2
end
import CitableBase: urncontains
function urnequals(u1::UnstructuredUrn, u2::UnstructuredUrn)
    u1 == u2
end

import CitableBase: urnsimilar
function urnequals(u1::UnstructuredUrn, u2::UnstructuredUrn)
    u1 == u2
end

```


Invent a citable type

```@example library
struct TerribleTuples <: Citable
    urn::UnstructuredUrn
    fieldproperties
    data
end


struct TerribleCitable <: CitableTrait end
import CitableBase: citabletrait
function citabletrait(::Type{TerribleTuples})  
    TerribleCitable()
end


struct TerribleCex <: CexTrait end
import CitableBase: cexserializable
function cexserializable(::Type{TerribleTuples}) 
    CexSerializable()
end


function tuplematch(fields, u::UnstructuredUrn)
    urncontains(u, UnstructuredUrn(fields[1]))
end



import CitableBase: fromcex
function fromcex(s::AbstractString, TerribleTuples; 
    delimiter = "|", configuration = nothing)
    allblocks =  blocks(s)
    propertyblocks = blocksfortype("citeproperties", allblocks)
    collectionprops = []
    for b in propertyblocks
        for ln in b.lines[2:end]
            push!(collectionprops, split(ln, delimiter))
        end
    end

    datablocks = blocksfortype("citedata", allblocks)
    collectiondata = []
    for b in datablocks
        for ln in b.lines[2:end]
            push!(collectiondata, split(ln, delimiter))
        end
    end
    collectionurns = CiteEXchange.collections(allblocks, delimiter = delimiter, strict = false)


    terrible  = []
    for u in collectionurns
        currprops = filter(p -> tuplematch(p,u), collectionprops)
        currdata = filter(p -> tuplematch(p,u), collectiondata)
        push!(terrible, TerribleTuples(u, currprops, currdata))
    end
    terrible
end

```



## Build from CEX source

Now we can build a library by mapping specific CITE collections to our new class. 

### Mapping content with a containing URN

In this example, we map a collection-level URN to our type. 


!!! note

    In the following example, we've predefined a CEX string `f`.  It contains the path to the file `test/assets/critsigns.cex` in this repository.



```@example library
collectioncex = read(f, String)


signcollection = UnstructuredUrn("urn:cite2:hmt:va_signs:")
tdict1 = Dict(signcollection => TerribleTuples)
coll1 = fromcex(collectioncex, TerribleTuples, configuration=tdict1, strict = false)
```

### Mapping content with a data model

Since the one collection in this sample is mapped to a data model, we can create a library with equivalent contents using the data model's URN as the key to the Julia type.

```
annotationmodel = Cite2Urn("urn:cite2:demo:datamodels.v1:annotationmodel")
tdict2 = Dict(annotationmodel => TerribleTuples)
lib2 = citelibrary(collectioncex, tdict2)
```