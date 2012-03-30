/*
 SYNOPSIS:

 With GCC >= 4.6:
 # gccgo gcd.go -o gcd-go
 # ./gcd-go 11 22 33 44 121

 With Google Go (http://golang.org/):
 # go run gcd.go 11 22 33 44 121
 # or, if you want to play with the binary
 # go build -o gcd-go gcd.go
 # ./gcd-go 11 22 33 44 121

 GCC makes dynamically linked binary,
 but Google Go - statically linked

*/

package main

// Both Google Go and GCC issue an error "imported and not used",
// if imported and not used :-)
import (
	"fmt"
	"os"
	"strconv"
)

func gcd2(a, b uint64) uint64 {
	if b == 0 {
		return a
	}
	/* 6g issues an error "function ends without a return statement",
	   if we use if ... {... return} else {... return}.
	   But GCC doesn't.
	*/
	return gcd2(b, a%b)
}

func gcdn(ns []uint64) (r uint64) {
	for i := range ns {
		r = gcd2(r, ns[i])
	}
	return
}

func main() {
	if len(os.Args) == 0 {
		return
	}
	var ns []uint64 // We have garbage collector!
	for _, arg := range os.Args {
		// Drop the second return value (error code):
		v, _ := strconv.ParseUint(arg, 0, 64)
		ns = append(ns, v)
	}
	fmt.Printf("%v\n", gcdn(ns))
}
