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

struct Data2Select{T<:AbstractIndexedTable, N1, N2}
    table::T
    discrete::NTuple{N1, SelectValues}
    continuous::NTuple{N2, SelectInterval}
end

struct SelectedData{T<:AbstractIndexedTable, N}
    table::T
    splitby::NTuple{N, Symbol}
end

SelectedData(d2s::Data2Select) =
    SelectedData(selectdata(d2s.table, d2s.discrete, d2s.continuous), Tuple(i.name for i in d2s.discrete if i.split))

Base.:(==)(a::SelectedData, b::SelectedData) = (a.table == b.table) && (a.splitby == b.splitby)

function selectdata(df, discrete, continuous)
    f = function(i)
        all(getfield(i, s.name) in s.values for s in discrete) &&
        all(s.min <= getfield(i, s.name) <= s.max for s in continuous)
    end
    filter(f, df)
end
