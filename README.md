# QuickStart: cgo with mingw static lib on windows

## Preparation

create two files: `hi.c` and `hi.h` in `lib` directory.

As follows:

hi.c:

```c
#include <stdio.h>

void print_hi() {
    printf("Hello, World!\n");
}

```

hi.h:

```cpp
#ifndef HELLO_H
#define HELLO_H

#ifdef __cplusplus
extern "C" {
#endif

void print_hi();

#ifdef __cplusplus
}
#endif

#endif // HELLO_H

```

if you want to use c++ static lib, here is a sample `hi.cpp`:

```cpp
#include <iostream>

void print_hi() {
    std::cout << "hi, from C++\n";
}

```

## build with gcc and ar

```shell
cd lib

# build static for c
gcc -c hi.c -o hi.o
# or cpp
g++ -c hi.cpp -o hi.o

# the same for gcc and g++
ar rcs libhi.a hi.o
```

## go run with c func print_hi

Here is `main.go`:

```go
package main

/*
#cgo CFLAGS: -I ./lib
#cgo windows LDFLAGS: -L ${SRCDIR}/lib -l hi
#include "hi.h"
*/
import "C"

func main() {
	C.print_hi()
}

```
