package bacterias;

public class Bacilos extends Bacteria{
    private Double longitud;
    
    public Bacilos(Double longitud, int edad) {
		super();
		this.longitud = longitud;
		this.setEdad(edad);
	}
    
    @Override
	Double consumoEspecifico() {
		return longitud * 3;
	}

	public Double getLongitud() {
		return longitud;
	}

	public void setLongitud(Double longitud) {
		this.longitud = longitud;
	}
    
    
}
