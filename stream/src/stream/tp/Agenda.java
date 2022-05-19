package stream.tp;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import java.util.stream.Stream;

public class Agenda {
    List<Persona> personas = new ArrayList<Persona>();
    
    boolean algunoEmpiezaCon(String inicio) {
    	Stream<Persona> personas = this.personas.stream();
    	return personas.anyMatch(p -> p.inicialNombre().equals(inicio));
    }
    
    List<Persona> nombresQueEmpiezanCon(String inicio){
    	Stream<Persona> personas = this.personas.stream();
    	return personas.filter(p -> p.empiezaCon(inicio)).collect(Collectors.toList());
    }
    
    List<String> nombresParaImprimir(){
    	Stream<Persona> personas = this.personas.stream();
        return personas.map(p -> p.getNombre()).collect(Collectors.toList());
    }
    
    int sumaDeEdades() {
    	Stream<Persona> personas = this.personas.stream();
    	return personas.mapToInt(p -> p.getEdad()).reduce(0, (acumulado, nuevo) -> acumulado + nuevo);
    }
    
    Stream<Persona> ordenar(){
    	Stream<Persona> personas = this.personas.stream();
    	return personas.sorted();
    }
}
