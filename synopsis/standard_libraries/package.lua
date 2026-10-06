-- for k, _ in pairs(_G.package) do
-- 	print(k)
-- end

--[[
config
searchers
loaded
path
cpath
loadlib
searchpath
preload
]]

-------------------------------
--         config
-------------------------------
--[[
package.config: string

    NB: low-level info about Lua build. Not needed in 99% of code.

    A string describing compile-time configurations for packages.
    Five lines, separated by '\n':

    1. directory separator ('/' on Unix, '\' on Windows)
    2. path separator (';')
    3. substitution mark ('?')
    4. Windows executable dir replacement ('!')
    5. version prefix ignore mark ('-')
]]

-- print(package.config)
-- -- /
-- -- ;
-- -- ?
-- -- !
-- -- -

-------------------------------
--      searchers
-------------------------------
--[[
package.searchers: table

    NB: low-level. Only needed if you write your own module loader.

    A table of search functions used by require to find a loader.

    Default order:
      1. preload    (package.preload)
      2. Lua loader (package.path)
      3. C loader   (package.cpath)
      4. all-in-one loader

    You can modify this table to change how require looks for modules.
]]

-- for i, searcher in ipairs(package.searchers) do
-- 	print(i, searcher)
-- end
-- -- 1	function: 0x61d88f7319a0
-- -- 2	function: 0x61d88f7319e0
-- -- 3	function: 0x61d88f731a20
-- -- 4	function: 0x61d88f731a60

-------------------------------
--         loaded
-------------------------------
--[[
package.loaded: table

    NB: low-level. Rarely used directly.

    A table used by require to control which modules are already loaded.

    - require returns package.loaded[modname] if it is not false.
    - this variable is only a reference to the real table;
      assigning to it does not change the table used by require.
]]

-- print(package.loaded.math) -- table: 0x60f158873ce0
-- print(package.loaded.nonexistent) -- nil

-------------------------------
--         path
-------------------------------
--[[
package.path: string

    NB: low-level. Needed when you add custom module search paths.

    The path used by require to search for a Lua loader.

    Initialized from:
      - LUA_PATH_5_4 environment variable, or
      - LUA_PATH environment variable, or
      - default path defined in luaconf.h

    '?' in the path is replaced by the module name.
]]

-- print(package.path)
-- -- /usr/local/share/lua/5.4/?.lua;/...

-------------------------------
--         cpath
-------------------------------
--[[
package.cpath: string

    NB: low-level. Needed when you load C libraries.

    The path used by require to search for a C loader.

    Initialized from:
      - LUA_CPATH_5_4 environment variable, or
      - LUA_CPATH environment variable, or
      - default path defined in luaconf.h

    '?' in the path is replaced by the module name.
]]

-- print(package.cpath)
-- -- /usr/local/lib/lua/5.4/?.so;/

-------------------------------
--         loadlib
-------------------------------
--[[
function package.loadlib(libname: string, funcname: string)
  -> function? | nil
  2. string?

    NB: dangerous and low-level. Not supported by Standard C.

    Dynamically links the host program with the C library libname.

    - Low-level function. Bypasses the package and module system.
    - No path searching, no automatic extension.
    - libname must be the complete file name including path and extension.
    - funcname must be the exact exported name.
    - Inherently unsafe.
]]

-------------------------------
--      searchpath
-------------------------------
--[[
function package.searchpath(name: string, path: string, sep?: string, rep?: string)
  -> string? | nil
  2. string?

    NB: low-level. Used internally by require.

    Searches for name in path, using sep as separator and rep as substitution mark.

    - Default sep = '.', rep = '/'.
    - Returns the file path if found, or nil + error message.
]]

-- local path = package.searchpath("math", package.path)
-- print(path) -- nil (no file, because builtin package)

-------------------------------
--         preload
-------------------------------
--[[
package.preload: table

    NB: low-level. Needed only for embedding modules without files.

    A table that stores loaders for specific modules.

    - require checks this table first.
    - If package.preload[modname] exists, it must be a function (the loader).
    - Useful for embedding modules directly in code without files.
]]

-- package.preload["mymodule"] = function()
-- 	return {
-- 		greet = function()
-- 			return "hello"
-- 		end,
-- 	}
-- end
-- local m = require("mymodule")
-- print(m.greet()) -- hello
