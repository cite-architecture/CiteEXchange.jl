
@testset "Test reading from file" begin
    f = "assets/collectionblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    
end

@testset "Test reading data for block" begin
    f = "assets/relationblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    
    rawrelset = datafortype("citerelationset", blockgroup)
    @test length(rawrelset) == 10

    urn = Cite2Urn("urn:cite2:hmt:dse.v1:")
    relationdata = relations(blockgroup, urn)
    @test length(relationdata) == 6

end

@testset "Test reading from URL" begin
    url = "https://raw.githubusercontent.com/homermultitext/hmt-archive/master/archive/codices/vapages.cex"
    blockgroup = CiteEXchange.fromurl(url)
    @test length(blockgroup) == 4
end


