# This program is for Solaris 11 on Intel x86 arch (32 bits).
# Written for GNU Assembler (as) with AT&T syntax

# To make an executable binary:
# gcc -nostdlib gcd-x86-solaris.s -o gcd-x86-solaris
# or
# as gcd-x86-solaris.s -o gcd-x86-solaris.o && \
#    ld gcd-x86-solaris.o -o gcd-x86-solaris

# On 64 bits system:
# gcc -m32 -nostdlib gcd-x86-solaris.s -o gcd-x86-solaris
# or
# as --32 gcd-x86-solaris.s -o gcd-x86-solaris.o && \
#    ld -melf_i386 gcd-x86-solaris.o -o gcd-x86-solaris
#
# To run:
# ./gcd-x86-solaris 11 22 33 121 792
# (output should be 11)


.data

# Buffer for output:
buffer:
    .space 32 # enough for 32 bits integer
buf_end:
    .byte  10 # new line


.text
.globl _start


#  GCD of two numbers.
#    input:  eax, ebx - two numbers
#    output: eax - GCD
#    uses:   eax, ebx, edx
gcd2:
    and %ebx, %ebx # is %ebx == 0 ?
    jz  gcd2_exit  # %ebx == 0, go to exit and return %eax (GCD)
    xor %edx, %edx # set %edx = 0 */
    div %ebx       # divide: %edx:%eax / %ebx, actually: %eax / %ebx
    mov %ebx, %eax # drop quotient in %eax and keep previous %ebx in %eax
    mov %edx, %ebx # put remainder in %ebx
    jmp gcd2
gcd2_exit:
    ret



#  Print an unsigned integer in eax.
#    input: eax - unsigned integer to print
#    uses:  eax, ebx, ecx, edx, edi, buffer
print:
    mov $10,  %ecx # set %ecx = 10 (radix)
    mov $buf_end, %edi

next_digit:
    xor %edx, %edx # set %edx = 0
    div %ecx       # divide: %edx:%eax / %ecx, actually: %eax / %ecx
    # %edx is a remainder (0-9), it fits into %dl
    add  $48, %dl  # get ASCII code: 0 => 48 = '0', 1 => 49 = '1'
    dec %edi       # put remainders going from the end of the buffer
    mov %dl, (%edi)
    # now eax is a quotient
    and %eax, %eax # is quotient == 0 ?
    jnz next_digit # quotient is not 0, go on
    
    # printing the number:
    mov $4,   %eax # syscall `write'
    mov $buf_end, %edx
    sub %edi, %edx # edx is a number of characters to write (buf_end - edi)
    inc %edx       # + new line
    push %edx
    push %edi # first character to write
    push $1   # write to stdout
    push $0   # dummy
    int $0x91 # do syscall (print the number)
    add $16, %esp # clean stack 16 = 4 pushs * 4 bytes (32 bits!)

    ret


#  Convert string into unsigned integer
#    input:  esi - pointer to string
#    output: ebx - unsigned integer
#    uses:   eax, ebx, ecx, edi, direction flag
str2uint:
    xor %ecx, %ecx # it will be the string length
    dec %ecx       # ecx = -1 != 0 for repne
    xor %eax, %eax # search for 0 (%eax = %al = 0)
    mov %esi, %edi
    cld            # Search forward (std - backward)
    repne scasb    # search for 0 (in %al), incrementing edi, decrementing ecx
    not %ecx       # invert ecx to have the string length
    dec %ecx       # minus ending zero

    xor %ebx, %ebx
str2uint_loop:
    lodsb # going forward from esi
    # HINT: assert '0' <= al <= '9'
    lea    (%ebx, %ebx, 4), %ebx # ebx = 4*ebx + ebx = 5*ebx ;-)
    lea -48(%eax, %ebx, 2), %ebx # ebx = 2*ebx + %eax - 48
                                 # ebx is multiplied by 10 each iteration,
                                 # eax-48 will be multiplied at the next iteration ;-)
    loop str2uint_loop
    ret



# Entry point for the program
_start:

    # Access command line, see:
    # http://www.cin.ufpe.br/~if817/arquivos/asmtut/index.html
    # Example: ./gcd-x86-solaris 11 22 33
    pop %ecx # Get the number of command-line options (4)
    pop %esi # Get the pointer to the program name (./gcd-x86-solaris),
    dec %ecx # minus program name
    jz exit  # no arguments are given - exiting

    xor %eax, %eax
gcd_loop:
    pop %esi  # get next command line argument
    # Well, we used all registers, now we DO NEED stack :-)
    push %ecx # save argument counter
    push %eax # save current GCD
    call str2uint # convert string at esi to integer at ebx
    pop %eax  # restore current GCD
    call gcd2 # gcd of eax and ebx (returned by str2uint)
    # now eax is a GCD
    pop %ecx  # restore argument counter
    loop gcd_loop

    call print # print eax with GCD

exit:
    mov $1, %eax  # exit syscall
    push $0       # exit code = 0
    push $0       # dummy
    int $0x91

