@testset "Test functions for reading CEX data" begin
    cexstring = """
    #!ctsdata
urn:cts:citedemo:gburg.bancroft.v1:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
urn:cts:citedemo:gburg.bancroft.v1:2|Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting-place for those who here gave their lives, that that nation might live. It is altogether fitting and proper that we should do this.
urn:cts:citedemo:gburg.bancroft.v1:3|But, in a larger sense, we can not dedicate, we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced.
urn:cts:citedemo:gburg.bancroft.v1:4|It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they here gave the last full measure of devotion - that we here highly resolve that these dead shall not have died in vain that this nation, under God, shall have a new birth of freedom, and that government of the people, by the people, for the people, shall not perish from the earth.
"""
cexfile = "assets/textblocks.cex"
cexurl = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/textblocks.cex"

    @test blocks(cexfile, FileReader) == blocks(cexurl, UrlReader)
    @test blocks(cexstring) == blocks(cexstring, StringReader)
    @test blocks(cexstring) == blocks(cexfile, FileReader)
end