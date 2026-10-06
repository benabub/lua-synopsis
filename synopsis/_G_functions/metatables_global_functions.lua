-------------------------------
-- getmetatable & setmetatable
-------------------------------
--[[
    Metatable is an ordinary Lua table that defines the behavior of the
    original value under certain special operations.

    If the metatable has a __metatable field, returns that field instead.
    So the result may not be a table.

    Regular setmetatable works only with tables.

    Metatables by default:
      string  -> yes (one shared metatable for all strings)
      others  -> no (must be set manually with setmetatable)

    Built-in behavior (NOT metamethods):
      arithmetic on numbers works without any metatable
      # on tables works without any metatable
]]

-------------------------------

-- -- integer - hasn't
-- local a = 10
-- local b = 10
-- print(getmetatable(a)) -- nil
-- print(getmetatable(10)) -- nil
-- print(a + b) -- 20

-- -- string - has
-- local a = "a"
-- local b = "b"
-- print(getmetatable(a)) -- table: 0x62f07688fab0
-- print(getmetatable("a")) -- table: 0x62f07688fab0
-- -- print(a + b) -- error: no __add metamethod
-- for v, k in pairs(getmetatable(a)) do
-- 	print(v, k)
-- end
-- -- __idiv  function: 0x5a26e48bb120
-- -- __sub   function: 0x5a26e48bb080
-- -- __div   function: 0x5a26e48bb100
-- -- __index table: 0x5a26e5c0c490
-- -- __add   function: 0x5a26e48bb060
-- -- __mod   function: 0x5a26e48bb0c0
-- -- __mul   function: 0x5a26e48bb0a0
-- -- __unm   function: 0x5a26e48bb140
-- -- __pow   function: 0x5a26e48bb0e0

-------------------------------
-- how to set & to get metatable of value?

-- local t1 = { 1, 2, 3 }
-- local t2 = { 1, 2, 3 }
-- --
-- local mt = {
-- 	__add = function(a, b)
-- 		local result = {}
-- 		for i = 1, math.max(#a, #b) do
-- 			result[i] = (a[i] or 0) + (b[i] or 0)
-- 		end
-- 		return result
-- 	end,
-- }
-- --
-- setmetatable(t1, mt)
-- setmetatable(t2, mt)
-- --
-- local t3 = t1 + t2
-- --
-- for k, v in ipairs(t3) do
-- 	print(k, v)
-- end
-- -- 1       2
-- -- 2       4
-- -- 3       6
-- --
-- for k, v in pairs(getmetatable(t1)) do
-- 	print(k, v)
-- end
-- -- __add   function: 0x58903136fc00

-------------------------------
