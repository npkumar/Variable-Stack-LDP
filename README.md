##The Load Distribution Problem

This is a Genetic Algorithm based tool to solve the combinatorial optimization problem of load distribution in aircraft and other vessels used for transporting cargo. The containers that are loaded into a vessel or an aircraft need to be distributed and arranged optimally such that the pressure due to the mass of the containers is uniform across the surface of the vessel. The containers are stored in stacks, so the average weight of all the stacks needs to be similar and within each stack the weights should be ordered in such a way that the heaviest container is at the bottom and the lightest one is at the top, thereby ensuring that none of the containers get damaged.

We can use Genetic Algorithms to solve this problem of arranging a given set of containers along with their corresponding weights in stacks of equal weight. It is an abstraction of the bin-packing problem and its complexity arises from the fact that there are numerous arrangements that might satisfy the given conditions to some extent but a single best solution is hard to find. The users can alter/tune the genetic parameters like number of evolutions, population size, crossover rate and mutation rate to arrive at the best solution.

* **Getting Started**
  - The tool is hosted on GAE and can be accessed at http://iss-ke.appspot.com.  
  - Java based JGAP Genetic Algorithms Package forms the core. http://jgap.sourceforge.net/

* **Contributors**
  - ban.mido22@gmail.com
  - abhimanyu.sarvagyam@gmail.com
  - getnpk@gmail.com

