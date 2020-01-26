@testset "Metadata" begin
    m = Metadata(; a = 1, b= 2)

    @test iterate(m) == (Pair{Symbol,Any}(:a, 1), 2)
    @test iterate(m, 2)== (Pair{Symbol,Any}(:b, 2), 3)
    @test propertynames(m) == keys(m) == (:a, :b)
    @test getkey(m, :a, 1) == getkey(dictextension(m), :a, 1)

    @test getindex(m, :a) == 1

    @test get(m, :a, 3) == 1

    @test get!(m, :a, 3) == 1

    @test m.a == 1
    @test m.b == 2
    m.b = 3
    @test m.b == 3
    @test length(m) == 2
    delete!(m, :a)
    @test !haskey(m, :a)
    @test !isempty(m)
    empty!(m)
    @test isempty(m)

    @test FieldProperties.suppress(m) == ()
end

@testset "NoopMetadata" begin
    np = NoopMetadata()

    @test @inferred(isempty(np))
    @test @inferred(isnothing(get(np, :anything, nothing)))
    @test @inferred(length(np)) == 0
    @test @inferred(haskey(np, :anything)) == false
    @test @inferred(in(:anything, np)) == false
    @test @inferred(propertynames(np)) == ()
    @test @inferred(isnothing(iterate(np)))
    @test @inferred(isnothing(iterate(np, 1)))

    @test_throws ErrorException setindex!(np, 1, :bar)
end
