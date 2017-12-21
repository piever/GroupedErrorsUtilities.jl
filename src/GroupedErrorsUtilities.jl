module GroupedErrorsUtilities

using GroupedErrors
using JuliaDB

export DataWidgetsPlot
export SelectList, SelectValues
export selectdata

include("buildplot.jl")
include("selectdata.jl")

end # module
