
@testset "Test recognizing block types" begin
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
end
