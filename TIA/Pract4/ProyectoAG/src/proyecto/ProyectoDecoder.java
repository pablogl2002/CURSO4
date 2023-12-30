package proyecto;

import java.util.ArrayList;

import org.opt4j.core.genotype.DoubleGenotype;
import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<DoubleGenotype, ArrayList<Double>>
{
	public ArrayList<Double> decode(DoubleGenotype genotipo) 
	{
		ArrayList<Double> fenotipo = new ArrayList<Double>();
		
		for (int i = 0; i < genotipo.size(); i++)
			fenotipo.add(genotipo.get(i));
	
		return fenotipo;
	}
}