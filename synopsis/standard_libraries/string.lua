-- for k, _ in pairs(_G.string) do
-- 	print(k)
-- end

--[[
packsize
upper
format
rep
char
dump
reverse
find
lower
len
gmatch
gsub
unpack
pack
sub
byte
match
]]

-------------------------------
--        packsize
-------------------------------
--[[
function string.packsize(fmt: string) -> integer

    Returns the size of a packed string created with string.pack
    using the given format string. (Lua 5.3+)
    Size is the number of bytes that the packed string will occupy.

    fmt - special format string (e.g. "i4", "d", "s")

    What for: `pack()` / `unpack()` / `packsize()`:
      - Binary data: network protocols (TCP/UDP packets)
      - Binary files: PNG, ZIP, custom save formats
      - C structs / FFI (userdata, external libs)
      - Game memory reading (Cheat Engine)
      - Compact transfer (bytes instead of text JSON)
      - IEEE 754 float conversion (serialize floats)
      - packsize: get size without creating the string
]]

-- print(string.packsize("i4")) -- 4
-- print(string.packsize("d")) -- 8

-------------------------------
--         upper
-------------------------------
--[[
function string.upper(s: string) -> string

    Returns a copy of s with all lowercase letters changed to uppercase.
]]

-- print(string.upper("hello")) -- HELLO

-------------------------------
--         format
-------------------------------
--[[
function string.format(fmt: string, ...any) -> string

    Returns a formatted string following printf-style specifiers.

    fmt - format string with specifiers (%d, %s, %f, etc.)
]]

-- print(string.format("Name: %s, Age: %d", "Alex", 30)) -- Name: Alex, Age: 30

-------------------------------
--         rep
-------------------------------
--[[
function string.rep(s: string, n: integer, sep?: string) -> string

    Repeat string

    Returns a string that is n copies of s concatenated.

    s   - string to repeat
    n   - number of repetitions
    sep - separator between copies (optional)
]]

-- print(string.rep("ab", 3)) -- ababab
-- print(string.rep("ab", 3, "-")) -- ab-ab-ab

-------------------------------
--         char
-------------------------------
--[[
function string.char(...integer) -> string

    Returns a string with characters of the given byte codes.
]]

-- print(string.char(65, 66, 67)) -- ABC

-------------------------------
--         dump
-------------------------------
--[[
function string.dump(f: fun(...any):...unknown, strip?: boolean)
  -> string

    Returns a binary representation of the given function.
    The result can be loaded with load().

    Returns a string containing a binary representation (a *binary chunk*) of the given function.

[View documents](http://www.lua.org/manual/5.4/manual.html#pdf-string.dump)
]]

-- local f = function()
-- 	return 42
-- end
-- --
-- local binary = string.dump(f)
-- print(string.format("%q", binary)) -- \27LuaT\0\25�\13\...
-- local g = load(binary)
-- if g then
-- 	print(g()) -- 42
-- end

-------------------------------
--         reverse
-------------------------------
--[[
function string.reverse(s: string|number)
  -> string

    Returns a string that is the string `s` reversed.
]]

-- print(string.reverse("hello")) -- olleh

-------------------------------
--         find
-------------------------------
--[[
function string.find(s: string|number, pattern: string|number, init?: integer, plain?: boolean)
  -> start: integer|nil
  2. end: integer|nil
  3. ...any

    Returns start and end indices of the first match of pattern in s.
    Returns nil if not found.

[View documents](http://www.lua.org/manual/5.4/manual.html#pdf-string.find)
]]

-- print(string.find("hello world", "world")) -- 7    11
-- print(string.find("hello world world", "world")) -- 7    11
-- print(string.find("hello", "xyz")) -- nil

-------------------------------
--         lower
-------------------------------
--[[
function string.lower(s: string) -> string

    Returns a copy of s with all uppercase letters changed to lowercase.
]]

-- print(string.lower("HELLO")) -- hello

-------------------------------
--         len
-------------------------------
--[[
function string.len(s: string) -> integer

    Returns the length of s in bytes.
]]

-- print(string.len("hello")) -- 5
-- print(#"hello") -- 5 (same thing)

-------------------------------
--         gmatch
-------------------------------
--[[
function string.gmatch(s: string, pattern: string)
  -> iterator

    Returns an iterator function that returns the next match of pattern
    in s each time it is called.
]]

-- for word in string.gmatch("one two three", "%a+") do
-- 	print(word)
-- end
-- -- one
-- -- two
-- -- three

-------------------------------
--         gsub
-------------------------------
--[[
function string.gsub(s: string, pattern: string, repl: string|table|function, n?: integer)
  -> string
  2. integer

    Returns a copy of s with all (or n) occurrences of pattern replaced.
    Returns the new string and the number of substitutions made.
]]

-- print(string.gsub("hello world", "o", "$")) -- hell$ w$rld	2
-- print(string.gsub("hello", "l", "")) -- heo            2

-------------------------------
--         unpack
-------------------------------
--[[
function string.unpack(fmt: string, s: string, pos?: integer)
  -> ...any
  2. integer

    Unpacks values from a binary string s according to fmt. (Lua 5.3+)
    Returns the unpacked values and the next position.

    What for: `pack()` / `unpack()` / `packsize()`:
      - Binary data: network protocols (TCP/UDP packets)
      - Binary files: PNG, ZIP, custom save formats
      - C structs / FFI (userdata, external libs)
      - Game memory reading (Cheat Engine)
      - Compact transfer (bytes instead of text JSON)
      - IEEE 754 float conversion (serialize floats)
      - packsize: get size without creating the string
]]

-- local v1, v2 = string.unpack("i4i4", string.pack("i4i4", 10, 20))
-- print(v1, v2) -- 10    20

-------------------------------
--         pack
-------------------------------
--[[
function string.pack(fmt: string, ...any) -> string

    Packs values into a binary string according to fmt. (Lua 5.3+)

    What for: `pack()` / `unpack()` / `packsize()`:
      - Binary data: network protocols (TCP/UDP packets)
      - Binary files: PNG, ZIP, custom save formats
      - C structs / FFI (userdata, external libs)
      - Game memory reading (Cheat Engine)
      - Compact transfer (bytes instead of text JSON)
      - IEEE 754 float conversion (serialize floats)
      - packsize: get size without creating the string
]]

-- local packed = string.pack("i4i4", 10, 20)
-- print(#packed) -- 8

-------------------------------
--         sub
-------------------------------
--[[
function string.sub(s: string, i: integer, j?: integer) -> string

    Returns the substring of s from index i to j (inclusive, 1-based).
    Negative indices count from the end.
]]

-- print(string.sub("hello", 2, 4)) -- ell
-- print(string.sub("hello", 2))    -- ello
-- print(string.sub("hello", -3))   -- llo

-------------------------------
--         byte
-------------------------------
--[[
function string.byte(s: string|number, i?: integer, j?: integer)
  -> ...integer

    i - start
    j - end

    Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
]]

-- print(string.byte("ABC")) -- 65
-- print(string.byte("ABC", 1, 3)) -- 65    66    67

-------------------------------
--         match
-------------------------------
--[[
function string.match(s: string, pattern: string, init?: integer)
  -> ...any
  
    Main parsing Lua tool

    Returns the captures from the first match of pattern in s.
    Returns nil if not found.
]]

-- print(string.match("hello 123", "%d+")) -- 123
-- print(string.match("2024-01-15", "(%d+)-(%d+)-(%d+)")) -- 2024    01    15

-------------------------------
