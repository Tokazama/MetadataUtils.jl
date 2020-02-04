using FieldProperties, Test, Documenter

struct TestStruct
    p1
    p2
    p3
    p4
    p5
end

@properties TestStruct begin
    prop1(self) => :p1
    prop2(self) => :p2
    prop3(self) => :p3
    prop4(self) => :p4
    Any(self) => :p5
    Any!(self, val) => :p5
end

t = TestStruct(1,2,3,4,5)

@test propertynames(t) == (:prop1,:prop2,:prop3,:prop4)

FieldProperties._fxnname(FieldProperties.Description{values}()) == "description(values)"

x = rand(4,4)
@test @inferred(calmin(x)) == minimum(x)
@test @inferred(calmax(x)) == maximum(x)

@test proptype(calmin, x) <: Float64
@test proptype(calmax, x) <: Float64

include("metadata_tests.jl")

@testset "FieldProperties docs" begin
    doctest(FieldProperties; manual=false)
end

@test_throws ErrorException("Argument referring to value is inconsistent, got x and y.") FieldProperties.check_args(:x, :y)

@test_throws ErrorException("Argument referring to self is inconsistent, got w and z.") FieldProperties.check_args(:w, :z, :x, :y)
