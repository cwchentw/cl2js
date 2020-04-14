#!/bin/sh

# Constant
SBCL="sbcl"
CCL="ccl"
ABCL="abcl"

root=$(dirname "$0");

# Check whether the Lisp script is available.
lisp=$1;

if [ "$SBCL" = "$lisp" ] || [ "$CCL" = "$lisp" ] || [ "$ABCL" = "$lisp" ];
then
  # Consume an argument.
  shift;
else
  lisp="$SBCL"
fi

if [ "$SBCL" = "$lisp" ];
then
  # Check whether SBCL and its wrapper is available.
  if ! command -v sbclrun 2>/dev/null 1>&2;
  then
    echo "No sbclrun on the system" >&2;
    exit 1;
  fi

  sbclrun "$root/cl2js.lisp" "$@";
elif [ "$CCL" = "$lisp" ];
then
  # Check whether Clozure CL and its wrapper is available.
  if ! command -v cclrun 2>/dev/null 1>&2;
  then
    echo "No cclrun on the system" >&2;
    exit 1;
  fi

  cclrun "$root/cl2js.lisp" -- "$@";
elif [ "$ABCL" = "$lisp" ];
then
  # Check whether ABCL and its wrapper is available.
  if ! command -v abclrun 2>/dev/null 1>&2;
  then
    echo "No abclrun on the system" >&2;
    exit 1;
  fi

  abclrun "$root/cl2js.lisp" -- "$@";
fi
