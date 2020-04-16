# cl2js

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A utility command to convert Common Lisp to JavaScript with the power of Parenscript.

## System Requirements

* Either Common Lisp implementation
  * [SBCL](http://www.sbcl.org/) (default)
  * [Clozure CL](https://ccl.clozure.com/)
  * [Armed Bear CL](https://common-lisp.net/project/armedbear/)
* [Parenscript](https://common-lisp.net/project/parenscript/)

Our *build* script for Unix and *build.bat* for Windows script will download and install Parenscript automatically. Hence, you don't need to manage dependency by yourself.

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

Compile `cl2js.exe` with SBCL:

```
$ .\build.bat
```

or

```
$ .\build.bat sbcl
```

Alternatively, compile `cl2js.exe` with Clozure CL:

```
$ .\build.exe ccl
```

### Java Platform

Alternatively, you may run `jcl2js` on Unix or `jcl2js.bat` on Windows *as-is*.

## Usage

### `cl2js`

*Note: It's cl2js.exe on Windows.*

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

### `jcl2js`

*Note: It's jcl2js.bat on Windows.*

On first run, `jcl2js` will install Parenscript automatically for you:

```
$ jcl2js
```

Later, run `jcl2js` to compile *source.lisp*:

```
$ jcl2js source.lisp > output.js
```

## Note

The version of Armed Bear CL bundled in this repo is 1.6

We copy *quicklisp.lisp* [here](https://www.quicklisp.org/beta/).

We copy *cl-yautils.lisp* and wrappers [here](https://github.com/cwchentw/cl-yautils).

## See Also

[burtonsamograd/sigil](https://github.com/burtonsamograd/sigil)

## Copyright

Copyright (c) 2020 Michael Chen.

Licensed under MIT.
