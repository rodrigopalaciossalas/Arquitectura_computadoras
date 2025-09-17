#include <iostream>
#include <vector>
using namespace std;

string convertirBitsACadena(const vector<int>& bits) {
    string s;
    for (int b : bits) s += (b ? '1' : '0');
    return s;
}

long long bitsAEntero(const vector<int>& bits) {
    int n = bits.size();
    unsigned long long valor = 0;
    for (int b : bits) valor = (valor << 1) | (unsigned long long)b;
    if (bits[0] == 1) return (long long)valor - (1LL << n);
    return (long long)valor;
}

vector<int> enteroAComplemento2(long long numero, int n) {
    long long minimo = -(1LL << (n-1));
    long long maximo = (1LL << (n-1)) - 1;
    if (numero < minimo || numero > maximo) {
        cerr << "ERROR: El numero " << numero << " no cabe en " << n << " bits." << endl;
        cerr << "Rango permitido: [" << minimo << " .. " << maximo << "]" << endl;
        exit(1);
    }
    unsigned long long representacion;
    if (numero < 0) representacion = (1ULL << n) + numero;
    else representacion = (unsigned long long)numero;
    vector<int> bits(n, 0);
    for (int i = n-1; i >= 0; --i) {
        bits[i] = (int)(representacion & 1ULL);
        representacion >>= 1;
    }
    return bits;
}

vector<int> sumarBinario(const vector<int>& a, const vector<int>& b) {
    int n = a.size();
    vector<int> resultado(n, 0);
    int acarreo = 0;
    for (int i = n-1; i >= 0; --i) {
        int suma = a[i] + b[i] + acarreo;
        resultado[i] = suma & 1;
        acarreo = (suma >> 1) & 1;
    }
    return resultado;
}

vector<int> complementoADos(const vector<int>& bits) {
    int n = bits.size();
    vector<int> invertido(n);
    for (int i = 0; i < n; ++i) invertido[i] = 1 - bits[i];
    vector<int> uno(n, 0);
    uno[n-1] = 1;
    return sumarBinario(invertido, uno);
}

void corrimientoAritmeticoDerecha(vector<int>& A, vector<int>& Q, int& Qm1) {
    int n = A.size();
    vector<int> nuevoA(n), nuevoQ(n);
    nuevoA[0] = A[0];
    for (int i = 1; i < n; ++i) nuevoA[i] = A[i-1];
    nuevoQ[0] = A[n-1];
    for (int i = 1; i < n; ++i) nuevoQ[i] = Q[i-1];
    int nuevoQm1 = Q[n-1];
    A = nuevoA;
    Q = nuevoQ;
    Qm1 = nuevoQm1;
}

void algoritmoBooth(long long mDecimal, long long qDecimal, int n) {
    vector<int> A(n, 0);
    vector<int> M = enteroAComplemento2(mDecimal, n);
    vector<int> Q = enteroAComplemento2(qDecimal, n);
    int Qm1 = 0;

    cout << "Algoritmo de Booth con n=" << n << " bits" << endl;
    cout << "M = " << mDecimal << ", Q = " << qDecimal << endl;
    cout << "Estado inicial: A=" << convertirBitsACadena(A)
         << " Q=" << convertirBitsACadena(Q)
         << " Q-1=" << Qm1 << endl;

    for (int i = 0; i < n; ++i) {
        int Q0 = Q[n-1];
        cout << endl << "Iteracion " << i+1 << ": Q0=" << Q0 << ", Q-1=" << Qm1 << endl;

        if (Q0 == 1 && Qm1 == 0) {
            cout << "  -> A = A - M" << endl;
            A = sumarBinario(A, complementoADos(M));
        } else if (Q0 == 0 && Qm1 == 1) {
            cout << "  -> A = A + M" << endl;
            A = sumarBinario(A, M);
        } else {
            cout << "  -> No se hace nada" << endl;
        }

        cout << "  Antes del corrimiento: A=" << convertirBitsACadena(A)
             << " Q=" << convertirBitsACadena(Q)
             << " Q-1=" << Qm1 << endl;

        corrimientoAritmeticoDerecha(A, Q, Qm1);

        cout << "  Despues del corrimiento: A=" << convertirBitsACadena(A)
             << " Q=" << convertirBitsACadena(Q)
             << " Q-1=" << Qm1 << endl;
    }

    vector<int> resultado;
    resultado.insert(resultado.end(), A.begin(), A.end());
    resultado.insert(resultado.end(), Q.begin(), Q.end());

    cout << endl << "Resultado en bits: " << convertirBitsACadena(resultado) << endl;
    cout << "Resultado en decimal: " << bitsAEntero(resultado) << endl;
}

int main() {
    int n = 4;
    long long M = -3;
    long long Q = 3;
    algoritmoBooth(M, Q, n);
    return 0;
}
