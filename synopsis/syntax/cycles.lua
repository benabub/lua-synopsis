-------------------------------
--         while
-------------------------------
--[[
    while <condition> do
        <body>
    end

    - condition is checked BEFORE each iteration
    - if condition is false initially, body never runs
    - false and nil are false; everything else is true
]]

-- local i = 1
-- while i <= 3 do
-- 	print(i)
-- 	i = i + 1
-- end
-- -- 1
-- -- 2
-- -- 3

-- -- never runs:
-- while false do
-- 	print("never")
-- end

-- -- infinite loop (0 is truthy in Lua!):
-- while 0 do
-- 	print("infinite")
-- 	break
-- end
-- -- infinite

-------------------------------
--         repeat ... until
-------------------------------
--[[
    repeat
        <body>
    until <condition>

    - body runs FIRST, condition checked AFTER
    - body always runs at least once
    - condition is the EXIT condition (loop while false)
    - local variables declared in body are visible in until
]]

-- local i = 1
-- repeat
-- 	print(i)
-- 	i = i + 1
-- until i > 3
-- -- 1
-- -- 2
-- -- 3

-- -- runs at least once even if condition is true:
-- repeat
-- 	print("once")
-- until true

-- -- locals are visible in until:
-- repeat
-- 	local x = 5
-- 	print("one")
-- until x == 5
-- -- one

-------------------------------
--         numeric for
-------------------------------
--[[
    for <var> = <start>, <stop> [, <step>] do
        <body>
    end

    - start, stop, step are evaluated ONCE
    - step defaults to 1
    - var is local to the loop
    - all three must be numbers
]]

-- for i = 1, 3 do
-- 	print(i)
-- end
-- -- 1
-- -- 2
-- -- 3

-- -- with step:
-- for i = 1, 10, 2 do
-- 	print(i)
-- end
-- -- 1
-- -- 3
-- -- 5
-- -- 7
-- -- 9

-- -- negative step:
-- for i = 3, 1, -1 do
-- 	print(i)
-- end
-- -- 3
-- -- 2
-- -- 1

-- -- loop doesn't run if step goes wrong way:
-- for i = 1, 10, -1 do
-- 	print(i)
-- end
-- -- (nothing)

-- -- var is local, not visible outside:
-- for i = 1, 1 do
-- 	print(i)
-- end
-- print(i) -- nil (global, not the loop var)

-------------------------------
--         generic for
-------------------------------
--[[
    for <vars> in <iterator> do
        <body>
    end

    - iterator is a function that returns next value(s)
    - loop stops when first value (e.g. key in key-value pair) is nil
    - common iterators: pairs, ipairs, io.lines, custom
]]

-- -- ipairs (array part, stops at first nil):
-- for i, v in ipairs({ "a", "b", "c" }) do
-- 	print(i, v)
-- end
-- -- 1    a
-- -- 2    b
-- -- 3    c

-- -- pairs (all keys, random order):
-- for k, v in pairs({ a = 1, b = 2 }) do
-- 	print(k, v)
-- end
-- -- a	1
-- -- b	2

-- -- custom iterator:
-- local function range(n)
-- 	local i = 0
-- 	return function()
-- 		i = i + 1
-- 		if i <= n then
-- 			return i
-- 		end
-- 	end
-- end
-- for i in range(3) do
-- 	print(i)
-- end
-- -- 1
-- -- 2
-- -- 3

-------------------------------
--         break
-------------------------------
--[[
    break

    - exits the innermost loop (while, repeat, for)
    - must be the LAST statement in a block
    - can be inside `do ... end` to bypass the rule
]]

-- for i = 1, 10 do
-- 	if i == 3 then
-- 		break
-- 	end
-- 	print(i)
-- end
-- -- 1
-- -- 2

-- -- break in nested loop exits only the inner one:
-- for i = 1, 3 do
-- 	for j = 1, 3 do
-- 		if j == 2 then
-- 			break
-- 		end
-- 		print(i, j)
-- 	end
-- end
-- -- 1    1
-- -- 2    1
-- -- 3    1

-------------------------------
--         goto
-------------------------------
--[[
    goto <label>
    ::<label>::

    - jumps to a label in the same function
    - can jump forward or backward
    - cannot jump into the scope of a local variable
    - labels are visible in the entire block
]]

-- for i = 1, 5 do
-- 	if i == 3 then
-- 		goto skip
-- 	end
-- 	print(i)
-- 	::skip::
-- end
-- -- 1
-- -- 2
-- -- 4
-- -- 5

-- -- goto backward (manual loop):
-- local n = 0
-- ::again::
-- n = n + 1
-- if n < 3 then goto again end
-- print(n) -- 3
