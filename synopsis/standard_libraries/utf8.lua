-- for k, _ in pairs(_G.utf8) do
-- 	print(k)
-- end

--[[
char
charpattern
codes
len
offset
codepoint
]]

-------------------------------
--         utf8.char
-------------------------------
--[[
function utf8.char(...integer) -> string

    Receives zero or more integers (code points) and returns a string
    with the UTF-8 encoding of each code point.
]]

-- print(utf8.char(65, 66, 67)) -- ABC
-- print(utf8.char(0x00DF)) -- ß
-- print(utf8.char(0x4E2D)) -- 中

-------------------------------
--         utf8.charpattern
-------------------------------
--[[
utf8.charpattern: string

    The lua pattern like %a+

    The pattern which matches exactly one UTF-8 byte sequence, assuming that
    the subject is a valid UTF-8 string.

    - It is NOT a function.
    - Use with string.gmatch to iterate over UTF-8 characters.
]]

-- for c in string.gmatch("你好world", utf8.charpattern) do
-- 	print(c)
-- end
-- -- 你
-- -- 好
-- -- w
-- -- o
-- -- r
-- -- l
-- -- d

-------------------------------
--         utf8.codes
-------------------------------
--[[
function utf8.codes(s: string, lax?: boolean) -> iterator

    Returns an iterator for UTF-8 characters in s.
    Each iteration returns byte position and code point.

    lax (default = true in Lua 5.4):
      - true  -> accept surrogates and out-of-range codepoints
      - false -> error on them
]]

-- for pos, code in utf8.codes("café") do
-- 	print(pos, code)
-- end
-- --
-- -- 1	99
-- -- 2	97
-- -- 3	102
-- -- 4	233

-------------------------------
--         utf8.len
-------------------------------
--[[
function utf8.len(s: string, i?: integer, j?: integer, lax?: boolean)
  -> integer? | nil
  2. integer?

    Returns the number of UTF-8 characters in the range [i, j].

    utf8.len vs #:
      #s        -> bytes
      utf8.len  -> characters (code points)

      ASCII:    same
      Non-ASCII: different

    lax (default = true in Lua 5.4):
      - true  -> accept surrogates and out-of-range codepoints
      - false -> reject them

    Returns nil plus the position of the first invalid byte on error.
]]

-- print(utf8.len("hello")) -- 5
-- print(utf8.len("你好")) -- 2
-- print(utf8.len("café")) -- 4

-------------------------------
--         utf8.offset
-------------------------------
--[[
function utf8.offset(s: string, n: integer, i?: integer) -> integer?

    Returns the byte position where the encoding of the n-th character
    (counting from position i) starts.

    - n can be negative (count from the end).
    - n = 0 returns the start of the character containing byte i.
    - Assumes s is a valid UTF-8 string.
]]

-- -- 2 symbols, 3 bytes each
-- local s = "你好A"
-- print(utf8.offset(s, 1)) -- 1 (first symbol strarts with 1st byte)
-- print(utf8.offset(s, 2)) -- 4 (second symbol strarts with 4th byte)
-- print(utf8.offset(s, -1)) -- 7 (the last symbol strarts with 7th byte)

-------------------------------
--         utf8.codepoint
-------------------------------
--[[
function utf8.codepoint(s: string, i?: integer, j?: integer, lax?: boolean)
  -> ...integer

    Returns the code points (as integers) of all characters in s
    that start between byte positions i and j.

    i defaults to 1, j defaults to i.

    lax (default = true in Lua 5.4):
      - true  -> accept surrogates and out-of-range codepoints
      - false -> error on them
]]

-- print(utf8.codepoint("ß")) -- 223
-- print(utf8.codepoint("你好", 1, -1)) -- 20320    22909
