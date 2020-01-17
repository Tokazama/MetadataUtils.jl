"""
    FieldProperties

`FieldProperties` provides an interface for creating method/property based
APIs that can be flexibly incorporated into Julia structures. This is predominantly
accomplished through the use of [`@defproperty`](@ref) and [`@assignprops`](@ref).
These macros help in the creation of methods and mapping them to the fields of a
concrete type. Additionally, customization is provided through the use of
[`propconvert`](@ref), [`propdefault`](@ref), and [`proptype`](@ref) which can
be overloaded to provide unique functionality given the unique combination of a
property and type.
"""
module FieldProperties

using Markdown

export
    # Types
    AbstractMetadata,
    DictExtension,
    NotProperty,
    NoopMetadata,
    NestedProperty,
    AbstractProperty,
    # Macros
    @defprop,
    @assignprops,
    # methods
    calmax,
    calmax!,
    calmin,
    calmin!,
    description,
    description!,
    dictextension,
    propconvert,
    propdefault,
    propdoc,
    propname,
    proptype,
    status,
    status!,
    modality,
    modality!

include("defprop.jl")
include("assignprops.jl")
include("properties.jl")
include("dictextension.jl")
include("nested_properties.jl")
include("getter.jl")
include("setter.jl")
include("general.jl")
include("metadata.jl")

end
