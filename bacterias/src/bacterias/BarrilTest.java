package bacterias;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BarrilTest {
    private Barril barril;
    private Bacteria c, b1, b2, b3;
    private Poblacion p1;
    private Poblacion p2;
    
    
    @BeforeEach
    void setUp() {
    	barril = new Barril(01, 2022);
    	
    	b1 = new Bacilos(2d, 2);
    	b2 = new Bacilos(1d, 1);
    	b3 = new Bacilos(3d, 3);
    	c = new Coco(2d, 1);
    	p1 = new Poblacion();
    	p2 = new Poblacion();
    	
    	p1.agregarConsumidor(c);
    	p1.agregarConsumidor(p2);
    	
    	
    	barril.agregarConsumidor(b1);
    	barril.agregarConsumidor(p1);
    	
    }
    
    
	@Test
	void testConsumo() {
		assertEquals(10d, barril.consumo());;
	}

}
