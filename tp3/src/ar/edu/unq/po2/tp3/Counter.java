package ar.edu.unq.po2.tp3;

import java.util.ArrayList;
import java.util.List;

public class Counter {
    private List<Integer> numeros = new ArrayList<Integer>();

    public Integer contarPares() {
    	Integer cantidad = 0;
    	for (Integer numero : this.getNumeros()) {
    		if (numero % 2 == 0) {
				cantidad++;
			}
		}
    	
    	return cantidad;
    }
    
    public Integer contarImpares() {
    	Integer cantidad = 0;
    	for (Integer numero : this.getNumeros()) {
			if (numero % 2 != 0) {
				cantidad++;
			}
	    
		}
		return cantidad;
    }
    
    public Integer contarMultiplosDe(Integer nro) {
    	Integer cantidad = 0;
    	for (Integer numero : this.getNumeros()) {
			if (numero % nro == 0) {
				cantidad++;
			}
		}
    	return cantidad;
    }

	private List<Integer> getNumeros() {
		return numeros;
	}

	private void setNumeros(List<Integer> numeros) {
		this.numeros = numeros;
	}

	public Counter addNumber(int i) {
		this.getNumeros().add(i);
		return this;
	}
	
	// 2
	
	public Integer elDeMayorPares(List<Integer> numeros) {
		Integer mayorVisto = 0;
		
		for (Integer nro : numeros) {
			if (cantidadDePares(nro) > cantidadDePares(mayorVisto)) {
				mayorVisto = nro;
			}
		}
				
		return mayorVisto;
	}

	public int cantidadDePares(Integer x) {
		int cantPares = 0;
	    while (x > 0) {
	    	int digito = x % 10;
	    	if (digito % 2 == 0) {
	    		cantPares++;
	    	}
	    	x = x/10;
	    }
	  	return cantPares;
	}
		
}
