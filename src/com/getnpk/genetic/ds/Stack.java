package com.getnpk.genetic.ds;
/*
 * @author: nitin pradeep kumar
 * */

import java.util.ArrayList;
import java.util.Collections;

/*
 * Containers are arranged in Stacks of equal size.
 * 
 * */

public class Stack<T extends Container>{
	
	public static int STACK_MAX_SIZE = Integer.MAX_VALUE	;
	
	private ArrayList<T> stack;
	
	public Stack(){
		stack = new ArrayList<T>();
	}
	
	public boolean put(T t){
		if (stack.size() == STACK_MAX_SIZE)
			return false;
		else{
			stack.add(t);
			//Stacks should always have heavier elements at bottom.
			Collections.sort(stack);
			return true;
		}
	}
	
	public ArrayList<T> get(){
		return stack;
	}
	
	/*
	 * Get total weight of all containers
	 * inside the current stack.
	 * */
	public int getTotalStackWeight(){
		
		int sum = 0;
		for (T t: stack){
			sum += t.getWeight();
		}
		return sum;
	}
	
	public int getLength(){
		return stack.size();
	}
	
	public String toString(){
		return String.format("%s", stack);
	}
}