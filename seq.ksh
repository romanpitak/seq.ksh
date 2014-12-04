#!/usr/bin/ksh
############################################################
#
#               SEQUENCE
#
# This script is an implementation of the seq command
# It prints out a sequence of numbers
#
#      Author : Roman Pitak
#        date : 2011-04-08
# last update : 2011-04-11
#
#############################################################

typeset -i10 INDEX=0
typeset -i10 FIRST=1
typeset -i10 INCREMENT=1
typeset -i10 LAST=1
FORMAT='%g' # format string for printf
SEPARATOR="\n" # separator for the numbers
EQW=0 # equalize width by padding with leading zeroes 

while (( $# ))
do
  case "${1}" in
    -f|--format) # set format string
      if test "${#}" -eq 1; then
        echo "ERROR : \"-f/--format\" needs an argument" 1>&2 ; exit 1
      fi
      FORMAT="${2}"
      shift; shift
      ;;
    -f=*|--format=*) # set format string
      FORMAT=$( echo ${1} | sed -n -e 's/^-f.*=\(.*\)$/\1/p' )
      shift
      ;;
    
    -s|--separator) # set separator
      if test "${#}" -eq 1; then
        echo "ERROR : \"-s/--separator\" needs an argument" 1>&2 ; exit 1
      fi
      SEPARATOR="${2}"
      shift; shift
      ;;
    -s=*|--separator=*) # set separator
      SEPARATOR=$( echo ${1} | sed -n -e 's/^-s.*=\(.*\)$/\1/p' )
      shift
      ;;
      
    -w|--equal-width) # set equal width for all the numbers
      EQW=1
      shift
      ;;
      
    -h|--help)
      echo '
SEQUENCE ( print a sequence of numbers )

SYNOPSIS
    seq [OPTION] LAST                  : print a sequence of numbers from 1 to LAST
    seq [OPTION] FIRST LAST            : print a sequence of numbers from FIRST to LAST
    seq [OPTION] FIRST INCREMENT LAST  : print a sequence of numbers from FIRST to LAST
                                         increment by INCREMENT
DESCRIPTION
   Print numbers from FIRST to LAST, in steps of INCREMENT.

   Mandatory arguments to long options are mandatory for short options too.

OPTIONS:
    -f, --format=FORMAT                : use printf style FORMAT (default: %g)
    -s, --separator=STRING             : use STRING to separate numbers (default: \\n)
    -w, --equal-width                  : equalize width by padding with leading zeroes
    -h, --help                         : display this help and exit

If  FIRST  or INCREMENT is omitted, it defaults to 1.  That is, an omitted INCREMENT defaults to 1 even when LAST is smaller than FIRST.  FIRST, INCREMENT, and LAST are interpreted as floating point values.  INCREMENT is usu‐
ally positive if FIRST is smaller than LAST, and INCREMENT is usually negative if FIRST is greater than LAST.  FORMAT must be suitable for printing one argument of type 'double'; it defaults to %.PRECf  if  FIRST,  INCREMENT,
and LAST are all fixed point decimal numbers with maximum precision PREC, and to %g otherwise.

Implemented by Roman Pitak (roman@pitak.net)
Source available at https://github.com/romanpitak/seq.ksh
'
      exit 0
      ;;
      
    *)
      if test "$( echo ${1} | sed -n -e 's/^\([+-]\{0,1\}[\.0-9]*\)$/\1/p' )" = ""
      then
        echo "ERROR : parameter \"${1}\" must be a number" 1>&2
        exit 1
      fi
      case "$#" in
        1)
          LAST="${1}"
          shift
          ;;
        2)
          FIRST="${1}"
          shift
          ;;
        3)
          FIRST="${1}"
          shift
          INCREMENT="${1}"
          shift
          ;;
        *)
          echo 'ERROR : too many arguments or in wrong order' 1>&2
          exit 1
          ;;
      esac
      ;;
      
  esac
done

# if "-w" is set
test "${EQW}" -eq 1 && FORMAT="%0$( echo length\(${LAST}\) | bc )g" 

if printf "${FORMAT}${SEPARATOR}" "${LAST}" >/dev/null 2>&1
then # if format string is valid
  INDEX="${FIRST}" 
  while ( test "${INDEX}" -le "${LAST}" && test "${INCREMENT}" -gt 0 ) || ( test "${INDEX}" -ge "${LAST}" && test "${INCREMENT}" -lt 0 )
  do
    printf "${FORMAT}${SEPARATOR}" "${INDEX}"
    INDEX=$(( INDEX + INCREMENT ))
  done
  exit 0
else
  echo "ERROR : bad printf FORMAT string" 1>&2
  exit 1
fi
