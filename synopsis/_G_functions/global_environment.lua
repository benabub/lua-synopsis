-------------------------------
--          _G
-------------------------------
--[[
_G: table

    The global environment table.

    - holds all global variables and functions
    - accessible from anywhere
    - assigning a global variable = adding a field to _G
    - reading an undefined global = nil

    NB: avoid globals. Use `local` instead:
    - pollute the global namespace (_G) and cause name conflicts
    - slower: stored in _G table, not on the stack
    - harder to debug: unclear who created or modified them
    - live until the program ends (memory leaks)
    - break module isolation
]]

-- -- List all globals
-- for k, v in pairs(_G) do
-- 	print(k, type(v))
-- end

-- -- Same thing
-- x = 10 -- init as global
-- print(_G.x) -- 10
-- _G.y = 20
-- print(y) -- 20

-- -- Undefined global
-- print(_G.undefined) -- nil

-------------------------------
--          _VERSION
-------------------------------
--[[
_VERSION: string

    The current Lua version as a string.

    - read-only
    - format: "Lua 5.4"
]]

-- print(_VERSION) -- Lua 5.4

-------------------------------
--          arg
-------------------------------
--[[
arg: table

    Command-line arguments passed to the script.

    - arg[0] = script name (or nil in interactive mode)
    - arg[1], arg[2], ... = script arguments
    - arg[-1], arg[-2], ... = interpreter arguments

    NB: only available in the main chunk.
]]

-- -- Run: current file
-- print(arg[0]) -- lua_base_synopsis/_G/global_environment.lua
-- print(arg[1]) -- hello
-- print(arg[2]) -- word
-- print(arg[-1]) -- lua (interpreter path)
-- print(5 + 3)
-- --[[
-- ➜  git:(main) ✗ lua lua_base_synopsis/_G/global_environment.lua hello word
-- ---
-- lua_base_synopsis/_G/global_environment.lua
-- hello
-- word
-- lua
-- 8
-- ]]

-- -- Loop over arguments
-- for i = 1, #arg do
-- 	print(i, arg[i])
-- end
-- --[[
-- ➜  git:(main) ✗ lua lua_base_synopsis/_G/global_environment.lua hello word
-- ---
-- 1       hello
-- 2       word
-- ]]

-------------------------------
