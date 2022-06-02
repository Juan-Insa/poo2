package bacterias;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Poblacion implements Consumidor{
    List<Consumidor> consumidores;
	
	public Poblacion() {
		super();
		this.consumidores = new ArrayList<Consumidor>();
	}

	@Override
	public Double consumo() {
	    List<Double> consumidores = this.consumidores.stream().map(c -> c.consumo()).collect(Collectors.toList());
		
		return consumidores.stream().reduce(0d, (acumulado, nuevo) -> acumulado+nuevo);
	}
    
	void agregarConsumidor(Consumidor c) {
		this.consumidores.add(c);
	}
	
	void eliminarConsumidor(Consumidor c) {
		this.consumidores.remove(c);
	}
	
	Consumidor obtenerConsumidor(int n) {
		return this.consumidores.get(n);
	}
}
