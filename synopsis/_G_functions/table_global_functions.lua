-------------------------------
--       pairs
-------------------------------
--[[
function pairs(t: <T:table>)
  -> fun(table: table<K, V>, index?: <K>):<K>, <V>
  2. <T:table>

    If `t` has a metamethod `__pairs`, calls it with t as argument and returns
    the first three results from the call.
    Otherwise, returns three values: the
    [next](http://www.lua.org/manual/5.1/manual.html#pdf-next) function, the
    table `t`, and `nil`, so that the construction

    pairs() — iterates over all keys (both array and hash parts).
    - Traversal order is random!
    - nil is ignored.

    for k,v in pairs(t) do body end

    will iterate over all key–value pairs of table `t`.

    See function [next](http://www.lua.org/manual/5.1/manual.html#pdf-next) for
    the caveats of modifying the table during its traversal.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-pairs)
]]

-- for k, v in pairs({ "a", 123, nil, 43 }) do
-- 	print(k, v)
-- end
-- -- 1       a
-- -- 2       123
-- -- 4       43

-- -- Mixed table: array-part always goes first
-- local mix_table = {
-- 	cat = "animal",
-- 	number = 100,
-- 	"Alex",
-- 	home = "house",
-- 	nil,
-- 	"Helena",
-- }
-- for key, val in pairs(mix_table) do
-- 	print(key, val)
-- end
-- -- 1       Alex
-- -- 3       Helena
-- -- number  100
-- -- cat     animal
-- -- home    house

-------------------------------
--       ipairs
-------------------------------
--[[
function ipairs(t: <T:table>)
  -> fun(table: <V>[], i?: integer):integer, <V>
  2. <T:table>
  3. i: integer

    Returns three values (an iterator function, the table `t`, and `0`) so that
    the construction

    ipairs — iterates over the array part (integer keys 1, 2, 3...).
    - NB: Stops at the first nil.
    - Does not iterate over hash part.

    for i,v in ipairs(t) do body end

    will iterate over the key–value pairs `(1,t[1]), (2,t[2]), ...`, up to
    the first absent index.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-ipairs)
]]

-- for k, v in ipairs({ "a", 123, nil, 43 }) do
-- 	print(k, v)
-- end
-- -- 1       a
-- -- 2       123

-- -- ipairs doesn't look at table hash-part at all
-- local mix_table = { cat = "animal", number = 100, "Alex", home = "house" }
-- for key, val in ipairs(mix_table) do
-- 	print(key, val)
-- end
-- -- 1       Alex

-------------------------------
--       next
-------------------------------
--[[
function next(table: table<K, V>, index?: <K>)
  -> <K>?
  2. <V>?

    Allows a program to traverse all fields of a table. Its first argument is a
    table and its second argument is an index in this table. A call to `next`
    returns the next index of the table and its associated value. When called
    with `nil` as its second argument, `next` returns an initial index and its
    associated value. When called with the last index, or with `nil` in an
    empty table, `next` returns `nil`. If the second argument is absent, then
    it is interpreted as `nil`. In particular, you can use `next(t)` to check
    whether a table is empty.
    The order in which the indices are enumerated is not specified, *even for
    numeric indices*. (To traverse a table in numerical order, use a numerical
    `for`.)
    The behavior of `next` is undefined if, during the traversal, you assign
    any value to a non-existent field in the table. You may however modify
    existing fields. In particular, you may set existing fields to nil.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-next)
]]

-- local tab = { 10, "asd", nil, 43 }
-- print(next(tab)) -- 1       10
-- print(next(tab)) -- 1       10
-- print(next(tab, 2)) -- 4       43
-- print(next(tab, 3)) -- 4       43

-- -- Practical Example 1: Efficiently checking if a table is empty
-- local empty_table = {}
-- local filled_table = { name = "Alex" }
-- ---
-- print(next(empty_table) == nil) -- true (table is empty)
-- print(next(filled_table) == nil) -- false (table has elements)

-------------------------------
--       rawget
-------------------------------
--[[
function rawget(table: table, index: any)
  -> any

    It makes sense to use it only if the table has a metatable or there is a
    suspicion that it does.

    Conflict with meta-method: __index

    Gets the real value of `table[index]`, without invoking the `__index`
    metamethod.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-rawget)
]]

-- print(rawget({ 10, "asd", nil, 43 }, 2)) -- asd
-- print(rawget({ 10, "asd", nil, 43 }, 3)) -- nil
-- print(rawget({ 10, "asd", nil, 43 }, 12)) -- nil

-------------------------------
--       rawset
-------------------------------
--[[
function rawset(table: table, index: any, value: any)
  -> table

    It makes sense to use it only if the table has a metatable or there is a
    suspicion that it does.

    Conflict with meta-method: __newindex

    Sets the real value of `table[index]` to `value`, without using the
    `__newindex` metavalue. `table` must be a table, `index` any value
    different from `nil` and `NaN`, and `value` any Lua value. This function
    returns `table`.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-rawset)
]]

-- local tab = { "a", b = "cat", nil, 43 }
-- rawset(tab, 2, 100)
-- for k, v in pairs(tab) do
-- 	print(k, v)
-- end
-- --
-- -- 1       a
-- -- 2       100
-- -- 3       43
-- -- b       cat

-------------------------------
--       rawequal
-------------------------------
--[[
function rawequal(v1: any, v2: any)
  -> boolean

    It makes sense to use it only if the table has a metatable or there is a
    suspicion that it does.

    Conflict with meta-method: __eq

    Checks whether v1 is equal to v2, without invoking the `__eq` metamethod.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-rawequal)
]]

-- print(rawequal(12, 12)) -- true
-- print(rawequal(12, nil)) -- false

-------------------------------
--       rawlen
-------------------------------
--[[
function rawlen(v: string|table)
  -> len: integer

    It makes sense to use it only if the table has a metatable or there is a
    suspicion that it does.

    Conflict with meta-method: __len

    Returns the length of the object `v`, without invoking the `__len`
    metamethod.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-rawlen)
]]

-- print(rawlen({ a = "cat", 12, nil, 43 })) -- 3
-- print(rawlen("asd")) -- 3

-------------------------------
