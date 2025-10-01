.data
arreglo:    .word  4, 14, 62, 32, 12, 23, 14, 4
n:          .word 8
msg1:       .asciiz "Original: "
msg2:       .asciiz "Ordenado: "
espacio:    .asciiz " "
nl:         .asciiz "\n"

.text
main:
    # imprimir mensaje
    li $v0, 4
    la $a0, msg1
    syscall

    # imprimir arreglo original
    la $t0, arreglo
    lw $t1, n
    li $t2, 0         # i = 0
print_orig:
    bge $t2, $t1, fin_print_orig
    sll $t3, $t2, 2
    add $t4, $t0, $t3
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, espacio
    syscall
    addi $t2, $t2, 1
    j print_orig
fin_print_orig:
    li $v0, 4
    la $a0, nl
    syscall

    # ordenar con burbuja (dos bucles)
    lw $t1, n
    addi $t1, $t1, -1   # n-1
    li $t5, 0          # i = 0
outer_loop:
    bge $t5, $t1, fin_sort
    la $t0, arreglo
    li $t6, 0          # j = 0
    lw $t7, n
    sub $t7, $t7, $t5
    addi $t7, $t7, -1
inner_loop:
    bge $t6, $t7, end_inner
    sll $t8, $t6, 2
    add $t9, $t0, $t8
    lw $t2, 0($t9)
    lw $t3, 4($t9)
    ble $t2, $t3, no_swap
    sw $t3, 0($t9)
    sw $t2, 4($t9)
no_swap:
    addi $t6, $t6, 1
    j inner_loop
end_inner:
    addi $t5, $t5, 1
    j outer_loop
fin_sort:

    # imprimir mensaje ordenado
    li $v0, 4
    la $a0, msg2
    syscall

    # imprimir arreglo ordenado
    la $t0, arreglo
    lw $t1, n
    li $t2, 0
print_ord:
    bge $t2, $t1, fin_print_ord
    sll $t3, $t2, 2
    add $t4, $t0, $t3
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, espacio
    syscall
    addi $t2, $t2, 1
    j print_ord
fin_print_ord:
    li $v0, 4
    la $a0, nl
    syscall

    # salir
    li $v0, 10
    syscall
