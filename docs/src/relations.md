
```@setup library
# Change these to read from files in test/assets.
relationcex = """#!datamodels
Collection|Model|Label|Description
urn:cite2:hmt:dse.v1:|urn:cite2:cite:datamodels.v1:dsemodel|Physical text model|Model of a text-bearing surface with documentary image data

#!relationsetcatalog
urn|urn:cite2:hmt:dse.v1:
label|Collection of all DSE records for HMT project MSS
psg|CtsUrn
img|Cite2Urn
surface|Cite2Urn

#!citerelationset
urn|urn:cite2:hmt:dse.v1:msBil8
label|Collection of DSE records for Iliad 8 in the Venetus B
passage|imageroi|surface
// Here's a comment on 8.1.
urn:cts:greekLit:tlg0012.tlg001.msB:8.1|urn:cite2:hmt:vbbifolio.v1:vb_102v_103r@0.4843,0.2961,0.2552,0.05667|urn:cite2:hmt:msB.v1:103r
// Add a note on line 8.2!
urn:cts:greekLit:tlg0012.tlg001.msB:8.2|urn:cite2:hmt:vbbifolio.v1:vb_102v_103r@0.4980,0.3358,0.2336,0.03061|urn:cite2:hmt:msB.v1:103r

#!citerelationset
urn|urn:cite2:hmt:dse.v1:burney86il8
label|Collection of DSE records for Iliad 8 in British Library, Burney 86
text|image|surface
urn:cts:greekLit:tlg0012.tlg001.burney86:8.title|urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f073r@0.1703,0.3014,0.3983,0.03259|urn:cite2:hmt:burney86pages.v1:73r
urn:cts:greekLit:tlg0012.tlg001.burney86:8.1|urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f073r@0.1446,0.3405,0.4177,0.05148|urn:cite2:hmt:burney86pages.v1:73r
"""
```

# Building a library from CEX using customized relation sets

Two options:

1. map a datamodel
2. map a specific collection


```@example library
using CiteEXchange
using CitableLibrary
```



> In the following example, we've predefined a CEX string `relationscex`.
>
> (*ADD REFERENCE HERE TO FILES WHERE YOU CAN INSPECT THEM*)

## Create a custom type for relation sets

```@example library
using CitableObject
using CitableText
struct MyDSE
    psg::CtsUrn
    img::Cite2Urn
    surf::Cite2Urn
end
import CitableBase: CitableTrait
CitableTrait(::Type{MyDSE}) = CitableByCite2Urn()

struct MyDSESet
    v::Vector{MyDSE}
end
import CitableLibrary: CitableLibraryTrait
CitableLibraryTrait(::Type{MyDSESet}) = CitableLibraryCollection()

import CitableBase: CexSerializable
CexSerializable(::Type{MyDSESet}) = CexSerializable()

import CitableBase: fromcex
function fromcex(s::AbstractString, MyDSESet; delimiter = "|")
    srcblocks = blocksfortype("citerelationset", blocks(s))
    records = []
    for b in srcblocks
        #@warn("blocklines",b.lines)   
        for ln in  b.lines[4:end]
            #@warn("fromcex for MyDSESet: line", ln)
            parts = split(ln, delimiter)
            push!(records, MyDSE(CtsUrn(parts[1]), Cite2Urn(parts[2]), Cite2Urn(parts[3])))
        end
    end
    MyDSESet(records)
end
```

## Build from CEX source


Now we can build a library by mapping specific DSE relation sets to our new class. Each of the following three examples instantiates

## Mapping content with a containing URN

In this example, we map a collection-level URN to our class.  This will get both collections in our CEX, since they are both members of that collection.



```@example library
hmtdse = Cite2Urn("urn:cite2:hmt:dse.v1:")
tdict1 = Dict(hmtdse => MyDSESet)
lib1 = library(relationcex, tdict1)
```

## Mapping content with a data model

This time, we map a data model for DSE relation sets to our new class. This mapping will be applied to all relation sets that the source CEX defines as implementing the mapped models.

```@example library
modelurn = Cite2Urn("urn:cite2:cite:datamodels.v1:dsemodel")
tdict2 = Dict(modelurn => MyDSESet)
lib2 = library(relationcex, tdict2)
```


## Mapping content with a mixed dictionary


```@example library
vburn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil8")
tdict3 = Dict(vburn => MyDSESet, modelurn => MyDSESet)
lib3 = library(relationcex, tdict3)
```

## Including only some relations



```@example library
tdict4 = Dict(vburn => MyDSESet)
lib4 = library(relationcex, tdict4)
```