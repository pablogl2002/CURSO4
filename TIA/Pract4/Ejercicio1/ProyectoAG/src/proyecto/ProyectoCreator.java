package proyecto;

import java.util.Random;

import org.opt4j.core.genotype.DoubleGenotype;
import org.opt4j.core.problem.Creator;

public class ProyectoCreator implements Creator<DoubleGenotype>
{
	public DoubleGenotype create() 
	{
		// rango de inversion para cada empresa, entre 0 y 10
		DoubleGenotype genotipo = new DoubleGenotype(Data.minInversionPorEmpresa, Data.maxInversionPorEmpresa);
		
		genotipo.init(new Random(), Data.numEmpresas);
		
		return genotipo;
	}
	
}