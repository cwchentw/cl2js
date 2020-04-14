# cl2js

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A utility command to convert Common Lisp to JavaScript with the power of Parenscript.

## System Requirements

* Either Common Lisp implementation
  * [SBCL](http://www.sbcl.org/) (default)
  * [Clozure CL](https://ccl.clozure.com/)
  * [Armed Bear CL](https://common-lisp.net/project/armedbear/)
* [Parenscript](https://common-lisp.net/project/parenscript/)
* (Optional) Wrapper for Armed Bear CL
  * [abclrun](https://github.com/cwchentw/cl-yautils/blob/master/scripts/abclrun)

Our *build* script will download and install Parenscript automatically. Hence, you don't need to manage dependency by yourself.

## Build

### Unix

Compile `cl2js` with SBCL:

```
$ ./build
```

or

```
$ ./build sbcl
```

Alternatively, compile `cl2js` with Clozure CL:

```
$ ./build ccl
```

### Windows

Pending.

## Usage

Assume *source.lisp* is a valid Parenscript source.

Compile *source.lisp* to *output.js*:

```
$ cl2js source.lisp > output.js
```

Later, run *output.js* with Node.js:

```
$ node output.js
```

Run *source.lisp* with Node.js on-the-fly:

```
$ cl2js source.lisp | node
```

## Note

We copy *quicklisp.lisp* [here](https://www.quicklisp.org/beta/).

We copy *cl-yautils.lisp* and wrappers [here](https://github.com/cwchentw/cl-yautils).

## Copyright

Copyright (c) 2020 Michael Chen.

Licensed under MIT.
