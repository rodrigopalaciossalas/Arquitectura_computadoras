.data
msg_ingresar_grado:   .asciiz "Ingrese el grado del polinomio: "
msg_ingresar_coef:    .asciiz "Ingrese el coeficiente c_"
msg_dos_puntos:       .asciiz ": "
msg_ingresar_x:       .asciiz "Ingrese el valor de x (float): "
msg_resultado:        .asciiz "P(x) = "

.text
.globl main

main:
    # Pedir grado del polinomio
    li $v0, 4
    la $a0, msg_ingresar_grado
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          

    # Reservar espacio para los coeficientes
    addi $a0, $t0, 1
    sll $a0, $a0, 2
    li $v0, 9
    syscall
    move $t1, $v0          

    # Leer coeficientes
    li $t2, 0               

leer_coeficientes:
    bgt $t2, $t0, fin_lectura

    li $v0, 4
    la $a0, msg_ingresar_coef
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, msg_dos_puntos
    syscall

    li $v0, 5
    syscall
    sw $v0, 0($t1)

    addi $t1, $t1, 4
    addi $t2, $t2, 1
    j leer_coeficientes

fin_lectura:
    # Pedir x
    li $v0, 4
    la $a0, msg_ingresar_x
    syscall

    li $v0, 6
    syscall
    mov.s $f0, $f0  

    # Evaluar polinomio usando Horner
    la $t1, 0($t1)      
    sll $t3, $t0, 2
    sub $t1, $t1, $t3  

    lw $t4, 0($t1)     
    mtc1 $t4, $f12
    cvt.s.w $f12, $f12

    addi $t5, $t0, -1   

eval_loop:
    blt $t5, 0, fin_eval

    mul.s $f12, $f12, $f0 

    sll $t6, $t5, 2
    add $t7, $t1, $t6
    lw $t8, 0($t7)
    mtc1 $t8, $f4
    cvt.s.w $f4, $f4

    add.s $f12, $f12, $f4  

    addi $t5, $t5, -1
    j eval_loop

fin_eval:
    li $v0, 4
    la $a0, msg_resultado
    syscall

    li $v0, 2
    syscall 

    li $v0, 10
    syscall
