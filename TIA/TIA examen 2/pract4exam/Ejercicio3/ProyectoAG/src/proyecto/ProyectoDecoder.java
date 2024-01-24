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
		
		fenotipo = reparar(fenotipo);
		
		return fenotipo;
	}
	
	public ArrayList<Double> reparar(ArrayList<Double> fenotipo) {
		
		double aux = Data.maxInversionTotal;
		
		if (fenotipo.get(0) + fenotipo.get(1) != fenotipo.get(20)) {
			fenotipo.set(20, fenotipo.get(0) + fenotipo.get(1));
		}
		
		aux = aux - fenotipo.get(20) * 2;
		
		for(int i = 2; i < fenotipo.size() - 1; i++) {
			double inversion = fenotipo.get(i);
			if (aux - inversion >= 0)
				aux -= inversion;
			else {
				fenotipo.set(i, aux);
				aux = 0;
			}
		}
		
		return fenotipo;
	}
}