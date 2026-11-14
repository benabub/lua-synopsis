-------------------------------
--         colon sugar syntax
-------------------------------
--[[
    obj:method(args) is syntactic sugar for obj.method(obj, args)

    - ':' passes obj as the FIRST argument (self)

    NB: Works out of the box ONLY for strings!!!
    because strings have a default metatable with __index = string.

    Other types need a metatable with __index set manually.
]]

-- local s = "hello"
-- print(s:upper()) -- HELLO
-- print(string.upper(s)) -- HELLO (same)
-- print(s:sub(2, 4)) -- ell
-- print(string.sub(s, 2, 4)) -- ell (same)
