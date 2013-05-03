package com.getnpk.genetic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.jgap.Chromosome;
import org.jgap.Configuration;
import org.jgap.DeltaFitnessEvaluator;
import org.jgap.Gene;
import org.jgap.Genotype;
import org.jgap.IChromosome;
import org.jgap.InvalidConfigurationException;
import org.jgap.impl.DefaultConfiguration;
import org.jgap.impl.IntegerGene;
import org.jgap.impl.SwappingMutationOperator;

import com.getnpk.genetic.ds.Container;
import com.getnpk.genetic.ds.LoadFitnessFunction;
import com.getnpk.genetic.ds.Stack;
import com.getnpk.genetic.ds.Vessel;


public class LoadDistributionAppServlet extends HttpServlet {
	
	private static int NUMBER_OF_EVOLUTIONS = 500;
	
	// The size of the population (number of chromosomes in the genotype)    
    private static int SIZE_OF_POPULATION = 50;
    
    private Vessel vessel;
    private Stack<Container> stack;
    
    private ArrayList<Container> container;
    Vessel finalVessel;
    
    /*
    public LoadDistributionAppServlet(){

        initializeVessel();
        try {
			Genotype genotype = configureJGAP();
			evolve(genotype);
		} catch (InvalidConfigurationException e) {
			e.printStackTrace();
		}   
     
    }

	*/
    
	private void initializeVessel() {
		
    	System.out.println(LoadDistributionAppServlet.NUMBER_OF_EVOLUTIONS);
    	System.out.println(LoadDistributionAppServlet.SIZE_OF_POPULATION);
    	System.out.println(Vessel.ROWS);
    	System.out.println(Vessel.COLUMNS);
    	System.out.println(Stack.STACK_MAX_SIZE);
    	
    	
    	Vessel.GRID_SIZE = Vessel.ROWS * Vessel.COLUMNS;
    	
		Random random = new Random();
        int randomNumber;
    	vessel = new Vessel();
    	stack = new Stack<Container>();
    	
    	container = new ArrayList<Container>();
    	
    	for (int i=0 ; i<= Vessel.GRID_SIZE * Stack.STACK_MAX_SIZE; i++){
    	
    		randomNumber = 10 + random.nextInt(100);
    		Container c = new Container(i, randomNumber);
    		container.add(c);
    		
    		if (stack.put(c)){
    			
    		}else{
    			vessel.put(stack);
    			stack = new Stack<Container>();
    			stack.put(c);
    		}
    	}
    	
    	System.out.println("Vessel after Initialization: ");
    	System.out.println(vessel);
	}
    
    
	/**
     * Setup JGAP.
     */
    private Genotype configureJGAP() throws InvalidConfigurationException {
		
    	Configuration.reset();
    	Configuration gaConf = new DefaultConfiguration();
    	
    	
    	// Lower values means a better fitness
		Configuration.resetProperty(Configuration.PROPERTY_FITEVAL_INST);
		gaConf.setFitnessEvaluator(new DeltaFitnessEvaluator());

		/* Only use the swapping operator. 
		 * And the size of the chromosome must remain constant
		 */
		gaConf.getGeneticOperators().clear();
		SwappingMutationOperator swapper = new SwappingMutationOperator(gaConf);
		gaConf.addGeneticOperator(swapper);

        // We are only interested in the most fittest individual
        gaConf.setPreservFittestIndividual(true);
		gaConf.setKeepPopulationSizeConstant(false);

		gaConf.setPopulationSize(SIZE_OF_POPULATION);
        
		/*The number of chromosomes is the number of Containers we have. 
         * Every chromosome represents one Container.
         */
        int chromeSize = Vessel.GRID_SIZE * Stack.STACK_MAX_SIZE;
		Genotype genotype;

		// Setup the structure with which to evolve the solution of the problem.
        // An IntegerGene is used. This gene represents the index of a Container.
		IChromosome sampleChromosome = new Chromosome(gaConf, new IntegerGene(gaConf), chromeSize);
		gaConf.setSampleChromosome(sampleChromosome);
		
        // Setup the fitness function
		LoadFitnessFunction fitnessFunction = new LoadFitnessFunction();
		fitnessFunction.setVessel(this.vessel);
		gaConf.setFitnessFunction(fitnessFunction);

		/* Because the IntegerGenes are initialized randomly, it is neccesary to 
		 * set the values to the index. Values range from 0..total number of containers.
		 */
		genotype = Genotype.randomInitialGenotype(gaConf);
		List chromosomes = genotype.getPopulation().getChromosomes();
        for (Object chromosome : chromosomes) {
            IChromosome chrom = (IChromosome) chromosome;
            for (int j = 0; j < chrom.size(); j++) {
                Gene gene = chrom.getGene(j);
                gene.setAllele(j);
            }
        }
        
		return genotype;
	}
	
    
	private void evolve(Genotype agenotype) {
		// TODO Recheck
    	
		double previousFittest = agenotype.getFittestChromosome().getFitnessValue();
		
		for (int i=0; i< NUMBER_OF_EVOLUTIONS; i++){
			
			// Just to know status
			if (i % 250 == 0)
				System.out.println("Number of Evolutions: " + i);
			
			agenotype.evolve();
			double fittness = agenotype.getFittestChromosome().getFitnessValue();
					
			if (fittness < previousFittest){
				System.out.println("New Fittness: " + fittness);
				previousFittest = fittness;
			}
			
		}
		
		IChromosome fittest = agenotype.getFittestChromosome();
		
		System.out.println("Fittness Value: " + fittest.getFitnessValue());
		
		makeVessel(fittest.getGenes());
	}


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.sendRedirect("welcome.jsp");
	}


	private void makeVessel(Gene[] genes) {

		// TODO CHECK THIS METHOD.
		finalVessel = new Vessel();
		Stack<Container> stack = new Stack<Container>();
		
		for (Gene gene: genes){
	
			int index = (Integer) gene.getAllele();
			int stackId = index / Stack.STACK_MAX_SIZE;
			int containerPos = index % Stack.STACK_MAX_SIZE;
			
			int containerId = this.vessel.getStackList().get(stackId).get().get(containerPos).getId();
			int containerWeight = this.vessel.getStackList().get(stackId).get().get(containerPos).getWeight();
					
			Container c = new Container(containerId, containerWeight);
			if (stack.put(c)){
    			
    		}else{
    			finalVessel.put(stack);
    			stack = new Stack<Container>();
    			stack.put(c);
    		}
			
		}
		
		System.out.println("Final suggestions: ");
		System.out.println(finalVessel);
		
		
	}

	
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	
    	LoadDistributionAppServlet.NUMBER_OF_EVOLUTIONS = Integer.parseInt(req.getParameter("evolutions"));
    	LoadDistributionAppServlet.SIZE_OF_POPULATION = Integer.parseInt(req.getParameter("population"));
    	Vessel.ROWS = Integer.parseInt(req.getParameter("width"));
    	Vessel.COLUMNS = Integer.parseInt(req.getParameter("breadth"));
    	
    	
    	//new LoadDistributionAppServlet();

        initializeVessel();
        try {
   			Genotype genotype = configureJGAP();
   			evolve(genotype);
   		} catch (InvalidConfigurationException e) {
   			e.printStackTrace();
   		}   
    	
    	req.setAttribute("final", finalVessel);
    	RequestDispatcher rd = req.getRequestDispatcher("display.jsp");
    	try {
			rd.forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		}
    	
    	//resp.sendRedirect("index.html");
    	//resp.getWriter().println(finalVessel);
    }
}