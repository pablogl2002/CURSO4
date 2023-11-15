
matrizProteinas <- readLines("BD.txt")

IDs = matrizProteinas[seq(1,length(matrizProteinas),2)]
seqs = matrizProteinas[seq(2,length(matrizProteinas),2)]

# Expresion regular del motivo en PROSITE: E-x-[KR]-E-x(2)-E-[KR]-[LF]-[LIVMA]-x(2)-Q-N-x-R-x-G-R
?grep
expresionRegular = 'E.[KR]E.{2}E[KR][LF][LIVMA].{2}QN.R.GR'

indices = grep(expresionRegular, seqs)

resultados = character(length(indices)*2)
resultados[seq(1,length(resultados),2)] = IDs[indices]
resultados[seq(2,length(resultados),2)] = seqs[indices]

resultados

writeLines(resultados, "resultados.txt")
