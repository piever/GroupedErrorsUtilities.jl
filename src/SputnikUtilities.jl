module SputnikUtilities

using GroupedErrors
using JuliaDB, IndexedTables
using Parameters

import IndexedTables: AbstractIndexedTable

export Data2Select, SelectedData
export SelectPredicate, SelectValues
export Analysis, process

include("selectdata.jl")
include("process.jl")
include(joinpath("techniques", "statplotsrecipe.jl"))
include(joinpath("techniques", "groupederrors.jl"))
include(joinpath("techniques", "table.jl"))

end # module
