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

function selectdata(dwp)
    f = function(i)
        all(getfield(i, s.name) in s.values for s in dwp.selectvalues) &&
        all(s.min <= getfield(i, s.name) <= s.max for s in dwp.selectinterval)
    end
    filter(f, dwp.df)
end
