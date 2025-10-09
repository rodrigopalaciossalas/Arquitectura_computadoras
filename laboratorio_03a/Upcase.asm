.text
.globl __start

__start:
    la   $a0, msg1
    li   $v0, 4
    syscall
    la   $a0, text
    li   $v0, 4
    syscall

    la   $s0, text
    li   $t6, 1
    li   $t7, 0x61
    li   $t8, 0x7A

next_char:
    lb   $t1, 0($s0)
    beq  $t1, $zero, done

    slt  $t2, $t1, $t7
    slt  $t3, $t8, $t1
    or   $t4, $t2, $t3
    bne  $t4, $zero, check_space
    beq  $t6, $zero, cont

    addi $t1, $t1, -32
    sb   $t1, 0($s0)

cont:
    li   $t6, 0
    j    adv

check_space:
    li   $t5, 0x20
    beq  $t1, $t5, setflag
    li   $t5, 0x09
    beq  $t1, $t5, setflag
    li   $t5, 0x0A
    beq  $t1, $t5, setflag
    li   $t5, 0x0D
    beq  $t1, $t5, setflag
    j    adv

setflag:
    li   $t6, 1

adv:
    addi $s0, $s0, 1
    j    next_char

done:
    la   $a0, msg2
    li   $v0, 4
    syscall
    la   $a0, text
    li   $v0, 4
    syscall

    li   $v0, 10
    syscall

.data
text: .asciiz "la cadena original con letras todas minusculas"
msg1: .asciiz "Original : "
msg2: .asciiz "\nUpcased : "
