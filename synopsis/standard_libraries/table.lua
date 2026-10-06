-- for k, _ in pairs(_G.table) do
-- 	print(k)
-- end

--[[
insert
remove
concat
pack
sort
unpack
move
]]

local function print_tab(t)
	for k, v in pairs(t) do
		print(k, v)
	end
end

-------------------------------
--         insert
-------------------------------
--[[
function table.insert(list: table, pos: integer, value: any)

Inserts element `value` at position `pos` in `list`.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.insert)

function table.insert(list: table, value: any)
]]

-- local tab = { "a", "b", cat = "Tom" }
-- table.insert(tab, 2, "c")
-- for k, v in pairs(tab) do
-- 	print(k, v)
-- end
-- -- 1	a
-- -- 2	c
-- -- 3	b
-- -- cat	Tom

-------------------------------
--         remove
-------------------------------
--[[
function table.remove(list: table, pos?: integer)
  -> any

Removes from `list` the element at position `pos`, returning the value of the removed element.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.remove)
]]

-- local tab = { "a", "b", cat = "Tom" }
-- table.remove(tab, 2)
-- for k, v in pairs(tab) do
-- 	print(k, v)
-- end
-- --
-- -- 1	a
-- -- cat	Tom
-- --
-- table.remove(tab, 2)
-- for k, v in pairs(tab) do
-- 	print(k, v)
-- end
-- --
-- -- 1	a
-- -- cat	Tom

-------------------------------
--         concat
-------------------------------
--[[
function table.concat(list: table, sep?: string, i?: integer, j?: integer)
  -> string

    Given a list where all elements are strings or numbers, returns the string
    `list[i]..sep..list[i+1] ··· sep..list[j]`.

    i - start
    j - end

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.concat)
]]

-- local tab = { "a", "b", "c", "d", cat = "Tom" }
-- print(table.concat(tab, nil, 1, 3)) -- abc
-- print(table.concat(tab, "-", 1, 3)) -- a-b-c
-- print(table.concat(tab, "T", 1, 5)) -- error

-------------------------------
--         pack
-------------------------------
--[[
function table.pack(...any)
  -> table

    Returns a new table with all arguments stored into keys `1`, `2`, etc. and
    with a field `"n"` with the total number of arguments.

    NB: don't work with table key-value pairs!

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.pack)
]]

-- local res = table.pack("a", nil, nil, "b")
-- print_tab(res)
-- --
-- -- 1	a
-- -- 4	b
-- -- n	4

-------------------------------
--         sort
-------------------------------
--[[
function table.sort(list: <T>[], comp?: fun(a: <T>, b: <T>):boolean)

  Sorts list elements in a given order, *in-place*, from `list[1]` to `list[#list]`.

  `comp?` — is a func(a, b) -> boolean: if true — `a` goes before `b` (to the left).

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.sort)
]]

-- local tab = { cat = "Tom", "b", "a" }
-- table.sort(tab)
-- print_tab(tab)
-- --
-- -- 1	a
-- -- 2	b
-- -- cat	Tom

-- -- sort in descending order:
-- local t = { 3, 1, 4, 1, 5, 9, 2, 6 }
-- table.sort(t, function(a, b)
-- 	return a > b
-- end)
-- print(table.concat(t, " ")) -- 9 6 5 4 3 2 1 1

-- -- sort by length
-- local t = { "apple", "cat", "banana" }
-- table.sort(t, function(a, b)
-- 	return #a < #b
-- end)
-- print(table.concat(t, " ")) -- cat apple banana

-- -- field sort
-- local people = {
-- 	{ name = "Alex", age = 30 },
-- 	{ name = "Bob", age = 25 },
-- 	{ name = "Cara", age = 35 },
-- }
-- table.sort(people, function(a, b)
-- 	return a.age < b.age
-- end)
-- for _, p in ipairs(people) do
-- 	print(p.name, p.age)
-- end
-- -- Bob 25
-- -- Alex 30
-- -- Cara 35

-------------------------------
--         unpack
-------------------------------
--[[
function table.unpack(list: { ...any }, i?: integer, j?: integer)
  -> ...any

    Returns the elements from the given list. This function is equivalent to

        return list[i], list[i+1], ···, list[j]

    i - start
    j - end

    By default, `i` is `1` and `j` is `#list`.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.unpack)
]]

-- local tab = { "a", "b", cat = "Tom" }
-- print(table.unpack(tab)) -- a  b

-- local tab = { "a", "b", "c", "d", "e" }
-- print(table.unpack(tab, 3, 4)) -- c	d

-------------------------------
--         move
-------------------------------
--[[
function table.move(a1: table, f: integer, e: integer, t: integer, a2?: table)
  -> a2: table

  Copy elements from table `a1` to table `a2`.

  Danger: it is not `move` actually, it's `copy`!!!

  a1 - source table
  a2 - destination table
  f - start index in a1
  e - end index in a1
  t - start index in a2 (destination position)

  Danger: not obvious behaviour in a2:
  - all original array part from start input index removes
  - all original hash part stays 

  If no a2 provided, puts elements in a1 and return it.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-table.move)
]]

-- local tab1 = { "a", "b", cat = "Tom" }
-- local tab2 = { "C", "D", "E", "F", dog = "Rex" }
-- table.move(tab1, 1, 3, 2, tab2)
-- print_tab(tab1)
-- --
-- -- 1	a
-- -- 2	b
-- -- cat	Tom
-- print_tab(tab2)
-- --
-- -- 1	C
-- -- 2	a
-- -- 3	b
-- -- dog	Rex

-- local tab1 = { "a", "b", "c", cat = "Tom" }
-- table.move(tab1, 1, 2, 2)
-- print_tab(tab1)
-- --
-- -- 1	a
-- -- 2	a
-- -- 3	b
-- -- cat	Tom

-------------------------------
