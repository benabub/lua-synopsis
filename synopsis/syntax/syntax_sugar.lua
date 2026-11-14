-------------------------------
--         obj:method
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

-------------------------------
--     (func(args..))
-------------------------------
--[[
    (func()) keeps ONLY the first return value of func.

    func()    -> all return values
    (func())  -> first return value only

    Useful when a function returns extra values
    you don't need (e.g. gsub returns string + count).
]]

-- local function func()
-- 	return 1, 2, 3
-- end
-- print(func()) -- 1    2    3 (all)
-- print((func())) -- 1 (first only)

-- -- gsub example:
-- print(string.gsub("hello", "l", "L")) -- heLLo    2
-- print((string.gsub("hello", "l", "L"))) -- heLLo

-- -- in a table constructor:
-- local function func()
-- 	return 1, 2, 3
-- end
-- local t1 = { func() }
-- print(#t1) -- 3
-- local t2 = { (func()) }
-- print(#t2) -- 1
