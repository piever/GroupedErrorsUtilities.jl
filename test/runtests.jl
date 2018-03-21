using JuliaDB, Compat, GroupedErrors, SputnikUtilities
using Compat.Test
school = loadtable(GroupedErrors.exampletable("school.csv"))

@testset "select" begin
    selectdiscrete = (SelectValues(:Minrty, ["Yes"], true), SelectValues(:Sx, ["Male"], false))
    selectcontinuous = (SelectInterval(:MAch, 6, 10),)
    expected = filter(i -> i.Minrty == "Yes" && i.Sx == "Male" && 6 <= i.MAch <= 10, school)
    @test SputnikUtilities.selectdata(school, selectdiscrete, selectcontinuous) == expected
    d2s  = Data2Select(school, selectdiscrete, selectcontinuous)
    @test SelectedData(d2s) == SelectedData(expected, (:Minrty,))
end
