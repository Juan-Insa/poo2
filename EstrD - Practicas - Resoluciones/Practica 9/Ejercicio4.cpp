// Propósito: imprime n veces un string s utilizando iteración.
void printN(int n, string s){
    while(n>0){
        cout << s << endl;
        n--;
    }
}

// Propósito: imprime n veces un string s utilizando recursión.
void printNRec(int n, string s){
    if (n>0){
        cout << s << endl;
        printNRec(n-1,s);
    }
}

// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
// utiliza iteración.
void cuentaRegresiva(int n){
    while(n>0){
        cout << s << endl;
        n--;
    }       
}

// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
// utiliza recursión.
void cuentaRegresivaRec(int n){
    if (n>0){
        cout << s << endl;
        cuentaRegresivaRec(n-1);
    }     
}

// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
// utiliza iteración.
void desdeCeroHastaN(int n){
    for(i=0; i<=n; i++){
        cout << actual << endl;
        actual++;
    }
}

// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
// utiliza recursion.
void desdeCeroHastaNRec(int n){
    if (actual != n){
        cout << actual << endl;
        desdeCeroHastaNRec(n-1);
    }
}

// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
// utiliza iteración.
int mult(int n, int m){
    int resultado = 0; 
    while(n > 0){
        resultado += m;
        n--;
    }
    return resultado; 
}

// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
// utiliza recursión.
int multRec(int n, int m){
    if (n>0){
        return m + multRec(n-1,m);
    } else {
        return 0;
    }    
}






