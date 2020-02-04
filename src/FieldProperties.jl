"""
    FieldProperties

`FieldProperties` provides an interface for creating method/property based
APIs that can be flexibly incorporated into Julia structures. This is predominantly
accomplished through the use of [`@defprop`](@ref) and [`@properties`](@ref).
These macros help in the creation of methods and mapping them to the fields of a
concrete type.
"""
module FieldProperties

using Markdown

export
    # Types
    AbstractMetadata,
    Metadata,
    NoopMetadata,
    AbstractProperty,
    # Macros
    @defprop,
    @properties,
    propconvert,
    proptype,
    # general properties
    description,
    description!,
    description_list,
    status,
    status!,
    modality,
    modality!,
    name,
    name!,
    label,
    label!,
    calmax,
    calmax!,
    calmin,
    calmin!


include("abstractproperty.jl")
include("macro_utilities.jl")
include("defprop.jl")

include("documentation.jl")
include("properties.jl")
include("general.jl")
include("metadata.jl")

end
