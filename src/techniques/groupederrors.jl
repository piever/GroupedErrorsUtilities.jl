function compute_error(s, cpt_err)
    if cpt_err[1] == :across
        GroupedErrors._across(s, cpt_err[2])
    elseif cpt_err[1] == :bootstrap
        GroupedErrors._bootstrap(s, cpt_err[2])
    else
        error("Compute error $cpt_err not supported")
    end
end

compute_error(s, ::Void) = s

function smoothing_kwargs(a::Analysis)
    a.axis_type != :continuous && return []
    a.y in colnames(a.data.table) && return [(:span, (a.smoother+1.0)/100)]
    a.y in [:density, :hazard] && return [(:bandwidth, (a.smoother+1.0)*std(column(a.data.table, a.x))/200)]
    return []
end

function process(::Type{GroupedError}, a::Analysis)
    s = GroupedErrors.ColumnSelector(a.data.table)
    s = GroupedErrors._splitby(s, [a.data.splitby...])
    s = compute_error(s, a.compute_error)
    maybe_nbins = a.axis_type == :binned ? (round(Int64, 101-a.smoother),) : ()
    s = GroupedErrors._x(s, a.x, a.axis_type, maybe_nbins...)
    y = a.y in colnames(a.data.table) ? (:locreg, a.y) : (a.y,)
    s = GroupedErrors._y(s, y...; smoothing_kwargs(a)...)
    @plot s a.plot()
end

#
# function process(::Type{PointByPoint}, a::Analysis)
#
#
#         #xval, yval, line, axis_type, compute_error, dataperpoint =
#         # getfield.(plotvalues, :chosen_value)
#         #extra_kwargs = get_kwargs(shared.plotkwargs.value)
#         x_info, y_info = a.x_info, a.y_info
#         xfunc = get_func(x_info)
#         yfunc = get_func(y_info)
#         isrecipe =
#         isgroupapply = !isrecipe && (a.axis_type != :pointbypoint)
#         xlabel, ylabel = xval, yval
#         #plot_func = (args...; kwargs...) -> plot_functions[Symbol(line)][in_place ? 2 : 1](args...;
#         #            xlabel = xlabel, ylabel = ylabel, kwargs..., extra_kwargs...)
#         group_cols = [Symbol(col.name) for col in selectlist if col.split]
#
#         maybe_nbins = a.axis_type == :binned ? (round(Int64, 101-a.smoother),) : ()
#
#         s = GroupedErrors.ColumnSelector(selectdata) |>
#         s = GroupedErrors._splitby(s, [a.data.splitby...])
#         if (a.axis_type == :pointbypoint) || isrecipe
#             if !isrecipe && ('=' in dataperpoint)
#                 s = GroupedErrors._across(s, Symbol(split(dataperpoint, '=')[2]))
#                 if check_equality() && (':' in shared.splitting_var.chosen_value)
#                     splitting_var = Symbol(split(shared.splitting_var.chosen_value, ':')[2])
#                     s = GroupedErrors._compare(s, splitting_var)
#                 end
#                 s = GroupedErrors._x(s, Symbol(xval), xfunc)
#                 s = GroupedErrors._y(s, Symbol(yval), yfunc)
#             else isrecipe
#                 s = GroupedErrors._x(s, Symbol(xval))
#                 s = GroupedErrors._y(s, Symbol(yval))
#             end
#         else
#             s = compute_error(s)
#             s = GroupedErrors._x(s, a.x, a.axis_type, maybe_nbins...)
#             if  a.axis_type == :continuous
#                 if a.y in colnames(selectdata)
#                     s = GroupedErrors._y(s, :locreg, a.y, span = a.smoother+1.0)/100)
#                 elseif a.y in [:density, :hazard]
#                     s = GroupedErrors._y(s, a.y, bandwidth = (a.smoother+1.0)*std(column(selectdata, a.x))/200)
#                 else
#                     s = GroupedErrors._y(s, a.y)
#                 end
#             else
#                 s = GroupedErrors._x(s, a.x, a.xfunc)
#                 if a.y in colnames(selectdata)
#                     s = GroupedErrors._y(s, :locreg, a.y, estimator = a.yfunc)
#                 else
#                     s = GroupedErrors._y(s, a.y)
#                 end
#             end
#         end
#         s
#         #shared.plt = Symbol(line) == :plot ? @plot(s, plot_func(), :ribbon) : @plot(s, plot_func())
#         #get(s.kw, :compare, false) && Plots.abline!(shared.plt, 1, 0, legend = false)
#     end
