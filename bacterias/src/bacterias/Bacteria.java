package bacterias;

public abstract class Bacteria implements Consumidor{
    private int edad;
    
	public Double consumo() {
        Double consumo = this.consumoEspecifico();
        
        if (this.getEdad() > 2) {
        	consumo = consumo / this.getEdad();
        }
        
        return consumo;
    }


	public int getEdad() {
		return edad;
	}


	public void setEdad(int edad) {
		this.edad = edad;
	}
    
	abstract Double consumoEspecifico();
}
