@with_kw struct Analysis{T, N}
    data::SelectedData{T, N}
    compute_error = nothing
    x = nothing
    y = nothing
    z = nothing
    xfunc = nothing
    yfunc = nothing
    zfunc = nothing
    axis_type = nothing
    smoother = nothing
    plot = nothing
    plot_kwargs = []
end

function Analysis(a::Analysis; kwargs...)
    d = Dict(kwargs)
    Analysis((get(d, f, getfield(a, f)) for f in fieldnames(a))...)
end

struct StatPlotsRecipe; end
struct PointByPoint; end
struct GroupedError; end

function analysistype(a)
    if a.compute_error !== nothing
        a.axis_type == :pointbypoint && return PointByPoint
        return GroupedError
    end
    (a.y in colnames(a.data.table) || a.y === nothing) ? StatPlotsRecipe : GroupedError
    #error("Analysis not supported")
end

process(a::Analysis) = process(analysistype(a), a)
