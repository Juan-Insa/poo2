package bacterias;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Barril {
    private int codigo;
    private int anio;
    private List<Consumidor> consumidores;
    
	public Barril(int codigo, int anio) {
		super();
		this.codigo = codigo;
		this.anio = anio;
		this.consumidores = new ArrayList<Consumidor>();
	}
	
	Double consumo() {
		List<Double> consumidores = this.consumidores.stream().map(c -> c.consumo()).collect(Collectors.toList());
		
		return consumidores.stream().reduce(0d, (acumulado, nuevo) -> acumulado+nuevo);
	}
	
	void agregarConsumidor(Consumidor c) {
		this.consumidores.add(c);
	}

	public int getAnio() {
		return anio;
	}

	public void setAnio(int anio) {
		this.anio = anio;
	}

	public int getCodigo() {
		return codigo;
	}

	public List<Consumidor> getConsumidores() {
		return consumidores;
	}
	
	
	
	
    
    
}
