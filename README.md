# cl2js

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A utility command to convert Common Lisp to JavaScript with the power of Parenscript.

## System Requirements

* Either Common Lisp implementation
  * [SBCL](http://www.sbcl.org/) (default)
  * [Clozure CL](https://ccl.clozure.com/)
  * [Armed Bear CL](https://common-lisp.net/project/armedbear/)
* [Parenscript](https://common-lisp.net/project/parenscript/)
* Wrapper for specific Common Lisp implementation
  * [sbclrun](https://github.com/cwchentw/cl-yautils/blob/master/scripts/sbclrun) (default)
  * [cclrun](https://github.com/cwchentw/cl-yautils/blob/master/scripts/cclrun)
  * [abclrun](https://github.com/cwchentw/cl-yautils/blob/master/scripts/abclrun)

## Install

Just clone the repo locally, setting **PATH** to the local path of the repo.

Keep the scripts in the repo *as-is* for normal use.

## Usage

Assume *source.lisp* is a valid Parenscript source.

Compile it with SBCL:

```
$ cl2js source.lisp > output.js
```

or

```
$ cl2js sbcl source.lisp > output.js
```

Alternatively, compile it with Clozure CL:

```
$ cl2js ccl source.lisp > output.js
```

Alternatively, compile it with Armed Bear CL:

```
$ cl2js abcl source.lisp > output.js
```

Later, run *output.js* with Node.js:

```
$ node output.js
```

Run *source.lisp* with Node.js on-the-fly:

```
$ cl2js source.lisp | node
```

## Known Issues or Bugs

The binary executable generated by *cl2js.lisp* doesn’t work properly.

## Note

We copy *cl-yautils.lisp* and wrappers [here](https://github.com/cwchentw/cl-yautils).

## Copyright

Copyright (c) 2020 Michael Chen.

Licensed under MIT.
