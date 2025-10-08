.data
msgFloatIn:    .asciiz "Ingrese un numero en float: "
msgFloatOut:   .asciiz "\nEl numero en float es: "
msgDoubleIn:   .asciiz "\nIngrese un numero en double: "
msgDoubleOut:  .asciiz "\nEl numero en double es: "

.text
.globl main
main:
    # === Probar lectura e impresion de FLOAT ===
    li $v0, 4
    la $a0, msgFloatIn
    syscall

    li $v0, 6        # leer float
    syscall          # valor en $f0
    mov.s $f12, $f0  # preparar para imprimir

    li $v0, 4
    la $a0, msgFloatOut
    syscall

    li $v0, 2        # imprimir float
    syscall

    # === Probar lectura e impresion de DOUBLE ===
    li $v0, 4
    la $a0, msgDoubleIn
    syscall

    li $v0, 7        # leer double
    syscall          # valor en $f0,$f1
    mov.d $f12, $f0  # preparar para imprimir double

    li $v0, 4
    la $a0, msgDoubleOut
    syscall

    li $v0, 3        # imprimir double
    syscall

    # === Salir del programa ===
    li $v0, 10
    syscall
