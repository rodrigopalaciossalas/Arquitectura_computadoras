.data
    arreglo:    .word 64, 25, 12, 22, 11, 25, 64, 5
    longitud:   .word 8
    msg1:       .asciiz "Arreglo original:\n"
    msg2:       .asciiz "Arreglo ordenado:\n"
    espacio:    .asciiz " "
    salto:      .asciiz "\n"

.text
main:
    # Imprimir mensaje arreglo original
    li $v0, 4
    la $a0, msg1
    syscall

    # Imprimir arreglo antes de ordenar
    jal imprimir

    # Llamar a ordenamiento por selección
    jal ordenar

    # Imprimir mensaje arreglo ordenado
    li $v0, 4
    la $a0, msg2
    syscall

    # Imprimir arreglo ordenado
    jal imprimir

    # Salir
    li $v0, 10
    syscall

##########################################
# IMPRIMIR
##########################################
imprimir:
    lw $t0, longitud         # cantidad de elementos
    la $t1, arreglo          # puntero al inicio
    li $t2, 0                # i = 0

loop_print:
    bge $t2, $t0, fin_print  # si i >= longitud -> fin

    # dirección del elemento
    sll $t3, $t2, 2
    add $t4, $t1, $t3
    lw $a0, 0($t4)

    # imprimir número
    li $v0, 1
    syscall

    # imprimir espacio
    li $v0, 4
    la $a0, espacio
    syscall

    addi $t2, $t2, 1
    j loop_print

fin_print:
    # salto de línea
    li $v0, 4
    la $a0, salto
    syscall
    jr $ra

##########################################
# ORDENAR (SELECCIÓN)
##########################################
ordenar:
    lw $t0, longitud
    addi $t0, $t0, -1       # hasta n-1
    la $t1, arreglo         # base array
    li $t2, 0               # i

outer:
    bge $t2, $t0, fin_ord   # fin si i >= n-1

    # max_index = i
    move $t3, $t2

    # j = i+1
    addi $t4, $t2, 1

inner:
    lw $t5, longitud
    bge $t4, $t5, fin_inner

    # arr[j]
    sll $t6, $t4, 2
    add $t7, $t1, $t6
    lw $t8, 0($t7)

    # arr[max_index]
    sll $t9, $t3, 2
    add $s0, $t1, $t9
    lw $s1, 0($s0)

    ble $t8, $s1, no_update
    move $t3, $t4           # max_index = j
no_update:
    addi $t4, $t4, 1
    j inner

fin_inner:
    # swap arr[i] <-> arr[max_index]
    sll $t6, $t2, 2
    add $t7, $t1, $t6
    lw $s2, 0($t7)          # temp = arr[i]

    sll $t6, $t3, 2
    add $t9, $t1, $t6
    lw $s3, 0($t9)          # arr[max]

    sw $s3, 0($t7)          # arr[i] = arr[max]
    sw $s2, 0($t9)          # arr[max] = temp

    addi $t2, $t2, 1
    j outer

fin_ord:
    jr $ra
