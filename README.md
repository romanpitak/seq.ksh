# SEQ (print a sequence of numbers)

(c) 2011-2014 [Roman Piták](http://pitak.net) roman@pitak.net

## SYNOPSIS

    seq [OPTION] LAST                  : print a sequence of numbers from 1 to LAST
    seq [OPTION] FIRST LAST            : print a sequence of numbers from FIRST to LAST
    seq [OPTION] FIRST INCREMENT LAST  : print a sequence of numbers from FIRST to LAST
                                         increment by INCREMENT
## DESCRIPTION

Print numbers from FIRST to LAST, in steps of INCREMENT.

Mandatory arguments to long options are mandatory for short options too.

## OPTIONS:

    -f, --format=FORMAT                : use printf style FORMAT (default: %g)
    -s, --separator=STRING             : use STRING to separate numbers (default: \\n)
    -w, --equal-width                  : equalize width by padding with leading zeroes
    -h, --help                         : display this help and exit

If  FIRST  or INCREMENT is omitted, it defaults to 1. That is, an omitted 
INCREMENT defaults to 1 even when LAST is smaller than FIRST.  FIRST, INCREMENT,
and LAST are interpreted as floating point values.  INCREMENT is usually positive
if FIRST is smaller than LAST, and INCREMENT is usually negative if FIRST 
is greater than LAST.  FORMAT must be suitable for printing one argument 
of type 'double'; it defaults to %.PRECf  if  FIRST,  INCREMENT, and LAST 
are all fixed point decimal numbers with maximum precision PREC, and to %g otherwise.
