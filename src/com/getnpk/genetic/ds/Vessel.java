package com.getnpk.genetic.ds;
import java.util.ArrayList;

/*
 * Assume that the vessel be in the form of a 2D matrix
 * 
 * */

public class Vessel {

	// Default values to be overridden.
	public static int ROWS = 4;
	public static int COLUMNS = 4;
	public static int GRID_SIZE = ROWS * COLUMNS;
	
	private ArrayList<Stack<Container>> grid;
	
	public Vessel(){
		
		grid = new ArrayList<Stack<Container>>();
	}
	
	public boolean put (Stack stack){
		if (grid.size() == GRID_SIZE)
			return false;
		else{
			grid.add(stack);
			return true;
		}
	}
	
	public ArrayList<Stack<Container>> getStackList(){
		return grid;
	}
	
	/*
	 * Get the entire weight of Vessel.
	 * */
	public int getTotalVesselWeight(){
		int total = 0;
		for (Stack<Container> s : grid){
			total += s.getTotalStackWeight();
		}
		return total;
	}
	
	public String toString(){
		StringBuffer buffer = new StringBuffer();
		buffer.append("Vessel Contents: ");
		buffer.append("\n");
		for ( Stack<Container> stack : this.grid){
			buffer.append(stack);
			buffer.append("\n");
		}
		
		return buffer.toString();
	}
	
}
