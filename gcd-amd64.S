# This program is for amd64 arch (64 bits) running Linux, Solaris or FreeBSD.
# Written for GNU Assembler (as) with AT&T syntax
#
# Synopsis:
#
# $ gcc -nostdlib [-D OS=LINUX] gcd-amd64.S -o gcd-amd64-linux
# or
# $ cpp [-D OS=LINUX] gcd-amd64.S | as -o gcd-amd64-linux.o \
#       && ld gcd-amd64-linux.o -o gcd-amd64-linux
#
#
# $ gcc -nostdlib -D OS=SOLARIS gcd-amd64.S -o gcd-amd64-solaris
# or
# $ cpp -D OS=SOLARIS gcd-amd64.S | gas -64 -o gcd-amd64-solaris.o \
#       && gld -m elf_x86_64_sol2 gcd-amd64-solaris.o -o gcd-amd64-solaris
#
# $ clang -nostdlib -D OS=FREEBSD gcd-amd64.S -o gcd-amd64-freebsd
#

#define LINUX 1
#define SOLARIS 2
#define FREEBSD 3

#ifndef OS
#define OS LINUX
#endif


.data

# Buffer for output:
buffer:
    .space 64 # enough for a 64-bit integer
buf_end:
    .byte  10 # new line


.text
.globl _start


#  GCD of two numbers.
#    input:  rax, rbx - two numbers
#    output: rax - GCD
#    uses:   rax, rbx, rdx
gcd2:
    and %rbx, %rbx # is %rbx == 0 ?
    jz  gcd2_exit  # %rbx == 0, go to exit and return %rax (GCD)
    xor %rdx, %rdx # set %rdx = 0
    div %rbx       # divide: %rdx:%rax / %rbx, actually: %rax / %rbx
    mov %rbx, %rax # drop quotient in %rax and keep prrvious %rbx in %rax
    mov %rdx, %rbx # put remainder in %rbx
    jmp gcd2
gcd2_exit:
    ret



#  Print an unsigned integer in rax.
#    input: rax - unsigned integer to print
#    uses:  rax, rbx, rcx, rdx, rdi, buffer
print:
    mov $10,  %rcx # set %rcx = 10 (radix)
    mov $buf_end, %rsi

next_digit:
    xor %rdx, %rdx # set %rdx = 0
    div %rcx       # divide: %rdx:%rax / %rcx, actually: %rax / %rcx
    # %rdx is a remainder (0-9), it fits into %dl
    add  $48, %dl  # get ASCII code: 0 => 48 = '0', 1 => 49 = '1'
    dec %rsi       # put remainders going from the end of the buffer
    mov %dl, (%rsi)
    # now rax is a quotient
    and %rax, %rax # is quotient == 0 ?
    jnz next_digit # quotient is not 0, go on

    # printing the number:
#if OS == LINUX
    mov $1, %rax # syscall `write'
#elif OS == SOLARIS
    mov $4, %rax # syscall `write'
#elif OS == FREEBSD
    mov $4, %rax # syscall `write'
#else
#error bad OS.
#endif
    mov $1,   %rdi # write to stdout
    mov $buf_end, %rdx
    sub %rsi, %rdx # rdx is a number of characters to write (buf_end - rsi)
    inc %rdx       # + new line
    syscall        # do syscall (print the number at rsi)
    ret


#  Convert string into unsigned integer
#    input:  rsi - pointer to string
#    output: rbx - unsigned integer
#    uses:   rax, rbx, rcx, rdi, direction flag
str2uint:
    xor %rcx, %rcx # it will be the string length
    dec %rcx       # rcx = -1 != 0 for repne
    xor %rax, %rax # search for 0 (%rax = %al = 0)
    mov %rsi, %rdi
    cld            # Search forward (std - backward)
    repne scasb    # search for 0 (in %al), incrementing rdi, decrementing rcx
    not %rcx       # invert rcx to have the string length
    dec %rcx       # minus ending zero

    xor %rbx, %rbx
str2uint_loop:
    lodsb # going forward from rsi
    # HINT: assert '0' <= al <= '9'
    lea    (%rbx, %rbx, 4), %rbx # rbx = 4*rbx + rbx = 5*rbx ;-)
    lea -48(%rax, %rbx, 2), %rbx # rbx = 2*rbx + %rax - 48
                                 # rbx is multiplied by 10 each iteration,
                                 # rax-48 will be multiplied at the next iteration ;-)
    loop str2uint_loop
    ret



# Entry point for the program
_start:

    # Access command line.
    # Example: ./gcd-amd64-linux 11 22 33
#if OS == FREEBSD
    mov %rdi, %rsp
#endif
    pop %rcx # Get the number of command-line options (4)
    pop %rsi # Get the pointer to the program name (./gcd-amd64-linux),
    dec %rcx # minus program name
    jz exit  # no arguments are given - exiting

    xor %rax, %rax
gcd_loop:
    pop %rsi  # get next command line argument
    mov %rcx, %r8 # save argument counter
    mov %rax, %r9 # save current GCD
    call str2uint # convert string at rsi to integer at rbx
    mov %r9, %rax # restore current GCD
    call gcd2 # gcd of rax and rbx (returned by str2uint)
    # now rax is a GCD
    mov %r8, %rcx # restore argument counter
    loop gcd_loop

    call print # print rax with GCD

exit:
#if OS == LINUX
    mov $60, %rax # exit syscall
#elif OS == SOLARIS
    mov $1, %rax  # exit syscall
#elif OS == FREEBSD
    mov $1, %rax  # exit syscall
#else
#error bad OS.
#endif
    xor %rdi, %rdi  # exit code = 0
    syscall

