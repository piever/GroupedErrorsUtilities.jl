module SputnikUtilities

using GroupedErrors
using JuliaDB, IndexedTables

import IndexedTables: AbstractIndexedTable

export Data2Select, SelectedData
export SelectInterval, SelectValues
export Analysis, process

include("selectdata.jl")
include("process.jl")
include(joinpath("techniques", "statplotsrecipe.jl"))

end # module
