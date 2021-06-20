
@testset "Test reading from file" begin
    f = "assets/collectionblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    
end

@testset "Test reading data for block" begin
    f = "assets/relationblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 2
    
    relset = datafortype("citerelationset", blockgroup)
    @test length(relset) == 5
end