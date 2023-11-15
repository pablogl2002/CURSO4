# leer secuencias y almacenar como tabla
secuencias <- read.table(file = "sequences.txt")

rows = nrow(secuencias) # número de filas
columns = ncol(secuencias) # número de columnas

cad = ""
# se recorren las columnas para saber el simbolo mayoritario de cada columna
for (i in 1:columns) {
  aux <- secuencias[1:rows,i] # se almacena cada columna
  cad <- paste(cad, max(aux), sep='') # se concatena el simbolo mayoritario
}
print(cad)