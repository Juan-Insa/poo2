package ar.edu.unq.po2.tp3;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CounterTest {
	Counter counter;
	
	@BeforeEach
	public void setUp() throws Exception {
		counter = new Counter();
		
		counter.addNumber(1);
		counter.addNumber(3);
		counter.addNumber(5);
		counter.addNumber(7);
		counter.addNumber(9);
		counter.addNumber(1);
		counter.addNumber(1);
		counter.addNumber(1);
		counter.addNumber(1);
		counter.addNumber(4);
	}
	
	@Test
    public void testUnEvenNumbers() {
		int amount = counter.contarImpares();
		
		assertEquals(amount, 9);
	}
	

	@Test
    public void testEvenNumbers() {
		int amount = counter.contarPares();
		
		assertEquals(amount, 1);
	}
	

	@Test
    public void testMultipleNumbers() {
		int amount = counter.contarMultiplosDe(3);
		
		assertEquals(amount, 2);
	}
	
	@Test
	public void testElDeMayorPares() {
		counter.addNumber(8).addNumber(20).addNumber(12);
	    
	}
	

}
