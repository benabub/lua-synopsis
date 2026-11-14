--[[
Character classes:
  .   all characters
  %a  letters
  %c  control characters
  %d  digits
  %l  lower case letters
  %p  punctuation characters
  %s  space characters
  %u  upper case letters
  %w  alphanumeric characters
  %x  hexadecimal digits
  %z  the character with representation 0 (NUL)

Negation (uppercase = NOT):
  %A  non-letters
  %C  non-control
  %D  non-digits
  %L  non-lowercase
  %P  non-punctuation
  %S  non-space
  %U  non-uppercase
  %W  non-alphanumeric
  %X  non-hex

Magic characters (escape with %):
  ( ) . % + - * ? [ ^ $

Quantifiers:
  +   1 or more (greedy)
  *   0 or more (greedy)
  -   0 or more (lazy)
  ?   0 or 1

Anchors:
  ^   start of string
  $   end of string

Captures:
  (...)   capture a substring
  ()      capture a position (number)

Backreference:
  %1 ... %9   match the same text as the n-th capture

Special patterns:
  %bxy        balanced pair (e.g. %b() for brackets)
  %f[set]     frontier pattern (boundary)

In gsub replacement string:
  %0   whole match
  %1..%9   captured groups
]]
