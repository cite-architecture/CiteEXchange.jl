
@testset "Test CEX parsing" begin
    cex = """
    
#!citecollections
URN#Description#Labelling property#Ordering property#License
urn:cite2:hmt:va_signs.v1:#Occurrences of Aristarchan critical signs in the Veentus A manuscript#urn:cite2:hmt:va_signs.v1.label:#urn:cite2:hmt:va_signs.v1.sequence:#CC-attribution-share-alike

#!citeproperties
Property#Label#Type#Authority list
urn:cite2:hmt:va_signs.v1.urn:#URN#Cite2Urn#
urn:cite2:hmt:va_signs.v1.label:#Name#String#
urn:cite2:hmt:va_signs.v1.passage:#Iliad line#CtsUrn#
urn:cite2:hmt:va_signs.v1.critsign:#Critical sign#Cite2Urn#
urn:cite2:hmt:va_signs.v1.sequence:#Sequence#Number#

#!citedata
urn#label#passage#critsign#sequence
urn:cite2:hmt:va_signs.v1:cs0#diple on Iliad 1.2#urn:cts:greekLit:tlg0012.tlg001.msA:1.2#urn:cite2:hmt:critsigns.v1:diple#0
"""    
    blks = blocks(cex)
    @test length(blks) == 3
    @test blocktypes(blks) == ["citecollections", "citeproperties", "citedata"]
end


@testset "Test bad input" begin
    cex = "#!nontype\nCEX data\n"
    blks = blocks(cex)
    @test isempty(blks)
end

@testset "Test supporting comments" begin
    cex = """#!ctscatalog

    // Complete catalog for a single citable text: an edition
    // of scholia in a manuscript of the *Iliad*.  There is no
    // specific exemplar of this edition.
    
    urn#citationScheme#groupName#workTitle#versionLabel#exemplarLabel#online#lang
    urn:cts:greekLit:tlg5026.msA.hmt:#book,comment,section#Scholia Vetera in Iliadem#Main scholia to Venetus A#Homer Multitext##true#grc
    """
    blockgroup = blocks(cex)
    expected = [
        "urn#citationScheme#groupName#workTitle#versionLabel#exemplarLabel#online#lang",
        "urn:cts:greekLit:tlg5026.msA.hmt:#book,comment,section#Scholia Vetera in Iliadem#Main scholia to Venetus A#Homer Multitext##true#grc"
    ]
    blockgroup[1].lines == expected
end

@testset "Test collecting data from group" begin
    cex = """
    
#!citecollections
URN#Description#Labelling property#Ordering property#License
urn:cite2:hmt:va_signs.v1:#Occurrences of Aristarchan critical signs in the Veentus A manuscript#urn:cite2:hmt:va_signs.v1.label:#urn:cite2:hmt:va_signs.v1.sequence:#CC-attribution-share-alike

#!citeproperties
Property#Label#Type#Authority list
urn:cite2:hmt:va_signs.v1.urn:#URN#Cite2Urn#
urn:cite2:hmt:va_signs.v1.label:#Name#String#
urn:cite2:hmt:va_signs.v1.passage:#Iliad line#CtsUrn#
urn:cite2:hmt:va_signs.v1.critsign:#Critical sign#Cite2Urn#
urn:cite2:hmt:va_signs.v1.sequence:#Sequence#Number#

#!citedata
urn#label#passage#critsign#sequence
urn:cite2:hmt:va_signs.v1:cs0#diple on Iliad 1.2#urn:cts:greekLit:tlg0012.tlg001.msA:1.2#urn:cite2:hmt:critsigns.v1:diple#0
""" 
    blockgroup = blocks(cex)
    data = datafortype("citedata", blockgroup)
    expected = [
        "urn#label#passage#critsign#sequence",
        "urn:cite2:hmt:va_signs.v1:cs0#diple on Iliad 1.2#urn:cts:greekLit:tlg0012.tlg001.msA:1.2#urn:cite2:hmt:critsigns.v1:diple#0"
        ]
    @test data == expected
end


@testset "Test versioning" begin
    cex = """
#!cexversion

// note: currently using version 3.1
3.1

#!citedata
urn#label#passage#critsign#sequence
urn:cite2:hmt:va_signs.v1:cs0#diple on Iliad 1.2#urn:cts:greekLit:tlg0012.tlg001.msA:1.2#urn:cite2:hmt:critsigns.v1:diple#0
"""
    blkgroup = blocks(cex)
    @test cexversion(blkgroup) == "3.1"
end


@testset "Test CTS data block without header" begin
    f = "assets/textblocks.cex"
    blks = CiteEXchange.fromfile(f)
    datalines = datafortype("ctsdata", blks)
    @test length(datalines) == 4
end