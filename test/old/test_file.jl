
@testset "Test reading from file" begin
    f = "assets/collectionblocks.cex"
    blockgroup = CiteEXchange.blocks(f, FileReader)
    @test length(blockgroup) == 3
    @test isa(blockgroup, Vector{CiteEXchange.Block})
    
end

@testset "Test reading data for block" begin
    f = "assets/relationblocks.cex"
    blockgroup = CiteEXchange.blocks(f, FileReader)
    @test length(blockgroup) == 4
    
    
    rawrelset = nothing # relationsdata(blockgroup, Cite2Urn("urn:cite2:hmt:dse.v1:msBil8"))
    @test_broken eltype(rawrelset) <: AbstractString
    @test_broken length(rawrelset) == 3

    urn = nothing # Cite2Urn("urn:cite2:hmt:dse.v1:")
    #reldata = relationsdata(blockgroup, urn)
    #@test_broken eltype(reldata) <: AbstractString
    #@test_broken length(reldata) == 6

end

@testset "Test reading from URL" begin
    url = "https://raw.githubusercontent.com/homermultitext/hmt-archive/master/archive/codices/vapages.cex"
    blockgroup = CiteEXchange.blocks(url, UrlReader)
    @test length(blockgroup) == 4
end


