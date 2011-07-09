# This program is for Linux on Intel x86_64 arch (64 bits).
# Written for GNU Assembler (as) with AT&T syntax

# To make an executable binary:
# gcc -nostdlib gcd-x86_64-linux.s -o gcd-x86_64-linux
# or
# as gcd-x86_64-linux.s -o gcd-x86_64-linux.o && \
#    ld gcd-x86_64-linux.o -o gcd-x86_64-linux


.data

# Buffer for output:
buffer:
    .space 64 # enough for 64 bits integer
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
    jz  gcd2_exit  # %rbx == 0, go to rxit and return %rax (GCD)
    xor %rdx, %rdx # set %rdx = 0 */
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
    mov $buf_end, %rdi

next_digit:
    xor %rdx, %rdx # set %rdx = 0
    div %rcx       # divide: %rdx:%rax / %rcx, actually: %rax / %rcx
    # %rdx is a remainder (0-9), it fits into %dl
    add  $48, %dl  # get ASCII code: 0 => 48 = '0', 1 => 49 = '1'
    dec %rdi       # put remainders going from the end of the buffer
    mov %dl, (%rdi)
    # now rax is a quotient
    and %rax, %rax # is quotient == 0 ?
    jnz next_digit # quotient is not 0, go on
    
    # printing the number:
    mov $4,   %rax # syscall `write'
    mov $1,   %rbx # write to stdout
    mov %rdi, %rcx # first character to write
    mov $buf_end, %rdx
    sub %rdi, %rdx # rdx is a number of characters to write (buf_end - rdi)
    inc %rdx       # + new line
    int $0x80      # do syscall (print the number)

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

    # Access command line, see:
    # http://www.cin.ufpe.br/~if817/arquivos/asmtut/index.html
    # Example: ./gcd-x86_64-linux 11 22 33
    pop %rcx # Get the number of command-line options (4)
    pop %rsi # Get the pointer to the program name (./gcd-x86_64-linux),
    dec %rcx # minus program name
    jz exit  # no arguments are given - rxiting

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
    mov $1,   %rax  # rxit syscall
    xor %rbx, %rbx  # rxit code = 0
    int $0x80

