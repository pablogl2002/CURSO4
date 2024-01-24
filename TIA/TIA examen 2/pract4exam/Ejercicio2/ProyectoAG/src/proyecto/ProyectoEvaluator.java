package proyecto;

import java.util.ArrayList;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Double>>
{

	public Objectives evaluate(ArrayList<Double> fenotipo) 
	{
		double resultado = 0.0;
		//double sumInversion = 0;
		int sumRiesgos = 0;
		
		for (int i = 0; i < fenotipo.size(); i++) 
		{
			/*
			// no hace falta penalizar porque lo reparamos en el decoder
			sumInversion += fenotipo.get(i);
			if (sumInversion > Data.maxInversionTotal) {
				// restriccion de que el maximo de inversion es el 100% de nuestro capital
				resultado = Double.MIN_VALUE;
				sumRiesgos = Integer.MAX_VALUE;
				break;
			}
			*/
			

			if (fenotipo.get(i) > 5) {
				resultado += fenotipo.get(i) * (Data.beneficioEmpresa[i] - Data.beneficioEmpresa[i] * Data.comisionEmpresa[i]);	
			} else {
				resultado += fenotipo.get(i) * Data.beneficioEmpresa[i];				
			}
			
			
			if (fenotipo.get(i) > 0) {
				sumRiesgos += Data.riesgoEmpresa[i];
			}
			
			
		}
		
		// queremos maximizar el beneficio económico
		Objectives objectives = new Objectives();
		objectives.add("Inversion con beneficios-MAX", Sign.MAX, resultado * 100);
		objectives.add("Riesgos-MIN", Sign.MIN, sumRiesgos);
		
		objectives.add("empresa E20", Sign.MAX, fenotipo.get(19));
		objectives.add("empresa E4", Sign.MIN, fenotipo.get(3));
		
		return objectives;
	}

}