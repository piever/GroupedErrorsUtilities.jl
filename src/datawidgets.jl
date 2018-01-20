mutable struct DataWidgets
    df::IndexedTables.AbstractIndexedTable
    selectvalues::Vector{SelectValues}
    selectinterval::Vector{SelectInterval}
    plotvalues
    plotkwargs
    smoother
    splitting_var
    plot
end
