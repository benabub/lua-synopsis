--------------------------------
--        METAMETHODS
--------------------------------
--[[
    Most operators work through metamethods. Their behavior can be changed.
    Some don't. Their behavior cannot be changed.

    Operator is a symbol
    Operation is not a symbol, but some action performed via specific syntax

    Both operators and operations can be handled through metamethods
]]

--------------------------------
--        OPERATORS
--------------------------------

--[[
operator: +
meta: __add
]]

-- print(10 + 2) -- 12

--------------------------------
--[[
operator: -
meta: __sub
]]

-- print(10 - 2) -- 8

--------------------------------
--[[
operator: *
meta: __mul
]]

-- print(10 * 2) -- 20

--------------------------------
--[[
operator: /
meta: __div
]]

-- print(10 / 2) -- 5.0

--------------------------------
--[[
operator: %
meta: __mod
]]

-- print(11 % 3) -- 2

--------------------------------
--[[
operator: ^
meta: __pow
]]

-- print(10 ^ 2) -- 100.0

--------------------------------
--[[
operator: - (unary)
meta: __unm
]]

-- print(-10 + 10) -- 0

--------------------------------
--[[
operator: ..
meta: __concat
]]

-- print("hello " .. "world") -- hello world

--------------------------------
--[[
operator: #
meta: __len

    Danger: return count of bytes, not symbols!

    utf8.len vs #:
      #s        -> bytes
      utf8.len  -> characters (code points)

      ASCII:    same
      Non-ASCII: different
]]

-- print(#"hello") -- 5
-- print(#{ 10, 20, 30 }) -- 3

--------------------------------
--[[
operator: ==
meta: __eq
]]

-- print(10 == 10) -- true
-- print("asd" == 10) -- false

--------------------------------
--[[
operator: ~=
meta: __eq (inverted)
]]

-- print(10 ~= 5) -- true
-- print("asd" ~= "asd") -- false

--------------------------------
--[[
operator: <
meta: __lt
]]

-- print(10 < 20) -- true
-- print(100 < 20) -- false

--------------------------------
--[[
operator: >
meta: __lt (reversed)
]]

-- print(20 > 10) -- true
-- print(20 > 100) -- false

--------------------------------
--[[
operator: <=
meta: __le
]]

-- print(10 <= 20) -- true
-- print(100 <= 20) -- false

--------------------------------
--[[
operator: >=
meta: __le (reversed)
]]

-- print(20 >= 10) -- true
-- print(20 >= 100) -- false

--------------------------------
--[[
operator: and
meta: none
]]

-- print(true and false) -- false
-- print(nil and "asd") -- nil
-- print(12 and "asd") -- asd

--------------------------------
--[[
operator: or
meta: none
]]

-- print(true or false) -- true
-- print(12 or nil) -- 12

--------------------------------
--[[
operator: not
meta: none
]]

-- print(not true) -- false
-- print(not 12) -- false
-- print(not nil) -- true

--------------------------------
--        OPERATIONS
--------------------------------

--[[
operation: indexing (key access)
meta: __index
]]

-- print(({ "a", "b", "c" })[2]) -- b
-- print(("asdf")[2]) -- nil -- not like in py

--------------------------------
--[[
operation: field access
meta: __index
]]

-- local t = { name = "Alex" }
-- print(t.name) -- Alex

--------------------------------
--[[
operation: assignment (new key)
meta: __newindex
]]

-- local tab = {}
-- tab.name = "Alex"
-- tab.sex = "Male"
-- for k, v in pairs(tab) do
-- 	print(k, v)
-- end
-- -- name	Alex
-- -- sex	Male

--------------------------------
--[[
operation: function call
meta: __call
]]

-- local t = {}
-- setmetatable(t, {
-- 	__call = function()
-- 		return 42
-- 	end,
-- })
-- print(t()) -- 42

--------------------------------
--[[
operation: method call
meta: __index (method lookup)
]]

-- local tab = { name = "Alex" }
-- function tab.greet(self)
-- 	return "Hello, " .. self.name
-- end
-- print(tab:greet()) -- Hello, Alex

-- -- syntax sugar:
-- local tab = { name = "Alex" }
-- function tab:greet()
-- 	return "Hello, " .. self.name
-- end
-- print(tab:greet()) -- Hello, Alex

--------------------------------
--[[
operation: tostring() conversion
meta: __tostring
]]

-- local t = { cat = "Tom" }
-- setmetatable(t, {
-- 	__tostring = function()
-- 		return "my table"
-- 	end,
-- })
-- print(t) -- my table

--------------------------------
--[[
operation: garbage collection
meta: __gc

userdata only (not available in pure Lua)
]]

--------------------------------
--[[
operation: pairs() iteration
meta: __pairs
]]

-- local t = { a = 1, b = 2 }
-- setmetatable(t, {
-- 	__pairs = function(t)
-- 		return next, t, nil
-- 	end,
-- })
-- for k, v in pairs(t) do
-- 	print(k, v)
-- end
-- -- b	2
-- -- a	1

--------------------------------
--[[
operation: ipairs() iteration
meta: none
]]

-- local t = { 10, 20, 30 }
-- for i, v in ipairs(t) do
-- 	print(i, v)
-- end
-- -- 1	10
-- -- 2	20
-- -- 3	30
