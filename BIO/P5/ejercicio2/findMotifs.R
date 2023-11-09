
matrizProteinas <- readLines("BD.txt")

IDs = matrizProteinas[seq(1,length(matrizProteinas),2)]
seqs = matrizProteinas[seq(2,length(matrizProteinas),2)]

# Expresion regular del motivo en PROSITE: #TODO
?grep
expresionRegular = #TODO

indices = grep(expresionRegular, seqs)

resultados = character(length(indices)*2)
resultados[seq(1,length(resultados),2)] = #TODO
resultados[seq(2,length(resultados),2)] = #TODO

resultados

writeLines(resultados, "resultados.txt")
