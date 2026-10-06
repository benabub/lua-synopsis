-- for k, _ in pairs(_G.math) do
-- 	print(k)
-- end

--[[
abs
cosh
mininteger
max
rad
ldexp
modf
log10
atan
random
exp
randomseed
ult
deg
log
huge
cos
acos
maxinteger
tan
frexp
min
tointeger
sin
atan2
sinh
sqrt
type
floor
pi
tanh
fmod
ceil
asin
pow
]]

-------------------------------
--         abs
-------------------------------
--[[
function math.abs(x: number) -> number

    Returns the absolute value of x.
]]

-- print(math.abs(-5)) -- 5
-- print(math.abs(5)) -- 5
-- print(math.abs(-3.14)) -- 3.14

-------------------------------
--         cosh - Deprecated
-------------------------------
--[[
function math.cosh(x: number) -> number

    Returns the hyperbolic cosine of x.
]]

-- print(math.cosh(0)) -- 1.0
-- print(math.cosh(1)) -- 1.5430806348152

-------------------------------
--         mininteger
-------------------------------
--[[
math.mininteger: integer

    The minimum value for an integer.
    Constant, not a function. Lua 5.3+.
]]

-- print(math.mininteger) -- -9223372036854775808

-------------------------------
--         max
-------------------------------
--[[
function math.max(x: number, ...number) -> number

    Returns the maximum value among its arguments.
]]

-- print(math.max(1, 5, 3)) -- 5
-- print(math.max(-1, -5, -3)) -- -1

-------------------------------
--         rad
-------------------------------
--[[
function math.rad(deg: number) -> number

    Converts degrees to radians.
]]

-- print(math.rad(180)) -- 3.1415926535898 (pi)
-- print(math.rad(90)) -- 1.5707963267949

-------------------------------
--         ldexp - Deprecated
-------------------------------
--[[
function math.ldexp(m: number, e: integer) -> number
   
    Load exponent

    Returns m * 2^e.
]]

-- print(math.ldexp(1, 3)) -- 8.0 (1 * 2^3)
-- print(math.ldexp(3, 2)) -- 12.0

-------------------------------
--         modf
-------------------------------
--[[
function math.modf(x: number) -> number, number

    Modulo Fraction

    Returns the integral part and the fractional part of x.
]]

-- print(math.modf(3.7)) -- 3    0.7
-- print(math.modf(-3.7)) -- -3   -0.7

-------------------------------
--         log10 - Deprecated
-------------------------------
--[[
function math.log10(x: number) -> number

    Returns the base-10 logarithm of x.
    Deprecated in 5.4 (use math.log(x, 10)).
]]

-- print(math.log10(100)) -- 2.0
-- print(math.log10(1000)) -- 3.0

-------------------------------
--         atan
-------------------------------
--[[
function math.atan(y: number, x?: number) -> number

    Returns the arc tangent of y/x in radians.
    If x is omitted, returns arc tangent of y.
]]

-- print(math.atan(1)) -- 0.78539816339745 (pi/4)
-- print(math.atan(1, 1)) -- 0.78539816339745
-- print(math.atan(1, -1)) -- 2.3561944901923

-------------------------------
--         random
-------------------------------
--[[
function math.random(m?: integer, n?: integer) -> number

    Returns a pseudo-random number.

    - no args:    float in [0, 1)
    - one arg m:  integer in [1, m]
    - two args:   integer in [m, n]
]]

-- print(math.random()) -- 0.5487... (float)
-- print(math.random(10)) -- 1..10
-- print(math.random(5, 10)) -- 5..10

-------------------------------
--         exp
-------------------------------
--[[
function math.exp(x: number) -> number

    Returns e^x.
]]

-- print(math.exp(0)) -- 1.0
-- print(math.exp(1)) -- 2.718281828459

-------------------------------
--         randomseed
-------------------------------
--[[
function math.randomseed(x?: integer)

    Sets the seed for the pseudo-random generator.
    No return value.
]]

-- math.randomseed(os.time())
-- print(math.random(100)) -- 1..100

-------------------------------
--         ult
-------------------------------
--[[
function math.ult(m: integer, n: integer) -> boolean

    unsigned less than

    NB: Seeing the actual unsigned value is impossible in Lua.
        You have to trust it.

    Returns true if m is less than n when compared as unsigned integers.
]]

-- print(math.ult(1, 2)) -- true
-- print(math.ult(-1, 2)) -- false
-- print(math.ult(-1, math.mininteger)) -- false

-------------------------------
--         deg
-------------------------------
--[[
function math.deg(rad: number) -> number

    Converts radians to degrees.
]]

-- print(math.deg(math.pi)) -- 180.0
-- print(math.deg(math.pi / 2)) -- 90.0

-------------------------------
--         log
-------------------------------
--[[
function math.log(x: number, base?: number) -> number

    Returns the logarithm of x.

    - no base: natural logarithm (base e)
    - with base: logarithm in that base (Lua 5.3+)
]]

-- print(math.log(1)) -- 0.0
-- print(math.log(math.exp(1))) -- 1.0
-- print(math.log(100, 10)) -- 2.0

-------------------------------
--         huge
-------------------------------
--[[
math.huge: number

    The value HUGE_VAL (infinity).
    Constant, not a function.
]]

-- print(math.huge) -- inf
-- print(1 / math.huge) -- 0.0

-------------------------------
--         cos
-------------------------------
--[[
function math.cos(x: number) -> number

    Returns the cosine of x (x in radians).
]]

-- print(math.cos(0)) -- 1.0
-- print(math.cos(math.pi)) -- -1.0

-------------------------------
--         acos
-------------------------------
--[[
function math.acos(x: number) -> number

    Returns the arc cosine of x in radians.
]]

-- print(math.acos(1)) -- 0.0
-- print(math.acos(0)) -- 1.5707963267949 (pi/2)

-------------------------------
--         maxinteger
-------------------------------
--[[
math.maxinteger: integer

    The maximum value for an integer.
    Constant, not a function. Lua 5.3+.
]]

-- print(math.maxinteger) -- 9223372036854775807

-------------------------------
--         tan
-------------------------------
--[[
function math.tan(x: number) -> number

    Returns the tangent of x (x in radians).
]]

-- print(math.tan(0)) -- 0.0
-- print(math.tan(math.pi / 4)) -- 1.0

-------------------------------
--         frexp  -- Deprecated
-------------------------------
--[[
function math.frexp(x: number) -> number, integer

    frexp = fraction exponent = split number into mantissa and exponent

    Returns m and e such that x = m * 2^e.
    m is in [0.5, 1).
]]

-- print(math.frexp(8)) -- 0.5    4

-------------------------------
--         min
-------------------------------
--[[
function math.min(x: number, ...number) -> number

    Returns the minimum value among its arguments.
]]

-- print(math.min(1, 5, 3)) -- 1
-- print(math.min(-1, -5, -3)) -- -5

-------------------------------
--         tointeger
-------------------------------
--[[
function math.tointeger(x: any) -> integer? | nil

    If x is convertible to an integer, returns that integer.
]]

-- print(math.tointeger(3.0)) -- 3
-- print(math.tointeger(3.5)) -- nil
-- print(math.tointeger("3")) -- 3

-------------------------------
--         sin
-------------------------------
--[[
function math.sin(x: number) -> number

    Returns the sine of x (x in radians).
]]

-- print(math.sin(0)) -- 0.0
-- print(math.sin(math.pi / 2)) -- 1.0

-------------------------------
--         atan2 - Deprecated
-------------------------------
--[[
function math.atan2(y: number, x: number) -> number

    Returns the arc tangent of y/x in radians, using signs
    to determine the quadrant.
    Deprecated in 5.3 (use math.atan(y, x)).
]]

-- print(math.atan2(1, 1)) -- 0.78539816339745
-- print(math.atan2(1, -1)) -- 2.3561944901923

-------------------------------
--         sinh - Deprecated
-------------------------------
--[[
function math.sinh(x: number) -> number

    Returns the hyperbolic sine of x.
]]

-- print(math.sinh(0)) -- 0.0
-- print(math.sinh(1)) -- 1.1752011936438

-------------------------------
--         sqrt
-------------------------------
--[[
function math.sqrt(x: number) -> number

    Returns the square root of x.
]]

-- print(math.sqrt(4)) -- 2.0
-- print(math.sqrt(2)) -- 1.4142135623731

-------------------------------
--         type
-------------------------------
--[[
function math.type(x: any) -> "integer" | "float" | nil

    Returns "integer" if x is an integer,
    "float" if x is a float,
    nil if x is not a number. Lua 5.3+.
]]

-- print(math.type(3)) -- integer
-- print(math.type(3.0)) -- float
-- print(math.type("3")) -- nil

-------------------------------
--         floor
-------------------------------
--[[
function math.floor(x: number) -> integer

    Returns the largest integer less than or equal to x.
]]

-- print(math.floor(3.7)) -- 3
-- print(math.floor(-3.7)) -- -4

-------------------------------
--         pi
-------------------------------
--[[
math.pi: number

    The value of pi (π).
    Constant, not a function.
]]

-- print(math.pi) -- 3.1415926535898

-------------------------------
--         tanh - Deprecated
-------------------------------
--[[
function math.tanh(x: number) -> number

    Returns the hyperbolic tangent of x.
]]

-- print(math.tanh(0)) -- 0.0
-- print(math.tanh(1)) -- 0.76159415595576

-------------------------------
--         fmod
-------------------------------
--[[
function math.fmod(x: number, y: number) -> number

    floating-point modulo

    Returns the remainder of x/y that rounds the quotient towards zero.
    (Unlike % which rounds towards negative infinity.)
]]

-- print(math.fmod(5, 3)) -- 2.0   (5 - (1 * 3) = 2)
-- print(math.fmod(-5, 3)) -- -2.0  (-5 - (-1 * 3) = -2)

-------------------------------
--         ceil
-------------------------------
--[[
function math.ceil(x: number) -> integer

    Returns the smallest integer greater than or equal to x.
]]

-- print(math.ceil(3.2)) -- 4
-- print(math.ceil(-3.2)) -- -3

-------------------------------
--         asin
-------------------------------
--[[
function math.asin(x: number) -> number

    Returns the arc sine of x in radians.
]]

-- print(math.asin(0)) -- 0.0
-- print(math.asin(1)) -- 1.5707963267949 (pi/2)

-------------------------------
--         pow - Deprecated
-------------------------------
--[[
function math.pow(x: number, y: number) -> number

    Returns x^y.
    Deprecated in 5.3 (use x^y operator).
]]

-- print(math.pow(2, 3)) -- 8.0
-- print(math.pow(4, 0.5)) -- 2.0
-- --
-- print(2 ^ 3) -- 8.0
-- print(4 ^ 0.5) -- 2.0
