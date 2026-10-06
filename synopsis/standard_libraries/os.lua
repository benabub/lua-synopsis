-- for k, _ in pairs(_G.os) do
-- 	print(k)
-- end

--[[
setlocale
remove
rename
time
date
execute
getenv
difftime
exit
clock
tmpname
]]

-------------------------------
--         setlocale
-------------------------------
--[[
function os.setlocale(locale?: string, category?: string) -> string? | nil

    NB: low-level. Rarely needed in scripts.
    Not lua metadata, but setting for C-interpreter

    Sets the current locale of the program.

    locale  - locale name (e.g. "en_US.UTF-8") or "" for native, nil to query
    category - "all" (default), "collate", "ctype", "monetary",
               "numeric", or "time"

    Returns the name of the new locale, or nil if not available.
]]

-- print(os.setlocale("C")) -- C
-- print(os.setlocale(nil, "numeric")) -- C (current numeric locale)

-------------------------------
--         remove
-------------------------------
--[[
function os.remove(filename: string) -> true? | nil, string?

    Deletes the file with the given name.

    - Takes both absolute & relative paths (relative to cwd, not to the script)
    - On success returns true.
    - On failure returns nil plus an error message.
    - Also works on empty directories on POSIX systems.
]]

-- local ok, err = os.remove("not_existig.txt")
-- print(ok, err) -- nil	test.txt: No such file or directory

-------------------------------
--         rename
-------------------------------
--[[
function os.rename(oldname: string, newname: string) -> true? | nil, string?

    Renames the file or directory from oldname to newname.

    - On success returns true.
    - On failure returns nil plus an error message.
]]

-- local ok, err = os.rename("not_existig.txt", "new.txt")
-- print(ok, err) -- nil	No such file or directory

-------------------------------
--         time
-------------------------------
--[[
function os.time(table?: table) -> integer

    Returns the current time as a number (Unix timestamp).

    Unix timestamp - count of seconds since 1.01.1970 - 00:00 UTC

    table - optional table with fields: year, month, day, hour, min, sec, isdst
            (if given, returns the timestamp for that date)

    NB: needed for time calculations.
]]

-- print(os.time()) -- 1726598400 (current Unix time)
-- local t = os.time({ year = 2024, month = 1, day = 15 })
-- print(t) -- 1705276800
-- print(os.date("%Y-%m-%d", t)) --  2024-01-15

-------------------------------
--         date
-------------------------------
--[[
function os.date(format?: string, time?: integer) -> string | table

    Returns a string or table representing the date and time.

    format - strftime-like format string (default: "%c")
             if starts with "!", time is formatted as UTC
             if format is "*t", returns a table
    time   - Unix timestamp (default: current time)

    NB: needed for formatting dates.
]]

-- print(os.date()) -- Fri Sep 18 10:49:35 2026
-- print(os.date("%Y-%m-%d")) -- 2026-09-18
-- print(os.date("!%H:%M:%S")) -- 05:50:12
-- --
-- local t = os.date("*t")
-- print(t) -- table: 0x56524b6ef4c0
-- print(t.year, t.month, t.day) -- 2026	9	18
-- --
-- local t = os.date()
-- print(t) -- Fri Sep 18 10:52:05 2026

-------------------------------
--         execute
-------------------------------
--[[
function os.execute(command?: string) -> true? | nil
  2. "exit" | "signal"
  3. integer

    NB: dangerous. Do not use with untrusted input.

    Executes a shell command.

    - Without argument: checks if a shell is available.
    - Returns:
        true or nil (success/failure)
        "exit" or "signal"
        exit status or signal number
]]

-- print(os.execute("ls -la")) -- true    exit    0
-- --
-- -- total 28
-- -- drwxr-xr-x  5 anuta anuta 4096 Sep 12 11:30 .
-- -- drwxr-xr-x 15 anuta anuta 4096 Aug 18 11:36 ..
-- -- drwxr-xr-x  7 anuta anuta 4096 Sep 18 07:36 .git
-- -- -rw-r--r--  1 anuta anuta  265 Aug 18 11:45 .gitignore
-- -- drwxr-xr-x  5 anuta anuta 4096 Sep 13 11:13 lua_base_synopsis
-- -- -rw-r--r--  1 anuta anuta   37 Sep 12 11:10 .luarc.json
-- -- -rw-r--r--  1 anuta anuta    0 Jul 24  2025 README.md
-- -- drwxr-xr-x  2 anuta anuta 4096 Aug 18 11:44 tests

-------------------------------
--         getenv
-------------------------------
--[[
function os.getenv(varname: string) -> string? | nil

    Returns the value of the environment variable varname,
    or nil if the variable is not defined.

    NB: needed for reading environment config.
]]

-- print(os.getenv("HOME")) -- /home/user
-- print(os.getenv("NOPE")) -- nil

-------------------------------
--         difftime
-------------------------------
--[[
function os.difftime(t2: integer, t1: integer) -> number

    Returns the difference in seconds between t2 and t1 (t2 - t1).

    NB: rarely needed. os.time subtraction works the same.
]]

-- local t1 = os.time()
-- local t2 = t1 + 3600
-- print(os.difftime(t2, t1)) -- 3600.0
-- print(os.difftime(t1, t2)) -- -3600.0

-------------------------------
--         exit
-------------------------------
--[[
function os.exit(code?: boolean|integer, close?: boolean)

    Terminates the host program.

    code  - true = success (0), false = failure (1),
            integer = exit code (default: true)
    close - if true, closes the Lua state (default: false in 5.4)

    NB: dangerous. Ends the program immediately.
]]

-------------------------------
--         clock
-------------------------------
--[[
function os.clock() -> number

    Returns the amount of CPU time used by the program, in seconds.

    NB: needed for benchmarking (CPU time, not wall time).
]]

-- local start = os.clock()
-- for _ = 1, 1e6 do
-- end
-- print(os.clock() - start) -- 0.004447

-------------------------------
--       tmpname
-------------------------------
--[[
function os.tmpname() -> string

    Returns a string with a file name that can be used for a temporary file.

    NB: low-level. Use with care (race conditions possible).
]]

-- print(os.tmpname()) -- /tmp/lua_M4QeD0
