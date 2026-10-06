-- for k, _ in pairs(_G.io) do
-- 	print(k)
-- end

--[[
lines
tmpfile
stdin
write
input
stdout
stderr
flush
output
popen
close
read
type
open
]]

-------------------------------
--         lines
-------------------------------
--[[
function io.lines(filename?: string, ...string) -> iterator

    Returns an iterator that returns lines from the file.
    If no filename, uses default input file.
    Closes the file automatically at end.

    NB: needed for reading files line by line.
]]

-- for line in io.lines("file.txt") do
-- 	print(line)
-- end
-- --
-- -- A
-- -- B
-- -- C

-------------------------------
--         tmpfile
-------------------------------
--[[
function io.tmpfile() -> file

    Returns a handle for a temporary file, opened in update mode.
    The file is automatically removed when the program ends.
    Location: /tmp/

    NB: rarely needed.
]]

-- local f = io.tmpfile()
-- f:write("test")
-- f:seek("set", 0)
-- print(f:read("a")) -- test

-------------------------------
--         stdin
-------------------------------
--[[
io.stdin: file

    The standard input file.
    Constant, not a function.

    NB: needed only for CLI scripts and pipes.
]]

-- print(io.stdin) -- file (0x...)

-------------------------------
--         write
-------------------------------
--[[
function io.write(...any) -> file

    Writes each argument to the default output file.
    Numbers are converted to strings.

    NB: needed for output.

    io.write writes to io.stdout by default.
    But after io.output(file), it writes to that file.
    Equivalent to io.output():write(...).
]]

-- io.write("hello ", 42, "\n") -- hello 42

-------------------------------
--         input
-------------------------------
--[[
function io.input(file?: string|file) -> file

    Sets or gets the default input file.

    - With argument: sets new default input.
    - Without: returns current default input.

    Only one default input file exists at a time.
    To read from multiple files, use io.open() and work with handles directly.
]]

-- io.input("file.txt")
-- print(io.read("a"))
-- --
-- -- A
-- -- B
-- -- C

-------------------------------
--         stdout
-------------------------------
--[[
io.stdout: file

    The standard output file.
    Constant, not a function.

    NB: needed only for CLI scripts and pipes.
        Not used in Neovim/mpv plugins or embedded Lua.
]]

-- print(io.stdout) -- file (0x...)

-------------------------------
--         stderr
-------------------------------
--[[
io.stderr: file

    The standard error file.
    Constant, not a function.

    NB: needed only for CLI scripts and pipes.
        Not used in Neovim/mpv plugins or embedded Lua.
]]

-- io.stderr:write("error!\n") -- error!

-------------------------------
--         flush
-------------------------------
--[[
function io.flush()

    Saves any written data to the default output file.

    NB: rarely needed (auto-flush usually works).
    NEEDED when output is a pipe/file or on crash.
]]

-- io.write("hello")
-- -- io.flush() -- hello

-------------------------------
--         output
-------------------------------
--[[
function io.output(file?: string|file) -> file

    Sets or gets the default output file.

    - With argument: sets new default output.
    - Without: returns current default output.
]]

-- io.output("file.txt")
-- io.write("hello")

-------------------------------
--         popen
-------------------------------
--[[
function io.popen(prog: string, mode?: string) -> file

    Pipe Open

    Starts prog in a separate process and returns a file handle.

    mode - "r" (read, default) or "w" (write)

    popen = pipe open = open a pipe to a process
    Unlike os.execute, gives access to the process's output/input stream.
    Can save output to a variable and process it.

    NB: dangerous. Do not use with untrusted input.
]]

-- local f = io.popen("ls")
-- print(f:read("a"))
-- f:close()

-------------------------------
--         close
-------------------------------
--[[
function io.close(file?: file)

    Closes file (or default output file).

    If not closed: file stays open until program ends (auto-close).
    But data may be lost if buffer not flushed, and descriptors leak.
    Always close after use.

    NB: needed to free resources.
]]

-- local f = io.open("file.txt", "r")
-- io.close(f)

-------------------------------
--         read
-------------------------------
--[[
function io.read(...string) -> ...any

    Reads from the default input file according to the given formats.

    Formats:
      "l" / "*l" - line (default)
      "L" / "*L" - line with newline
      "n" / "*n" - number
      "a" / "*a" - all
      integer N  - N characters
]]

-- print(io.read()) -- read one line
-- print(io.read("n")) -- read a number

-------------------------------
--         type
-------------------------------
--[[
function io.type(obj: any) -> string? | nil

    Returns:
      "file"  - if obj is an open file
      "closed file" - if closed
      nil     - if not a file
]]

-- print(io.type(io.stdin)) -- file

-------------------------------
--         open
-------------------------------
--[[
function io.open(filename: string, mode?: string) -> file? | nil
  2. string?

    Opens a file in the given mode.

    Modes:
      "r"  - read (default)
      "w"  - write (truncate)
      "a"  - append
      "r+" - read/write
      "w+" - read/write (truncate)
      "a+" - read/append
      "b"  - binary (append to mode)

    Returns file handle on success, nil + error message on failure.

    NB: needed for file operations.
]]

-- local f, err = io.open("file.txt", "r")
-- if f then
-- 	print(f:read("a")) -- hello
-- 	f:close()
-- else
-- 	print("Error:", err)
-- end
