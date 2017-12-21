using GroupedErrorsUtilities
using Base.Test
school = Dagger.load(joinpath(Pkg.dir("GroupedErrorsUtilities", "test", "tables"), "school"))

selectlist = [SelectList(:Minrty, ["Yes"]), SelectList(:Sx, ["Male"])]

selectvalues = [SelectValues(:MAch, [6, 10])]

testdwp = DataWidgetsPlot(school, selectvalues, selectlist, 0, 0, 0, 0, 0)

@test selectdata(testdwp) ==
    Dagger.load(joinpath(Pkg.dir("GroupedErrorsUtilities", "test", "tables"), "test1"))
