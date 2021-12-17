
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


textcex = """#!ctsdata
urn:cts:citedemo:gburg.bancroft.v2:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.bancroft.v2:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting-place for those who here gave their lives, that that nation might live. It is altogether fitting and proper that we should do this.
urn:cts:citedemo:gburg.bancroft.v2:3|But, in a larger sense, we can not dedicate, we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced.
urn:cts:citedemo:gburg.bancroft.v2:4|It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they here gave the last full measure of devotion - that we here highly resolve that these dead shall not have died in vain that this nation, under God, shall have a new birth of freedom, and that government of the people, by the people, for the people, shall not perish from the earth.
urn:cts:citedemo:gburg.bliss.v2:1|Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.bliss.v2:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.
urn:cts:citedemo:gburg.bliss.v2:3|But, in a larger sense, we can not dedicate -- we can not consecrate -- we can not hallow -- this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced.
urn:cts:citedemo:gburg.bliss.v2:4|It is rather for us to be here dedicated to the great task remaining before us -- that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion -- that we here highly resolve that these dead shall not have died in vain -- that this nation, under God, shall have a new birth of freedom -- and that government of the people, by the people, for the people, shall not perish from the earth.
urn:cts:citedemo:gburg.everett.v2:1|Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.everett.v2:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting-place for those who here gave their lives, that that nation might live. It is altogether fitting and proper that we should do this.
urn:cts:citedemo:gburg.everett.v2:3|But, in a larger sense, we can not dedicate, we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here.
urn:cts:citedemo:gburg.everett.v2:4|It is for us, the living, rather, to be dedicated here to the unfinished work which they who fought here, have, thus far, so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they here gave the last full measure of devotion that we here highly resolve that these dead shall not have died in vain that this nation, under God, shall have a new birth of freedom and that government of the people, by the people, for the people, shall not perish from the earth.
urn:cts:citedemo:gburg.hay.v2:1|Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.hay.v2:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met here on a great battlefield of that war. We have come to dedicate a portion of it, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.
urn:cts:citedemo:gburg.hay.v2:3|But in a larger sense, we can not dedicate we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember, what we say here, but can never forget what they did here.
urn:cts:citedemo:gburg.hay.v2:4|It is for us, the living, rather to be dedicated here to the unfinished work which they have, thus far, so nobly carried on. It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion that we here highly resolve that these dead shall not have died in vain; that this nation shall have a new birth of freedom; and that this government of the people, by the people, for the people, shall not perish from the earth.
urn:cts:citedemo:gburg.nicolay.v2:1|Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.nicolay.v2:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle field of that war. We come to dedicate a portion of it, as a final resting place for those who died here, that the nation might live. This we may, in all propriety do.
urn:cts:citedemo:gburg.nicolay.v2:3|But, in a larger sense, we can not dedicate we can not consecrate we can not hallow, this ground The brave men, living and dead, who struggled here, have hallowed it, far above our poor power to add or detract. The world will little note, nor long remember what we say here; while it can never forget what they did here.
urn:cts:citedemo:gburg.nicolay.v2:4|It is rather for us, the living, we here be dedicated to the great task remaining before us that, from these honored dead we take increased devotion to that cause for which they here, gave the last full measure of devotion that we here highly resolve these dead shall not have died in vain; that the nation, shall have a new birth of freedom, and that government of the people, by the people, for the people, shall not perish from the earth.
"""
```

# Instantiating citable content from CEX source

## Overview

To construct a library from a string of CEX data, you need to map the contents of your CEX source to Julia data types.  You may identify contents by:

- a CEX block heading (e.g., `ctsdata`)
- a `CtsUrn` for text copora
- a `Cite2Urn` for cite collections
- a `Cite2Urn` for relation sets
- a `Cite2Urn` for data models

Note that URNs apply `urncontains` so you can map groups of collections, text corpora, relation sets or data models with a single URN.

> In the following examples, we've predefined a couple of CEX strings under the hood: `textcex` and `relationscex`.
>
> (*ADD REFERENCE HERE TO FILES WHERE YOU CAN INSPECT THEM*)


Required Julia packages:

```@example library
using CiteEXchange
using CitableLibrary
```

## A library with text corpora

### Create a custom type for text corpora

```@example library
using CitableText
struct MyText
    u::CtsUrn
    t::AbstractString
end
import CitableBase: CitableTrait
CitableTrait(::Type{MyText}) = CitableByCtsUrn()

struct MyCorpus
    v::Vector{MyText}
end
import CitableLibrary: CitableLibraryTrait
CitableLibraryTrait(::Type{MyCorpus}) = CitableLibraryCollection()


import CitableBase: CexSerializable
CexSerializable(::Type{MyCorpus}) = CexSerializable()


import CitableBase: fromcex
function fromcex(s::AbstractString, MyCorpus; delimiter = "|")
    srcblocks = blocksfortype("ctsdata", blocks(s))
    psgs = []
    for b in srcblocks
        for ln in  b.lines
            parts = split(ln, delimiter)
            push!(psgs, MyText(CtsUrn(parts[1]), parts[2]))
        end
    end
    MyCorpus(psgs)
end
```

### Build from CEX source

```@example library
banc = CtsUrn("urn:cts:citedemo:gburg.bancroft:")
tdict = Dict(banc => MyCorpus, "ctsdata" => MyCorpus)
lib = library(textcex, tdict)
```


## A library with relation sets

Two options:

1. map a datamodel
2. map a specific collection

### Create a custom type for relation sets

```@example library
using CitableObject
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


function fromcex(s::AbstractString, MyDSESet; delimiter = "|")
    srcblocks = blocksfortype("citerelationset", blocks(s))
    records = []
    for b in srcblocks
        for ln in  b.lines[4:end]
            parts = split(ln, delimiter)
            push!(records, MyDSE(CtsUrn(parts[1]), Cite2Urn(parts[2]), Cite2Urn(parts[3])))
        end
    end
    MyDSESet(records)
end
```

### Build from CEX source



```@example library
hmtdse = Cite2Urn("urn:cite2:hmt:dse.v1:")
tdict2 = Dict(hmtdse => MyDSESet)
lib = library(relationcex, tdict2)
```


## Under the hood

Under the hood, here are some things that happen.

```@example library
textv = CiteEXchange.instantiatetexts(textcex, tdict)
```

```@example library
fromcex(relationcex, MyDSESet)
```