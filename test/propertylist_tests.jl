@testset "PropertyList" begin
    m = PropertyList(; a = 1, b= 2)

    @test iterate(m) == (Pair{Symbol,Any}(:a, 1), 2)
    @test iterate(m, 2) == (Pair{Symbol,Any}(:b, 2), 3)
    @test propertynames(m) == Tuple(keys(m)) == (:a, :b)
    @test getkey(m, :a, 1) == getkey(FieldProperties.proplist(m), :a, 1)

    #= TODO delete these once we know that they are still covered by docs
    @test getindex(m, :a) == 1

    @test get(m, :a, 3) == 1

    @test get!(m, :a, 3) == 1

    @test m.a == 1
    m[:a] = 2
    @test m.a == 2

    @test m.b == 2
    m.b = 3
    @test m.b == 3
    =#
    @test length(m) == 2
    delete!(m, :a)
    @test !haskey(m, :a)
    @test !isempty(m)
    empty!(m)
    @test isempty(m)

    @test FieldProperties.suppress(m) == ()
end

@testset "NoopPropertyList" begin
    np = NoopPropertyList()

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

m = PropertyList()
m.foo = 1
m.bar = 2
m.suppress = (:foo,)

@testset "Print PropertyList" begin
   io = IOBuffer()
    show(io, m)

    x="""
    PropertyList{Dict{Symbol,Any}} with 3 entries
        bar: 2
        suppress: (:foo,)
        foo: <suppressed>"""

    str = String(take!(io))
    @test str == x
end

description!(m, "foo")
@test description(m) == "foo"

description!(m, rand(UInt8, 8))
@test isa(description(m), String)
