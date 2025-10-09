## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl start

start:
    # Imprimir mensaje: "Ingresar n:"
    la   $a0, Fiboprt
    li   $v0, 4
    syscall

    # Leer entero (n)
    li   $v0, 5
    syscall
    move $t8, $v0        # Guardar n en $t8

    # Inicializar primeros términos
    li   $t0, 0          # a = 0
    li   $t1, 1          # b = 1

    # Imprimir "La serie Fibonacci de "
    la   $a0, Fibost1
    li   $v0, 4
    syscall

    # Imprimir n
    move $a0, $t8
    li   $v0, 1
    syscall

    # Imprimir " terminos es: "
    la   $a0, Fibost2
    li   $v0, 4
    syscall

    # Caso especial: si n <= 0 ? terminar
    blez $t8, fin

    # Imprimir primer término "1"
    li   $a0, 1
    li   $v0, 1
    syscall

    # Contador de términos impresos (ya imprimimos 1)
    li   $t4, 1

    # Si n == 1 ? terminar
    beq  $t8, $t4, fin

    # Bucle Fibonacci
loop:
    # Calcular siguiente término: t2 = t0 + t1
    add  $t2, $t0, $t1

    # Imprimir coma
    la   $a0, coma
    li   $v0, 4
    syscall

    # Imprimir término
    move $a0, $t2
    li   $v0, 1
    syscall

    # Actualizar variables
    move $t0, $t1
    move $t1, $t2

    # Aumentar contador
    addi $t4, $t4, 1

    # ¿Ya imprimimos n términos?
    beq  $t4, $t8, fin

    j loop

# Finalizar programa
fin:
    la   $a0, endl
    li   $v0, 4
    syscall

    li   $v0, 10
    syscall


# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar n: "
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"

