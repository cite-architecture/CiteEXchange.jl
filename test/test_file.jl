
@testset "Test reading from file" begin
    f = "assets/collectionblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    @test isa(blockgroup, Vector{CiteEXchange.Block})
    
end

@testset "Test reading data for block" begin
    f = "assets/relationblocks.cex"
    blockgroup = CiteEXchange.fromfile(f)
    @test length(blockgroup) == 3
    
    rawrelset = relationsdata(blockgroup, Cite2Urn("urn:cite2:hmt:dse.v1:msBil8"))
    @test eltype(rawrelset) <: AbstractString
    @test length(rawrelset) == 3

    urn = Cite2Urn("urn:cite2:hmt:dse.v1:")
    reldata = relationsdata(blockgroup, urn)
    @test eltype(reldata) <: AbstractString
    @test length(reldata) == 6

end

@testset "Test reading from URL" begin
    url = "https://raw.githubusercontent.com/homermultitext/hmt-archive/master/archive/codices/vapages.cex"
    blockgroup = CiteEXchange.fromurl(url)
    @test length(blockgroup) == 4
end


