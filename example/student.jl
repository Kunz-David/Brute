# student.jl
module student

Base.@kwdef struct Gauss{T<:Real}
    μ::T = 0
    σ::T = 1

    function Gauss(μ::Real, σ::Real)
        σ > 0 || error("the variance `σ` must be positive")
        pars = promote(μ, σ)
        return new{eltype(pars)}(pars...)
    end
end

pdf_mistake(d::Gauss, x::Real) = exp(-1 / 2 * ((x - d.μ) / d.σ)^2) / (d.σ * sqrt(2 * π)) + 1

pdf(d::Gauss, x::Real) = exp(-1 / 2 * ((x - d.μ) / d.σ)^2) / (d.σ * sqrt(2 * π))


end