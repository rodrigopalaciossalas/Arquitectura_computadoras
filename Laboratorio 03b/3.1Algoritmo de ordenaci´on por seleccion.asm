.data
arreglo1:       .word 64, 34, 25, 12, 22, 11, 90, 25
txt1:           .asciiz "Antes: "
txt2:           .asciiz "Despues: "
esp:            .asciiz " "
enter:          .asciiz "\n"

.text
.globl main

main:
    # imprimir antes
    li $v0, 4
    la $a0, txt1
    syscall
    
    la $a0, arreglo1
    li $a1, 8
    jal mostrarDatos
    
    # ordenar
    la $a0, arreglo1
    li $a1, 8
    jal ordenarBurbuja
    
    # imprimir despues
    li $v0, 4
    la $a0, txt2
    syscall
    
    la $a0, arreglo1
    li $a1, 8
    jal mostrarDatos
    
    li $v0, 10
    syscall

# -------------------------
# ordenarBurbuja
# -------------------------
ordenarBurbuja:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    move $s0, $a0   # base
    move $s1, $a1   # tamaño
    
    li $t0, 0       # i
    
ciclo1:
    bge $t0, $s1, finOrdenar
    
    li $t1, 0       # j
    sub $t2, $s1, $t0
    addi $t2, $t2, -1
    
ciclo2:
    bge $t1, $t2, finCiclo2
    
    sll $t3, $t1, 2
    add $t4, $s0, $t3
    lw $t5, 0($t4)
    lw $t6, 4($t4)
    
    ble $t5, $t6, noCambio
    sw $t6, 0($t4)
    sw $t5, 4($t4)
    
noCambio:
    addi $t1, $t1, 1
    j ciclo2
    
finCiclo2:
    addi $t0, $t0, 1
    j ciclo1
    
finOrdenar:
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# -------------------------
# mostrarDatos
# -------------------------
mostrarDatos:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    move $s0, $a0
    li $t0, 0
    
cicloPrint:
    bge $t0, $a1, finPrint
    
    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $a0, 0($t2)
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, esp
    syscall
    
    addi $t0, $t0, 1
    j cicloPrint
    
finPrint:
    li $v0, 4
    la $a0, enter
    syscall
    
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
