struct Analysis{T, N}
    data::SelectedData{T, N}
    compute_error
    x
    y
    z
    xfunc
    yfunc
    zfunc
    axis_type
    smoother
    plot
    plot_kwargs
end

function Analysis(s::SelectedData; kwargs...)
    a = Analysis(s, fill(nothing, length(fieldnames(Analysis))-1)...)
    Analysis(a; kwargs...)
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
    !(a.plot in [:plot, :scatter, :groupedbar]) && return StatPlotsRecipe
    error("Analysis not supported")
end

process(a::Analysis) = process(analysistype(a), a)
