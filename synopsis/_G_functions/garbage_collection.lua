-------------------------------
--     collectgarbage
-------------------------------
--[[
function collectgarbage(opt?: "collect")

    DANGER: GC runs automatically!!! No need to use it in regular scripts.

    This function is a generic interface to the garbage collector. It performs
    different functions according to its first argument, opt:

* `"collect"`: performs a full garbage-collection cycle. This is the default option.

* `"stop"`: stops the garbage collector.

* `"restart"`: restarts the garbage collector.

* `"count"`: returns the total memory in use by Lua (in Kbytes).

* `"step"`: performs a garbage-collection step. The step "size" is controlled
   by arg (larger values mean more steps) in a non-specified way. 
   If you want to control the step size you must experimentally tune the value of arg.
   Returns true if the step finished a collection cycle.

* `"setpause"`: sets arg as the new value for the pause of the collector
   (see [§2.10](http://www.lua.org/manual/5.1/manual.html#2.10)).
   Returns the previous value for pause.

* `"setstepmul"`: sets arg as the new value for the step multiplier of the collector
   (see [§2.10](http://www.lua.org/manual/5.1/manual.html#2.10)).
   Returns the previous value for step.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-collectgarbage51)
]]

-------------------------------
