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
