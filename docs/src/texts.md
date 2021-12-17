
```@setup library
# Change these to read from files in test/assets.

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

# Building a library from CEX using customized text corpora

> In the following example, we've predefined a CEX string `textcex`.
>
> (*ADD REFERENCE HERE TO FILES WHERE YOU CAN INSPECT THEM*)

Required Julia packages:

```@example library
using CiteEXchange
using CitableLibrary
```

## Define the custom types

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

## Build from CEX source

```@example library
banc = CtsUrn("urn:cts:citedemo:gburg.bancroft:")
tdict = Dict(banc => MyCorpus, "ctsdata" => MyCorpus)
lib = library(textcex, tdict)
```


