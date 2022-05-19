package stream.tp;

public class Persona implements Comparable<Persona>{
    private String nombre;
    private int edad;
    
    
    String inicialNombre() {
    	return this.nombre.substring(0,1);
    }
    
    boolean empiezaCon(String inicio) {
    	return this.inicialNombre().equals(inicio); 
    }
    
    boolean esMayorA(Persona p) {
    	return this.edad > p.getEdad();
    }
    
	int getEdad() {
		return edad;
	}
	
	void setEdad(int edad) {
		this.edad = edad;
	}
	
	String getNombre() {
		return nombre;
	}
	
	void setNombre(String nombre) {
		this.nombre = nombre;
	}

	@Override
	public int compareTo(Persona p) {
		return this.getEdad() - p.getEdad();
	}
    
    
}
