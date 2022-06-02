package bacterias;

public class Coco extends Bacteria{
	private Double radio;
	
	public Coco(Double radio, int edad) {
		super();
		this.radio = radio;
		this.setEdad(edad);
	}
	
	@Override
	Double consumoEspecifico() {
		return radio * 2;
	}

	Double getRadio() {
		return radio;
	}

	void setRadio(Double radio) {
		this.radio = radio;
	}
	

}
