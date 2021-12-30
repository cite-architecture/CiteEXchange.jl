@testset "Test `Block` type equality, identification of blocktypes and cex conversion" begin
    blockgroup = blocks(joinpath("assets", "burneyex.cex"), CiteEXchange.FileReader)
    @test blocktypes(blockgroup) == ["ctscatalog", "ctsdata"]
    @test blockgroup[1] != blockgroup[2] 
    dupecatalog = blockgroup[1]
    @test blockgroup[1] == dupecatalog

    expectedcex = "!#ctscatalog\nurn|citationScheme|groupName|workTitle|versionLabel|exemplarLabel|online|language\nurn:cts:greekLit:tlg5026.burney86.hmt:|book, scholion|Scholia to the Iliad|Main scholia to the Iliad of British Library, Burney 86|British Library, Burney 86||true|grc\nurn:cts:greekLit:tlg5026.burney86int.hmt:|book,scholion,section|Scholia to the Iliad|Interior scholia of British Library, Burney 86|British Library, Burney 86||true|grc\n"
    @test CiteEXchange.blocktocex(dupecatalog)== expectedcex
end

