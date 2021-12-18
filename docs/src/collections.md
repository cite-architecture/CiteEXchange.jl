

```@setup library
collectioncex = """#!datamodels
Collection|Model|Label|Description
urn:cite2:hmt:va_signs.v1:|urn:cite2:demo:datamodels.v1:annotationmodel|Annotation model|Model of critical sign annotating text

#!citecollections
URN|Description|Labelling property|Ordering property|License
urn:cite2:hmt:va_signs.v1:|Occurrences of Aristarchan critical signs in the Veentus A manuscript|urn:cite2:hmt:va_signs.v1.label:|urn:cite2:hmt:va_signs.v1.sequence:|CC-attribution-share-alike

#!citeproperties
Property|Label|Type|Authority list
urn:cite2:hmt:va_signs.v1.urn:|URN|Cite2Urn|
urn:cite2:hmt:va_signs.v1.label:|Name|String|
urn:cite2:hmt:va_signs.v1.passage:|Iliad line|CtsUrn|
urn:cite2:hmt:va_signs.v1.critsign:|Critical sign|Cite2Urn|
urn:cite2:hmt:va_signs.v1.sequence:|Sequence|Number|

#!citedata
urn|label|passage|critsign|sequence
urn:cite2:hmt:va_signs.v1:cs0|diple on Iliad 1.2|urn:cts:greekLit:tlg0012.tlg001.msA:1.2|urn:cite2:hmt:critsigns.v1:diple|0
"""
```

Required Julia packages:

```@example library
using CiteEXchange
using CitableLibrary
```

# Building a library from CEX using customized CITE collections


Two options:

1. map a datamodel
2. map a specific collection


```@example library
using CiteEXchange
using CitableLibrary
```


## Define the custom types

```@example library
using CitableObject

struct TerribleTuples
    urn::Cite2Urn
    fieldproperties
    data
end

import CitableBase: CitableTrait
CitableTrait(::Type{TerribleTuples}) = CitableByCite2Urn()

import CitableLibrary: CitableLibraryTrait
CitableLibraryTrait(::Type{TerribleTuples}) = CitableLibraryCollection()

import CitableBase: CexSerializable
CexSerializable(::Type{TerribleTuples}) = CexSerializable()

function tuplematch(fields, u::Cite2Urn)
    urncontains(u, Cite2Urn(fields[1]))
end

import CitableBase: fromcex
function fromcex(s::AbstractString, TerribleTuples; delimiter = "|")
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

## Mapping content with a containing URN

In this example, we map a collection-level URN to our type. 

```@example library
signcollection = Cite2Urn("urn:cite2:hmt:va_signs:")
tdict1 = Dict(signcollection => TerribleTuples)
lib1 = library(collectioncex, tdict1)
```




```@example library
annotationmodel = Cite2Urn("urn:cite2:demo:datamodels.v1:annotationmodel")
tdict2 = Dict(annotationmodel => TerribleTuples)
lib2 = library(collectioncex, tdict2)
```