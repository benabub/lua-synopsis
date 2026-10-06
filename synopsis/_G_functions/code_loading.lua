-------------------------------
--          require
-------------------------------
--[[
function require(modname: string)
  -> unknown

    Python `import` analog
    - returns module as a value
    - no direct analogue of from ... import

    Loads the given module, returns any value returned by the given
    module(`true` when `nil`).

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-require)
]]

-- -- Example: loading a standard library
-- local math = require("math")
-- print(math.sqrt(16)) -- 4.0

--[[
How to import file from repo:

my_project/
├── main.lua
└── utils/
    └── helper.lua

helper.lua:
---
local M = {}
function M.greet()
    return "Hello"
end
return M

main.lua:
---
local helper = require("utils.helper")
print(helper.greet()) -- Hello

NB: Cannot go up directories with require. Use package.path for external modules.
]]

-------------------------------
--          load
-------------------------------
--[[
function load(chunk: string|function, chunkname?: string, mode?: "b"|"bt"|"t", env?: table)
  -> function?
  2. error_message: string?

    Python or Bash eval analog.
    Difference: doesn't evaluate code immediately, but returns it as a function.
    Same security concerns: do not use with untrusted input.

    DANGER: chunkname == error name.
    - If the second argument in load() is provided, it sticks as a label to the error message.

    Loads a chunk.
    If `chunk` is a string, the chunk is this string. If `chunk` is a function,
    `load` calls it repeatedly to get the chunk pieces. Each call to `chunk`
    must return a string that concatenates with previous results. A return of
    an empty string, `nil`, or no value signals the end of the chunk.

    [View documents](http://www.lua.org/manual/5.1/manual.html#pdf-load)

    mode:
        | "b" -- Only binary chunks.
        | "t" -- Only text chunks.
       -> "bt" -- Both binary and text.
]]

-- -- Load from string
-- local chunk = load("return 2 + 2")
-- if chunk then
-- 	print(chunk()) -- 4
-- end

-- -- Save err, as var (no return)
-- local _, err = load("2 + 2")
-- print(err) -- [string "2 + 2"]:1: unexpected symbol near '2'

-- -- Load without error
-- local bad, err = load("return 2 + 2")
-- print(bad) -- function: 0x642ad0686c00
-- if bad then
-- 	print(bad()) -- 4
-- end
-- print(err) -- nil

-- -- Load with error
-- local bad, err = load("return 2 ++ 2")
-- print(bad) -- nil
-- print(err) -- [string "2 ++ 2"]:1: unexpected symbol near '2'

-- -- Load with env (sandbox) - use only for one table:
-- local env = { b = 10 }
-- local f = load("return b", nil, nil, env) -- second nil - error name, third - mode
-- if f then
-- 	print(f()) -- 10
-- end

-- -- Pass source filename instead of error massage:
-- local chunk, err = load("return Hello", "file.lua")
-- print(err) -- file.lua

-- -- second `load` arg - error will be raised
-- local _, err = load("return 2 ++ 2", "file.lua")
-- print(err) -- [string "file.lua"]:1: unexpected symbol near '+'

-- -- second `load` arg - no error
-- local _, err = load("return 2 + 2", "file.lua")
-- print(err) -- nil

-------------------------------
--          loadfile
-------------------------------
--[[
function loadfile(filename?: string, mode?: "b"|"bt"|"t", env?: table)
  -> function?
  2. error_message: string?

    Loads a chunk from file `filename` or from the standard input, if no file
    name is given.

    loadfile():
    - always loads the entire file
    - forms it into a function
    - which can be saved as a variable and called later

    NB: loadfile uses paths relative to the current working directory, not the
        script's location.

    [View documents](http://www.lua.org/manual/5.1/manual.html#pdf-loadfile)

    mode: 
      | "b" -- Only binary chunks. 
      | "t" -- Only text chunks. -> 
      | "bt" -- Both binary and text.

    function loadfile_cached(filename?: string, mode?: "b"|"bt"|"t", env?:
    table) -> function? 2. error_message: string?
    `loadfile` using the cache Note this has the mode and env arguments which
    is supported by LuaJIT and is 5.1 compatible.

]]

-- file: example/filename.lua: "return 3 + 5"

-- local f, err = loadfile("lua_base_synopsis/_G/example/filename.lua")
-- if not f then
-- 	print("Error:", err)
-- else
-- 	print(f()) -- 8
-- end

-------------------------------
--          dofile
-------------------------------
--[[
function dofile(filename?: string)
  -> ...any

    Opens the named file and executes its content as a Lua chunk. When called
    without arguments, `dofile` executes the content of the standard input
    (`stdin`). Returns all values returned by the chunk. In case of errors,
    `dofile` propagates the error to its caller. (That is, `dofile` does not
    run in protected mode.)

    dofile() vs loadfile():
        - dofile() executes the file immediately
          loadfile() only compiles it into a function
        - dofile() returns the chunk's result
          loadfile() returns a function (or nil, error)
        - dofile() propagates errors (crashes)
          loadfile() returns errors as values (nil, err)
        - dofile() reads and executes the file every time
          loadfile() compiles once; the returned function can be called many times

    NB: dofile() - dangerous method!

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-dofile)
]]

-- file: example/filename.lua: "return 3 + 5"

-- local f, err = dofile("lua_base_synopsis/_G/example/filename.lua")
-- if not f then
-- 	print("Error:", err)
-- else
-- 	print(f) -- 8
-- end

-------------------------------
