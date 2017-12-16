"""
    NelsonAalen

An immutable type containing cumulative hazard function estimates computed
using the Kaplan-Meier method.
The type has the following fields:

* `times`: Distinct event times
* `nevents`: Number of observed events at each time
* `ncensor`: Number of right censored events at each time
* `natrisk`: Size of the risk set at each time
* `chaz`: Estimate of the cumulative hazard at each time
* `stderr`: Standard error of the cumulative hazard
Use `fit(NelsonAalen, ...)` to compute the estimates and construct
this type.
"""
struct NelsonAalen{T<:Real} <: NonparametricEstimator
    times::Vector{T}
    nevents::Vector{Int}
    ncensor::Vector{Int}
    natrisk::Vector{Int}
    chaz::Vector{Float64}
    stderr::Vector{Float64}
end

estimator_start(::Type{NelsonAalen}) = 0.0  # Estimator starting point
stderr_start(::Type{NelsonAalen}) = 0.0 # StdErr starting point

estimator_update(::Type{NelsonAalen}, es, dᵢ, nᵢ) = es + dᵢ / nᵢ # Estimator update rule
stderr_update(::Type{NelsonAalen}, gw, dᵢ, nᵢ) = gw + dᵢ / (nᵢ * (nᵢ - dᵢ)) # StdErr update rule