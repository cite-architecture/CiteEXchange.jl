

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
