package com.getnpk.genetic.ds;
/*
 * Custom Load Distribution Fitness Function
 * @author: Nitin Pradeep Kumar
 * 
 * */

import java.util.ArrayList;
import java.util.Random;

import org.jgap.FitnessFunction;
import org.jgap.IChromosome;

public class LoadFitnessFunction extends FitnessFunction{

	private Vessel vessel;
	
	public void setVessel(Vessel vessel){
		this.vessel = vessel;
	}
	
	private int[] indexes;
	
	/*
	 * Fitness function: A lower value implies better results.
	 * Weight should be evenly distributed among stacks in Vessel.
	 * The distribution of weights in Vessel should be more or less uniform.
	 * */
	@Override
	protected double evaluate(IChromosome aSubject) {
		// TODO Verification
		int eval = 0;
		int i = 0;
		
		int totalWeight = vessel.getTotalVesselWeight();
		int totalAverage = totalWeight / Vessel.GRID_SIZE;
		
		indexes = new int[Vessel.GRID_SIZE];
		
		Vessel newVessel = new Vessel();
		Stack<Container> stack = new Stack<Container>();
		
		for (int j=0; j< Vessel.GRID_SIZE * Stack.STACK_MAX_SIZE; j++){
			
			int index = (Integer) aSubject.getGene(j).getAllele();
			
			int stackId = index / Stack.STACK_MAX_SIZE;
			int containerPos = index % Stack.STACK_MAX_SIZE;
			
			int containerId = this.vessel.getStackList().get(stackId).get().get(containerPos).getId();
			int containerWeight = this.vessel.getStackList().get(stackId).get().get(containerPos).getWeight();
					
			Container c = new Container(containerId, containerWeight);
			if (stack.put(c)){
    			
    		}else{
    			newVessel.put(stack);
    			stack = new Stack<Container>();
    			stack.put(c);
    		}
		}
		
		
		ArrayList<Stack<Container>> repo = newVessel.getStackList();
		
		for (Stack<Container> s: repo){
			indexes[i] = Math.abs(totalAverage - (s.getTotalStackWeight() / Stack.STACK_MAX_SIZE));
			i++;
		}
		
		for (int k : indexes)
			eval += k;

		return eval;
		//return 10 + new Random().nextInt(100);
	}

}
