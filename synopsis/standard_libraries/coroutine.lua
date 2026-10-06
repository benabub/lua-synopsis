-------------------------------
--    coroutine commons
-------------------------------
--[[
Coroutine = a function that can pause (yield) and resume later.

    create  -> make a coroutine
    resume  -> start or continue
    yield   -> pause
    status  -> "suspended" / "running" / "normal" / "dead"
    wrap    -> create + return a function (no resume/status)

    Needed for:
      - generators (yield values one by one)
      - async (pause and resume later)
      - iterators (traverse data without loading all into memory)
      - game logic (pause within a frame)

    NB: async here means concurrency, not parallelism:
      - Concurrency  = tasks interleave, not simultaneous
      - Parallelism  = tasks run simultaneously (multiple cores)

    Iterator vs Generator:
      Iterator  - a function with no arguments
                  returns the next value or nil
                  ends when it returns nil
      Generator - a coroutine that yields values
                  returns values via yield
                  ends when its function finishes

    generator + wrap = iterator
]]

-- -- Example: generators:
-- local gen = coroutine.wrap(function()
-- 	for i = 1, 3 do
-- 		coroutine.yield(i)
-- 	end
-- end)
-- print(gen()) -- 1
-- print(gen()) -- 2
-- print(gen()) -- 3
-- print(gen()) --
-- print("edge") -- edge
-- print(gen()) -- cannot resume dead coroutine

-- -- Example: iterators:
-- local function range_analog(n)
-- 	return coroutine.wrap(function()
-- 		for i = 1, n do -- range from 1 to n inclusively
-- 			coroutine.yield(i) -- yield has ability to return
-- 		end
-- 	end)
-- end
-- for i in range_analog(5) do
-- 	print(i) -- 1 2 3 4 5
-- end

-- -- Example: async:
-- local c1 = coroutine.create(function()
-- 	print("A")
-- 	coroutine.yield()
-- 	print("B")
-- end)
-- local c2 = coroutine.create(function()
-- 	print(1)
-- 	coroutine.yield()
-- 	print(2)
-- end)
-- for _ = 1, 2 do
-- 	coroutine.resume(c1)
-- 	coroutine.resume(c2)
-- end
-- --
-- -- A
-- -- 1
-- -- B
-- -- 2

-------------------------------
--    create vs wrap
-------------------------------
--[[
create  -> returns thread
           resume returns true/false + values/error
           you control resumption manually

wrap    -> returns function
           calling it resumes the coroutine
           errors are propagated (not returned)
           no access to status/resume
]]

-- -- Example: create
-- local co = coroutine.create(function(a, b)
-- 	return a + b
-- end)
-- print(coroutine.resume(co, 2, 3)) -- true    5

-- -- Example: create (error is returned)
-- local co = coroutine.create(function()
-- 	error("boom")
-- end)
-- print(coroutine.resume(co)) -- false    file:102: boom (102 - line number)

-- -- Example: create (manual control)
-- local co = coroutine.create(function()
-- 	print("step 1")
-- 	coroutine.yield()
-- 	print("step 2")
-- end)
-- print(coroutine.status(co)) -- suspended
-- coroutine.resume(co) -- step 1
-- print(coroutine.status(co)) -- suspended
-- coroutine.resume(co) -- step 2
-- print(coroutine.status(co)) -- dead

-- -- Example: wrap
-- local gen = coroutine.wrap(function(a, b)
-- 	return a + b
-- end)
-- print(gen(2, 3)) -- 5

-- -- Example: wrap (error is propagated)
-- local gen = coroutine.wrap(function()
-- 	error("boom")
-- end)
-- gen() -- error: input:line: boom

-- -- Example: wrap (no status access)
-- local gen = coroutine.wrap(function()
-- 	for i = 1, 3 do
-- 		coroutine.yield(i)
-- 	end
-- end)
-- print(gen()) -- 1
-- print(gen()) -- 2
-- print(gen()) -- 3
-- print(coroutine.status(gen)) -- bad argument #1 to 'status' (thread expected, got function)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
--      coroutine methods
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- for k, _ in pairs(_G.coroutine) do
-- 	print(k)
-- end

--[[
status
wrap
create
resume
isyieldable
running
yield
close
]]

-------------------------------
--         status
-------------------------------
--[[
function coroutine.status(co: thread) -> string

    Returns the status of the coroutine co:
      "running"  - currently running
      "suspended" - not running, not finished
      "normal"   - active but not running (resumed another coroutine)
      "dead"     - finished or stopped by error

    NB: needed for managing coroutine state.
]]

-- local co = coroutine.create(function() end)
-- print(coroutine.status(co)) -- suspended
-- coroutine.resume(co)
-- print(coroutine.status(co)) -- dead

-------------------------------
--         wrap
-------------------------------
--[[
function coroutine.wrap(f: function) -> function

    Creates a coroutine with main function f.
    Returns a function that resumes the coroutine when called.

    - Errors are propagated to the caller (unlike resume).
    - Extra arguments passed to the wrapper go to resume.
]]

-- local gen = coroutine.wrap(function()
-- 	for i = 1, 3 do
-- 		coroutine.yield(i)
-- 	end
-- end)
-- print(gen()) -- 1
-- print(gen()) -- 2
-- print(gen()) -- 3
-- print(gen()) --
-- print("edge") -- edge
-- print(gen()) -- cannot resume dead coroutine

-------------------------------
--         create
-------------------------------
--[[
function coroutine.create(f: function) -> thread

    Creates a new coroutine with main function f.
    Returns the coroutine object (thread).
    Does NOT start execution.

    NB: needed for starting a coroutine.
]]

-- local co = coroutine.create(function()
-- 	print("hi")
-- end)
-- print(coroutine.status(co)) -- suspended
-- coroutine.resume(co) -- hi
-- print(coroutine.status(co)) -- dead

-------------------------------
--         resume
-------------------------------
--[[
function coroutine.resume(co: thread, ...any) -> boolean
  2. ...any

    Starts or continues the coroutine co.

    - Returns true + yielded/returned values on success.
    - Returns false + error message on failure.

    NB: needed to run a coroutine.
]]

-- local co = coroutine.create(function(a, b)
-- 	return a + b
-- end)
-- print(coroutine.resume(co, 2, 3)) -- true    5

-------------------------------
--   isyieldable
-------------------------------
--[[
function coroutine.isyieldable() -> boolean

    Returns true if the current execution context can yield.

    NB:
    - main thread    -> false
    - inside coroutine (running) -> true
]]

-- local function process(data)
-- 	if coroutine.isyieldable() then
-- 		coroutine.yield("paused: " .. data)
-- 		return "done: " .. data
-- 	else
-- 		return "sync: " .. data
-- 	end
-- end
-- --
-- -- Main thread
-- print(process("A")) -- sync: A
-- --
-- -- Coroutine
-- local co = coroutine.create(function()
-- 	print(process("B"))
-- 	print(process("C"))
-- end)
-- --
-- print(coroutine.resume(co))
-- -- true    paused: B
-- --
-- print(coroutine.resume(co))
-- -- done: B
-- -- true    paused: C
-- --
-- print(coroutine.resume(co))
-- -- done: C
-- -- true
-- --
-- print(coroutine.resume(co))
-- -- false	cannot resume dead coroutine

-------------------------------
--         running
-------------------------------
--[[
function coroutine.running() -> thread, boolean

    Returns the running coroutine plus a boolean:
    - true  - if it is the main thread
    - false - if it is a regular coroutine

    NB: needed to identify the current coroutine.
]]

-- -- Main thread: is_main = true
-- print(coroutine.running()) -- thread: 0x...    true
-- -- Inside coroutine: is_main = false
-- local co = coroutine.create(function()
-- 	print(coroutine.running())
-- end)
-- coroutine.resume(co) -- thread: 0x5992061c11d8	false

-------------------------------
--         yield
-------------------------------
--[[
function coroutine.yield(...any) -> ...any

    Suspends the running coroutine.
    Arguments are passed to resume.
    Returns values passed to the next resume.

    NB: needed to pause a coroutine.
]]

-- local co = coroutine.create(function()
-- 	coroutine.yield("paused")
-- 	print("resumed")
-- end)
-- print(coroutine.resume(co)) -- true    paused
-- coroutine.resume(co) -- resumed

-------------------------------
--         close
-------------------------------
--[[
function coroutine.close(co: thread) -> boolean
  2. string?

    Closes the coroutine co, freeing its resources.
    Returns true on success, or false + error message.
    Lua 5.4+.

    NB: needed to clean up a coroutine.
]]

-- local co = coroutine.create(function() end)
-- coroutine.resume(co)
-- print(coroutine.close(co)) -- true
