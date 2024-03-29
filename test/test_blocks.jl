@testset "Test `Block` type equality, identification of blocktypes and cex conversion" begin
    blockgroup = blocks(joinpath("assets", "burneyex.cex"), FileReader)
    @test blocktypes(blockgroup) == ["ctscatalog", "ctsdata"]
    @test blockgroup[1] != blockgroup[2] 
    dupecatalog = blockgroup[1]
    @test blockgroup[1] == dupecatalog

    expectedcex = """!#ctscatalog
urn|citationScheme|groupName|workTitle|versionLabel|exemplarLabel|online|language
urn:cts:greekLit:tlg5026.burney86.hmt:|book, scholion|Scholia to the Iliad|Main scholia to the Iliad of British Library, Burney 86|British Library, Burney 86||true|grc
urn:cts:greekLit:tlg5026.burney86int.hmt:|book,scholion,section|Scholia to the Iliad|Interior scholia of British Library, Burney 86|British Library, Burney 86||true|grc
"""
    @test CiteEXchange.blocktocex(dupecatalog) == expectedcex
end


@testset "Test filtering blocks by type" begin
    blockgroup = blocks(joinpath("assets", "burneyex.cex"), FileReader)
    catalogs = blocks(blockgroup, "ctscatalog")
    @test length(catalogs) == 1
end

@testset "Test reading Blocks from different types of sources" begin
    f = joinpath("assets", "burneyex.cex")
    url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
    str = read(f, String)

    read1 = blocks(f, FileReader)
    read2 = blocks(url, UrlReader)
    read3 = blocks(str, StringReader)
    read4 = blocks(str)
    
    @test read1 == read2
    @test read1 == read3
    @test read1 == read4
end


@testset "Test filtering blocks by type when reading from different resources" begin
    f = joinpath("assets", "burneyex.cex")
    url = "https://raw.githubusercontent.com/cite-architecture/CiteEXchange.jl/main/test/assets/burneyex.cex"
    str = read(f, String)

    read1 = blocks(f, FileReader, "ctscatalog")
    read2 = blocks(url, UrlReader, "ctscatalog")
    read3 = blocks(str, StringReader, "ctscatalog")
    read4 = blocks(str, "ctscatalog")

    @test read1 == read2
    @test read1 == read3
    @test read1 == read4
end
