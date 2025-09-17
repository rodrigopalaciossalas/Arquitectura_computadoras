#include <iostream>
#include <bitset>
#include "mult.hpp"
using namespace std;

void mostrarBits ( uint32_t u ) {
    bitset<32> b(u);
    cout << "Signo = " << b[31] 
         << " | Exponente = " << b.to_string().substr(1,8) 
         << " | Fraccion = " << b.to_string().substr(9) << endl ;
}

int main ( ) {
    float a , b ;
    cout << "Ingrese dos numeros flotantes: ";
    cin >> a >> b ;

    uint32_t ua = floatABits ( a ) ;
    uint32_t ub = floatABits ( b ) ;

    cout << "\n=== Entradas ===\n" ;
    cout << "A = " << a << endl ;
    mostrarBits ( ua ) ;
    cout << "B = " << b << endl ;
    mostrarBits ( ub ) ;

    uint32_t r = multiplicar ( a , b ) ;

    cout << "\n=== Resultado ===\n" ;
    cout << "Decimal: " << bitsAFloat ( r ) << endl ;
    cout << "Hexadecimal: " << hex << r << dec << endl ;
    cout << "-------------------------" << endl;
    cout << "           Bits          " << endl ;
    cout << "-------------------------" << endl;
    mostrarBits ( r ) ;
    cout << "\nProceso completado correctamente.\n" ;
    return 0 ;
}
