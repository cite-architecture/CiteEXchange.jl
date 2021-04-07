
@testset "Test reading from file" begin
    f = "assets/collectionblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    
end