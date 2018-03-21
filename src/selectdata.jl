struct SelectValues{T}
    name::Symbol
    values::Vector{T}
    split::Bool
end

struct SelectInterval{T}
    name::Symbol
    min::T
    max::T
end

struct Data2Select{T<:AbstractIndexedTable}
    df::T
    discrete
    continuous
end

struct SelectedData{T<:AbstractIndexedTable, N}
    df::T
    splitby::NTuple{N, Symbol}
end

selectdata(d2s::Data2Select) =
    SelectedData(selectdata(d2s.df, d2s.discrete, d2s.continuous), Tuple(i.name for i in d2s.discrete if i.split))

function selectdata(df, discrete, continuous)
    f = function(i)
        all(getfield(i, s.name) in s.values for s in discrete) &&
        all(s.min <= getfield(i, s.name) <= s.max for s in continuous)
    end
    filter(f, df)
end
