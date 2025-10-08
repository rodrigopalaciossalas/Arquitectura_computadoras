.data
msgInt:    .asciiz "Ingrese un numero entero: "
msgFloat:  .asciiz "Ingrese un numero float: "
msgRes:    .asciiz "El resultado (entero convertido + float) es: "

.text
.globl main
main:
    # Leer un entero
    li $v0, 4
    la $a0, msgInt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # guardar entero en t0

    # Pasar entero al coprocesador y convertir a float
    mtc1 $t0, $f4
    cvt.s.w $f4, $f4        # ahora f4 tiene el entero en float

    # Leer un float
    li $v0, 4
    la $a0, msgFloat
    syscall

    li $v0, 6
    syscall                 # float leido en f0
    mov.s $f6, $f0          # guardar en f6

    # Sumar entero convertido + float
    add.s $f12, $f4, $f6    # f12 = f4 + f6

    # Imprimir resultado
    li $v0, 4
    la $a0, msgRes
    syscall

    li $v0, 2               # imprimir float (f12)
    syscall

    # Salir
    li $v0, 10
    syscall
