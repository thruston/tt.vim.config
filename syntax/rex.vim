" Vim Syntax file for Classic Rexx
"
" Toby Thurston -- 21 Apr 2010 
"
" Keep it simple
"
syntax clear

syntax match  rexLiteral "'[^']*'"
syntax match  rexLiteral '"[^"]*"'
syntax match  rexHex     "'[ \x]*'x"
syntax match  rexHex     '"[ \x]*"x'
syntax match  rexBinary  "'[01]*'b"
syntax match  rexBinary  '"[01]*"b'

syntax match  rexConstant "[\.0-9][\.!?_A-Za-z0-9]*"
syntax match  rexNumber   "\<\([0-9]\+\.[0-9]*\)\|\(\.\?[0-9]\+\)\([Ee][-+]\?[0-9]\+\)\?\>"
syntax match  rexSimple   "[!?_A-Za-z][!?_A-Za-z0-9]*"
syntax match  rexCompound "[!?_A-Za-z][!?_A-Za-z0-9]*\.[\.!?_A-Za-z0-9]\+"
syntax match  rexStem     "[!?_A-Za-z][!?_A-Za-z0-9]*\."

syntax match  rexOperator "[-+*/%|&=\><]"
syntax match  rexSpecial  "[,;:)(]"

syntax region rexComment start='/\*' end='\*/' contains=rexComment

syntax keyword rexInstruction address arg call on off name value do to by for forever while until
syntax keyword rexInstruction drop exit if then else interpret iterate leave nop
syntax keyword rexInstruction numeric digits form scientific engineering fuzz options
syntax keyword rexInstruction parse upper linein pull source with var version signal trace
syntax keyword rexInstruction procedure expose push queue return say select when otherwise end

syntax keyword rexBIF abbrev abs address arg b2x bitand bitor bitxor c2d c2x center
syntax keyword rexBIF centre compare condition copies d2c d2x datatype date delstr
syntax keyword rexBIF delword digits errortext form format fuzz insert lastpos left
syntax keyword rexBIF length max min overlay pos queued random reverse right sign
syntax keyword rexBIF sourceline space strip substr subword symbol time trace
syntax keyword rexBIF translate trunc value verify word wordindex wordlength wordpos
syntax keyword rexBIF words x2b x2c x2d xrange changestr countstr 
syntax keyword rexBIF charin charout chars linein lineout lines stream qualify filespec

hi def link rexComment      Comment
hi def link rexNumber       Number
hi def link rexConstant     Constant
hi def link rexLiteral      String
hi def link rexOperator     Operator
hi def link rexSpecial      Special
hi def link rexSimple       Identifier
hi def link rexCompound     Identifier
hi def link rexStem         Identifier
hi def link rexInstruction  Keyword
hi def link rexBIF          Function
                                
let b:current_syntax = "rex"
