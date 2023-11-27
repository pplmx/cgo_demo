package main

/*
#cgo CFLAGS: -I ${SRCDIR}/lib
#cgo LDFLAGS: -L ${SRCDIR}/lib -l hi -l stdc++
#include "hi.h"
*/
import "C"

func main() {
	C.print_hi()
}
