BackTracking <- function(trellisBT)
{
	trellis <- trellisBT$trellis
	backi <- trellisBT$backi
	backj <- trellisBT$backj
	
	pos <- dim(trellis)
	#print(pos)
	while (pos[1]!=1 | pos[2]!=1)
	{
		
		i <- pos[1]
		j <- pos[2]
		inew <- backi[i,j]
		jnew <- backj[i,j]
		cat(i-1,",",j-1," <- \t", inew-1,",",jnew-1,":\t",sep="")
		if(inew==i-1 & jnew==j-1)
		{
			cat(trellis[i,j],"MoS\t", rownames(trellis)[i],colnames(trellis)[j],"\n")
		}
		else if(inew==i & jnew==j-1) #insercion de v[j]
		{
			cat(trellis[i,j],"I\t", "-",colnames(trellis)[j],"\n")
		}
		else if(inew==i-1 & jnew==j) #borrado de u[i]
		{
			cat(trellis[i,j],"B\t", rownames(trellis)[i],"-","\n")
		}
		posNew <- c(inew,jnew)
		pos <- posNew
	}
	#cat(pos[1],pos[2],"\n")x
}


BackTrackingLocal <- function(trellisBT, decisionf=max)
{
	trellis <- trellisBT$trellis
	backi <- trellisBT$backi
	backj <- trellisBT$backj
	
	#busqueda de la posicion con el valor mayor o menor
	pos <- which(trellis==decisionf(trellis), arr.ind=TRUE)
	
	#print(pos)
	while (pos[1]!=1 & pos[2]!=1)
	{
		i <- pos[1]
		j <- pos[2]
		inew <- backi[i,j]
		jnew <- backj[i,j]
		cat(i-1,",",j-1," <- \t", inew-1,",",jnew-1,":\t",sep="")
		if(inew==i-1 & jnew==j-1)
		{
			cat(trellis[i,j],"MoS\t", rownames(trellis)[i],colnames(trellis)[j],"\n")
		}
		else if(inew==i & jnew==j-1) #insercion de v[j]
		{
			cat(trellis[i,j],"I\t", "-",colnames(trellis)[j],"\n")
		}
		else if(inew==i-1 & jnew==j) #borrado de u[i]
		{
			cat(trellis[i,j],"B\t", rownames(trellis)[i],"-","\n")
		}
		else if(inew==1 & jnew==1)
		{
			cat(trellis[i,j],"Ini\t","\n")

		}
		posNew <- c(inew,jnew)
		pos <- posNew
	}
	#cat(pos[1],pos[2],"\n")
}

########################################################################################


#S: Secuencia 1
#R: Secuencia 2
#delta: matriz de puntuaci?n
#decisionf={max,min, ...}, si delta es distancia (min) o puntuacion positiva (max)
NeedlemanWunsch <- function(S,R,delta, decisionf=max, Peor=-Inf)
{
	#cadena u en vertical
	u <- gsub("(.)", "\\1_", S) # inserts '_' between all characters in sequence string (required for step).
	u <- c("-",unlist(strsplit(u, "_", perl=T))) # generates vectorized DNA sequence
	m <- length(u)

	#cadena v en horizontal
	v <- gsub("(.)", "\\1_", R) # inserts '_' between all characters in sequence string (required for step).
	v <- c("-",unlist(strsplit(v, "_", perl=T))) # generates vectorized DNA sequence
	n <- length(v)

	trellis <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))

	backi <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))
	backj <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))

	#IMPORTANTE!!! los vectores comienzan en 1, mientras que en teoria comienzan en 0
	
	#1. borrado de u[i], primera columna
	for (i in 2:m)
	{
		trellis[i,1] <- trellis[i-1,1]+delta[u[i],"-"]
		backi[i,1] <- i-1 
		backj[i,1] <- 1
	}

	#2. insercion de v[j], primera fila
	for (j in 2:n)
	{
		trellis[1,j] <- trellis[1,j-1]+delta["-",v[j]] #COM
		backi[1,j] <- 1 
		backj[1,j] <- j-1
	}

	#vector temporal de costes de las operaciones
	costes <- c(Peor,Peor,Peor)
	names(costes) <- c("MoS", "I", "B")

	#3. caso general
	for (i in 2:m)
	{
		for (j in 2:n)
		{
			#borrado de u[i]
			costes["B"] <- trellis[i-1,j]+delta[u[i],"-"] #COM
			
			#insercion de v[j]
			costes["I"] <- trellis[i,j-1]+delta["-",v[j]] #COM

			#sustitucion o match u[i]==v[j]
			costes["MoS"] <- trellis[i-1,j-1]+delta[u[i],v[j]] #COM
			
			#asignacion de coste
			trellis[i,j] <- decisionf(costes)
			
			#preparacion del backtracking
			operacion <- names(which(costes==trellis[i,j])[1])
			if (operacion=="B")
				{backi[i,j] <- i-1; backj[i,j] <- j;}
			else if (operacion=="I")
				{backi[i,j] <- i; backj[i,j] <- j-1;}
			else if (operacion=="MoS")
				{backi[i,j] <- i-1; backj[i,j] <- j-1;}
			else warning("Operacion no conocida en trellis")

		} #for j
	} #for i

	result <- list()
	result$trellis <- trellis
	result$backi <- backi
	result$backj <- backj
	
	print(result$trellis)
	BackTracking(result)
	return(result)
} #find NW

########################################################################################


#S: Secuencia 1
#R: Secuencia 2
#delta: matriz de puntuaci?n
#decisionf={max,min, ...}, si delta es distancia (min) o puntuacion positiva (max)
SmithWaterman <- function(S,R,delta, decisionf=max,Peor=-Inf) 
  {
	#cadena u en vertical
	u <- gsub("(.)", "\\1_", S) # inserts '_' between all characters in sequence string (required for step).
	u <- c("-",unlist(strsplit(u, "_", perl=T))) # generates vectorized DNA sequence
	m <- length(u)

	#cadena v en horizontal
	v <- gsub("(.)", "\\1_", R) # inserts '_' between all characters in sequence string (required for step).
	v <- c("-",unlist(strsplit(v, "_", perl=T))) # generates vectorized DNA sequence
	n <- length(v)

	trellis <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))

	backi <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))
	backj <- matrix(rep(0,m*n),nrow=m,ncol=n, 
		dimnames=list(u,v))

	#ojo!!! los vectores comienzan en 1 por lo queest?n desplazados para que concuerden las formulas con la teoria

	#vector temporal de costes de las operaciones, volvemos a ponerlos a Inf o -Inf
	costes <- c(Peor,Peor,Peor,0)
	names(costes) <- c("MoS", "I", "B","Ini")

	#borrado de u[i]
	for (i in 2:m)
	{
		costes["B"] <- trellis[i-1,1]+delta[u[i],"-"]

		#asignacion de coste
		trellis[i,1] <- decisionf(costes)

		#preparacion del backtracking
		operacion <- names(which(costes==trellis[i,1])[1])
		if (operacion=="B")
			{backi[i,1] <- i-1; backj[i,1] <- 1;}
		else if (operacion=="Ini")
			{backi[i,1] <- 1; backj[i,1] <- 1;}
		else warning("Operacion no conocida en trellis")

	}

	#vector temporal de costes de las operaciones, volvemos a ponerlos a INF
	costes <- c(Peor,Peor,Peor,0)
	names(costes) <- c("MoS", "I", "B","Ini")

	#insercion de v[j]
	for (j in 2:n)
	{
		costes["I"] <- trellis[i,j-1]+delta["-",v[j]] #COM

		#asignacion de coste
		trellis[1,j] <- decisionf(costes)

		#preparacion del backtracking
		operacion <- names(which(costes==trellis[1,j])[1])
		if (operacion=="B")
			{backi[1,j] <- 1; backj[1,j] <- j-1;}
		else if (operacion=="Ini")
			{backi[1,j] <- 1; backj[1,j] <- 1;}
		else warning("Operacion no conocida en trellis")
	}

	#vector temporal de costes de las operaciones
	costes <- c(Peor,Peor,Peor,0)
	names(costes) <- c("MoS", "I", "B","Ini")

	#caso general
	for (i in 2:m)
	{
		for (j in 2:n)
		{
			#borrado de u[i]
			costes["B"] <- trellis[i-1,j]+delta[u[i],"-"] #COM
			
			#insercion de v[j]
			costes["I"] <- trellis[i,j-1]+delta["-",v[j]] #COM

			#sustitucion o match u[i]==v[j]
			costes["MoS"] <- trellis[i-1,j-1]+delta[u[i],v[j]] #COM
			
			#asignacion de coste
			trellis[i,j] <- decisionf(costes)
			
			#preparacion del backtracking
			operacion <- names(which(costes==trellis[i,j])[1])
			
			if (operacion=="B")
				{backi[i,j] <- i-1; backj[i,j] <- j;}
			else if (operacion=="I")
				{backi[i,j] <- i; backj[i,j] <- j-1;}
			else if (operacion=="MoS")
				{backi[i,j] <- i-1; backj[i,j] <- j-1;}
			else if (operacion=="Ini")
				{backi[i,j] <- 1; backj[i,j] <- 1;}
			else warning("Operacion no conocida en trellis")

		} #for j
	} #for i

	result <- list()
	result$trellis <- trellis
	result$backi <- backi
	result$backj <- backj
	
	print(result$trellis)
	BackTrackingLocal(result) #inicio cambia, pero fin quiza no por meter backi=1 backj=1
	return(result)
} #fin SW


#definicion de la matriz de puntuaci?n
m <- 1
s <- -1
b <- -1 #borrado 0
i <- -1 #insercion 0

delta <- matrix(c(m,s,s,s,b,
		  s,m,s,s,b,
		  s,s,m,s,b,
		  s,s,s,m,b,
		  i,i,i,i,0), 
		  dimnames=list(c("A","T","C","G","-"),
				c("A","T","C","G","-")),
		  nrow=5,ncol=5,byrow=TRUE)

seq1 <- "ATATTTATCG"
seq2 <- "ATTTATCG"
seq3 <- "ATAAAATCTATCG"
seq4 <- "AAAAAAAAAAATATTTATCG"
seq5 <- "CCATATTTATCGAAAAAAAA"
seq6 <- "CCATATTTTTATCGAAAAAAAA"
seq7 <- "AAAAAAAAAAATATTTCTATCG"

print(seq1)
print(seq1)
t11nw <- NeedlemanWunsch(seq1,seq1,delta)
t11sw <- SmithWaterman(seq1,seq1,delta)

print(seq1)
print(seq2)
t12nw <- NeedlemanWunsch(seq1,seq2,delta)
t12sw <- SmithWaterman(seq1,seq2,delta)

print(seq1)
print(seq3)
t13nw <- NeedlemanWunsch(seq1,seq3,delta)
t13sw <- SmithWaterman(seq1,seq3,delta)

print(seq4)
print(seq5)
t45nw <- NeedlemanWunsch(seq4,seq5,delta)
t45sw <- SmithWaterman(seq4,seq5,delta)

print(seq5)
print(seq5)
t55nw <- NeedlemanWunsch(seq5,seq5,delta)
t55sw <- SmithWaterman(seq5,seq5,delta)

print(seq6)
print(seq7)
t67nw <- NeedlemanWunsch(seq6,seq7,delta)
t67sw <- SmithWaterman(seq6,seq7,delta)

aminos <- c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V","B","Z","X","-")

BLOSUM50 <- matrix(c(
  5, -2, -1, -2, -1, -1, -1,  0, -2, -1, -2, -1, -1, -3, -1,  1,  0, -3, -2,  0 ,-2, -1, -1, -5,
 -2,  7, -1, -2, -4,  1,  0, -3,  0, -4, -3,  3, -2, -3, -3, -1, -1, -3, -1, -3, -1,  0, -1, -5,
 -1, -1,  7, 2, -2, 0,  0,  0,  1, -3, -4,  0, -2, -4, -2,  1,  0, -4, -2, -3,  4,  0, -1, -5,
 -2, -2,  2,  8, -4,  0,  2, -1, -1, -4, -4, -1, -4, -5, -1,  0, -1, -5, -3, -4,  5,  1, -1, -5,
 -1, -4, -2, -4, 13, -3, -3, -3, -3, -2, -2, -3, -2, -2, -4, -1, -1, -5, -3, -1, -3, -3, -2, -5,
 -1, 1,  0,  0, -3 , 7,  2, -2,  1, -3, -2,  2, 0, -4, -1,  0, -1, -1, -1, -3 , 0,  4, -1 ,-5,
 -1,  0,  0,  2, -3,  2,  6, -3,  0, -4, -3,  1, -2, -3, -1, -1, -1, -3, -2, -3,  1,  5, -1, -5,
  0, -3,  0, -1, -3, -2, -3,  8, -2, -4, -4, -2, -3, -4, -2,  0, -2, -3, -3, -4, -1, -2, -2, -5,
 -2,  0,  1, -1, -3,  1,  0, -2, 10, -4, -3,  0, -1, -1, -2, -1, -2, -3,  2, -4,  0,  0, -1, -5,
 -1, -4, -3, -4, -2, -3, -4, -4, -4,  5,  2, -3,  2,  0, -3, -3, -1, -3, -1,  4, -4, -3, -1, -5,
 -2, -3, -4, -4, -2, -2, -3, -4, -3,  2,  5, -3,  3,  1, -4, -3, -1, -2, -1,  1, -4, -3, -1, -5,
 -1,  3,  0, -1, -3,  2,  1, -2,  0, -3, -3,  6, -2, -4, -1,  0, -1, -3, -2, -3,  0,  1, -1, -5,
 -1, -2, -2, -4, -2,  0, -2, -3, -1,  2,  3, -2,  7,  0, -3, -2, -1, -1,  0,  1, -3, -1, -1, -5,
 -3, -3, -4, -5, -2, -4, -3, -4, -1,  0,  1, -4,  0,  8, -4, -3, -2,  1,  4, -1, -4, -4, -2, -5,
 -1, -3, -2, -1, -4, -1, -1, -2, -2, -3, -4, -1, -3, -4, 10, -1, -1, -4, -3, -3, -2, -1, -2, -5,
  1, -1,  1,  0, -1,  0, -1,  0, -1, -3, -3,  0, -2, -3, -1,  5,  2, -4, -2, -2,  0,  0, -1, -5,
  0, -1,  0, -1, -1, -1, -1, -2, -2, -1, -1, -1, -1, -2, -1,  2,  5, -3, -2,  0,  0, -1,  0, -5,
 -3, -3, -4, -5, -5, -1, -3, -3, -3, -3, -2, -3, -1,  1, -4, -4, -3, 15,  2, -3, -5, -2, -3, -5,
 -2, -1, -2, -3, -3, -1, -2, -3,  2, -1, -1, -2,  0,  4, -3, -2, -2,  2,  8, -1, -3, -2, -1, -5,
  0, -3, -3, -4, -1, -3, -3, -4, -4,  4,  1, -3,  1, -1, -3, -2,  0, -3, -1,  5, -4, -3, -1, -5,
 -2, -1,  4,  5, -3,  0,  1, -1,  0, -4, -4,  0, -3, -4, -2,  0,  0, -5, -3, -4,  5,  2, -1, -5,
 -1,  0,  0,  1, -3,  4,  5, -2,  0, -3, -3,  1, -1, -4, -1,  0, -1, -2, -2, -3,  2,  5, -1, -5,
 -1, -1, -1, -1, -2, -1, -1, -2, -1, -1, -1, -1, -1, -2, -2, -1,  0, -3, -1, -1, -1, -1, -1, -5,
 -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5,  1),
 		  dimnames=list(aminos,
				aminos),
		  nrow=length(aminos),ncol=length(aminos),byrow=TRUE)

p1<-c("HEAGAWGHEE")
p2<-c("PAWHEAE")

p12 <- NeedlemanWunsch(p1,p2,BLOSUM50)
p12sw <- SmithWaterman(p1,p2,BLOSUM50)

