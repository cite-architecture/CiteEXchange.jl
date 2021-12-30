@testset "Test selecting blocks by type" begin
    f = joinpath("assets", "burneyex.cex")

    blockgroup = blocks(f, CiteEXchange.FileReader)
    catdata = data(blockgroup, "ctscatalog")
    @test length(catdata) == 2

    cexstr = read(f, String)
    catdatafromstring = data(cexstr, "ctscatalog")
    @test catdata == catdatafromstring

    catdatafromfile = data(f, CiteEXchange.FileReader, "ctscatalog")
    @test catdatafromfile == catdata

end


@testset "Test reading Blocks from different types of sources" begin
    f = joinpath("assets", "burneyex.cex")
    url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
    str = read(f, String)

    read1 = data(f, CiteEXchange.FileReader, "ctscatalog")
    read2 = data(url, CiteEXchange.UrlReader, "ctscatalog")
    read3 = data(str, CiteEXchange.StringReader, "ctscatalog")
    read4 = data(str, "ctscatalog")
    
    @test read1 == read2
    @test read1 == read3
    @test read1 == read4
end


