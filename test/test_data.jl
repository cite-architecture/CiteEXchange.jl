@testset "Test selecting blocks by type" begin
    f = joinpath("assets", "burneyex.cex")

    blockgroup = blocks(joinpath("assets", "burneyex.cex"), CiteEXchange.FileReader)
    catdata = data(blockgroup, "ctscatalog")
    @test length(catdata) == 2

    cexstr = read(f, String)
    catdatafromstring = data(cexstr, "ctscatalog")
    @test catdata == catdatafromstring

    catdatafromfile = data(f, CiteEXchange.FileReader, "ctscatalog")
    @test catdatafromfile == catdata

end