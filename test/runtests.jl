using JuliaDB, Compat
using Compat.Test
school = loadtable(GroupedErrors.exampletable("school.csv"))

selectvalues = [SelectValues(:Minrty, ["Yes"], false), SelectValues(:Sx, ["Male"], false)]
selectinterval = [SelectInterval(:MAch, 6, 10)]

testdw = DataWidgets(school, selectvalues, selectinterval, 0, 0, 0, 0, 0)
@test selectdata(testdw) == filter(i -> i.Minrty == "Yes" && i.Sx == "Male" && 6 <= i.MAch <= 10, school)
