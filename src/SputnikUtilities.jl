module SputnikUtilities

using GroupedErrors
using JuliaDB, IndexedTables
using Parameters

import IndexedTables: AbstractIndexedTable

export Data2Select, SelectedData
export SelectInterval, SelectValues
export Analysis, process

include("selectdata.jl")
include("process.jl")
include(joinpath("techniques", "statplotsrecipe.jl"))
include(joinpath("techniques", "groupederrors.jl"))

end # module
