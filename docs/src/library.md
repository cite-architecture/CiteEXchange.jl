

# Instantiating citable content from CEX source

## Overview

Objects of individual Julia types implementing the `CitableBase` package's `CexSerializable` trait can be constructed with the `fromcex` function.  The `CiteEXchange` package provides an additional `library` function that can construct an entire `CiteLibrary` from CEX source.  To do this, you need to include a `Dict` mapping the contents of your CEX content to Julia data types (each of which implements `CexSerializable`).  Keys to the `Dict` may be:

- a CEX block heading (e.g., `ctsdata`)
- a `CtsUrn` for text copora
- a `Cite2Urn` for cite collections
- a `Cite2Urn` for relation sets
- a `Cite2Urn` for data models

You may intermix these freely. The `library` function will apply the most specific mapping in each case.  For example, you could use a `CtsUrn` to map one specific corpus to a particular Julia type (perhaps for language-specific processing, for example), and map the `ctsdata` block heading to handle all other text corpora.  

Note that all URNs are applied using `urncontains`, so you can map groups of collections, text corpora, relation sets or data models with a single URN.  



Required Julia packages:

```@example library
using CiteEXchange
using CitableLibrary
```
