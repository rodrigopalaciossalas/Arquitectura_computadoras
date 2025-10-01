.data
    arr:        .word 4, 14, 62, 32, 12, 23, 14, 4
    msg_original:   .asciiz "Arreglo original:\n"
    msg_ordenado:   .asciiz "Arreglo ordenado:\n"
    espacio:        .asciiz " "
    salto:          .asciiz "\n"

.text
.globl main

main:
    # Imprimir mensaje
    li $v0, 4
    la $a0, msg_original
    syscall

    # Imprimir arreglo original
    li $a1, 8              # tamaño
    jal imprimir

    # Ordenar con bubble sort
    li $a1, 8              # tamaño
    jal bubble

    # Imprimir mensaje ordenado
    li $v0, 4
    la $a0, msg_ordenado
    syscall

    # Imprimir arreglo ordenado
    li $a1, 8
    jal imprimir

    # Salir
    li $v0, 10
    syscall

###################################
# IMPRIMIR
###################################
imprimir:
    la $t0, arr        # dirección base
    li $t1, 0          # i = 0

print_loop:
    bge $t1, $a1, fin_print

    sll $t2, $t1, 2    # offset = i*4
    add $t3, $t0, $t2
    lw $a0, 0($t3)

    li $v0, 1          # print int
    syscall

    li $v0, 4          # print espacio
    la $a0, espacio
    syscall

    addi $t1, $t1, 1
    j print_loop

fin_print:
    li $v0, 4
    la $a0, salto
    syscall
    jr $ra

###################################
# BUBBLE SORT
###################################
bubble:
    la $t0, arr        # base arr
    move $t5, $a1      # n = tamaño

    li $t1, 0          # i

outer:
    bge $t1, $t5, end_bubble

    li $t2, 0          # j

inner:
    addi $t6, $t5, -1
    sub $t6, $t6, $t1  # n-1-i
    bge $t2, $t6, end_inner

    sll $t7, $t2, 2
    add $t8, $t0, $t7
    lw $t3, 0($t8)     # arr[j]
    lw $t4, 4($t8)     # arr[j+1]

    ble $t3, $t4, no_swap

    sw $t4, 0($t8)
    sw $t3, 4($t8)

no_swap:
    addi $t2, $t2, 1
    j inner

end_inner:
    addi $t1, $t1, 1
    j outer

end_bubble:
    jr $ra
