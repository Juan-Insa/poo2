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
// precondición: n es positivo.
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
    for(int i=0; i<=n; i++){
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

// iteración
void primerosN(int n, string s){
    for(int i=0; i > n; i++){
        cout << s[i] << endl;        
    }
}

// recursión
void primerosNRec(int n, string s){
    return caracteresHasta(n,s,0);
}

void caracteresHasta(int n, string s, int m){
  if (n<=m){
         cout << s[m] << endl;   
         primerosNRec(n, s, m++);
  }
}

// iteración
bool pertenece(char c, string s){
    int i = 0;
    while(s[i] != null){
        i++;
    }
    return c == s[i];
}

// recursión
bool perteneceRec(char c, string s){
    return belongsRec(c, s, 0);
}

bool belongsRec(char c, string s, int n){
    if(s[n] == null){
        return s[n] == c;
    } else {
        return s[n] == c || belongsRec(c, s, n++);
    }     
}

// iterativo
int apariciones(char c, string s){
    int apariciones = 0;
    for(int i=0; s[i] != null; i++){
        apariciones += unoSi(s[i] == c);
    }
}

int unoSi(bool cond){
       if (cond){
           return 1;
       } else {
           return 0;
       }
}

// recursivo
int aparicionesRec(char c, string s){
    return aparicionesDe(c,s,0);
}

int aparicionesDe(char c, string s, int n){
    if(s[n] == null){
        return unoSi(s[i] == c);
    } else {
        return unoSi(s[i] == c) + aparicionesDe(c,s,n++);
    }
}







