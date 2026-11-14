-------------------------------
--         table syntax
-------------------------------
--[[
Table fields are of two kinds:

1. Array part (no key):
     { "a", "b", "c" }   -> auto indices 1, 2, 3

2. Keyed part (explicit key):
     { name = "Alex" }   -> ["name"] = "Alex"
     { [1] = "a" }       -> [1] = "a"

--- keyed part: identifier rule ---

Identifier is a name used as a key without brackets.
  - valid: letters, digits, underscore (_)
  - must NOT start with a digit
  - must NOT be a Lua keyword (if, end, for, ...)
Examples:
  name, _x, x1, myVar, count_2, a, A, _G

Invalid identifiers (must be in square brackets):
  [1]        -- number
  [1.5]      -- float
  ["my key"] -- string with space
  ["a-b"]    -- string with dash
  [true]     -- boolean
  [t]        -- table as key
  [nil]      -- error: nil is not allowed as a key

Rule:
  - valid identifiers: key without brackets   { name = value }
  - all other keys: must be in brackets       { [expr] = value }

Remark:
  - [1], [2], [3] are redundant when indices are sequential:
      { "a", "b" }        -- same as { [1]="a", [2]="b" }
  - brackets are needed when indices are not sequential:
      { [1] = "a", [10] = "b" }

NB: trailing comma is allowed
local tab = { "a", "b", }
]]

-- -- create a new table
-- local tab = {}
-- print(type(tab)) -- table

-- -- array part: no key, auto indices
-- local tab = { "a", "b", "c" }
-- print(tab[1], tab[2], tab[3]) -- a    b    c

-- -- table length
-- local tab = { "a", "b", "c" }
-- print(#tab) -- 3

-- -- keyed part: valid identifier
-- local tab = { name = "Alex", age = 30 }
-- print(tab.name, tab.age) -- Alex    30
-- print(tab["name"], tab["age"]) -- Alex    30

-- -- keyed part: invalid identifier in brackets
-- local tab = { ["a-b"] = 2, [1.5] = 3, [true] = 4 }
-- print(tab["a-b"]) -- 2
-- print(tab[1.5]) -- 3
-- print(tab[true]) -- 4

-- -- mixed: array + keyed
-- local tab = { "a", "b", name = "Alex" }
-- print(tab[1], tab[2], tab.name) -- a    b    Alex

-- -- nested tables
-- local tab = { { 1, 2 }, { 3, 4 } }
-- print(tab[1]) -- table: 0x556f0cb07530
-- print(tab[1][1], tab[2][2]) -- 1    4

-- -- table as key
-- local key = {}
-- local tab = { [key] = "value" }
-- print(tab[key]) -- value

-- -- nil as key is an error
-- local tab = { [nil] = 1 } -- Error: table index is nil

-- -- sequential vs non-sequential indices
-- local tab_1 = { [1] = "a", [2] = "b" } -- same as { "a", "b" } - no sense
-- local tab = { [1] = "a", [10] = "b" } -- need brackets for non-sequential
-- print(tab[1], tab[10]) -- a    b

-- -- number without brackets is a syntax error
-- local tab = { 1 = "a" } -- error
-- print(tab[1])  --  '}' expected near '='

-- -- number in brackets is fine
-- local tab = { [1] = "a" }
-- print(tab[1]) -- a
