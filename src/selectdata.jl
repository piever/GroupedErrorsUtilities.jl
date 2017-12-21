struct SelectList
    name
    values
end

struct SelectValues
    name
    values
end

function selectdata(dwp)
    d = Dict()
    for s in dwp.selectlist
        d[Symbol(s.name)] = t -> t in s.values
    end
    for s in dwp.selectvalues
        d[Symbol(s.name)] =
            (t -> (s.values[1] <= t <= s.values[2]))
    end
    choose_data(dwp.df, d)
end

function choose_data(df, d)
    f = i -> all(val(getfield(i, key)) for (key, val) in d)
    filter(f, df)
end
