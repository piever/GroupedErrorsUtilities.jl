module SputnikUtilities

using GroupedErrors
using JuliaDB, IndexedTables

import IndexedTables: AbstractIndexedTable

export Data2Select, SelectedData
export SelectInterval, SelectValues
export selectdata

include("selectdata.jl")

end # module
