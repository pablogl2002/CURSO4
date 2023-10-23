#EJERCICIO: ALGORITMO BWA-INEXRECUR DE HENG LI Y RICHARD DURBIN
#COMPLETA LAS LINEAS CON EL TAG #COMPLETAR
#INVOCA LA FUNCION "INEXRECUR" RECURSIVAMENTE PARA RESOLVER EL ALGORITMO
#ACUMULA LAS SOLUCIONES OBTENIDAS EN LAS RECURSIONES MEDIANTE LA FUNCIÓN "union"
#Propón un nuevo ejemplo utilizando una secuencia de nucleótidos
#Se entregará el código y un documento de 1-2 páginas donde se explique el
#ejemplo propuesto y sus resultados. Puedes mejorar el código libremente.


C <- function(a) {

  components <- gsub("[[:punct:]]","",X)
  components <- strsplit(components,"")
  components_sorted <- sort(components[[1]])
  idx <- min(which(components_sorted == a))
  C_num <- idx-1
  return(C_num)

}

O <- function(a,i) {

  ## To match with the real algorithm
  i<-i+1

  ## Find coincidences in B vector
  coincidences <- grep(a,B)
  ## Count number of coincidences (i starts at 1)
  counter <- i>=coincidences
  O_num <- length(counter[counter==TRUE])
  return(O_num)

}

INEXRECUR <- function(W,i,z,k,l,sep) {
  #print(paste("i: ",i," z: ",z))
  ## INPUTS
  # W = Subsecuencia a alinear con X
  # i = Posici?n
  # z = Permited errors
  # k = L?mite inferior del intervalo SA
  # l = L?mite superior del intervalo SA
  ## OUTPUTS
  # I = Alineamientos obtenidos

  ######################## TRAZA .txt #########################
  # Creaci?n del vector TRAZA.txt
  if (identical(sep,"")){
    sep<-"-"
    write.table(t(c(" ------------------------------------------------------ ")), file = "TRAZA.txt",
                   append = FALSE, quote = FALSE, sep = " ", eol = "\n",col.names = FALSE,row.names = FALSE)
    write.table(t(c("|    ","INEXRECUR   -  ","by","XAVI","GABRI","AITANA","ALFREDO","    |")), file = "TRAZA.txt",
                   append = TRUE, quote = FALSE, sep = " ", eol = "\n",col.names = FALSE,row.names = FALSE)
    write.table(t(c(" ------------------------------------------------------ ")), file = "TRAZA.txt",
                   append = TRUE, quote = FALSE, sep = " ", eol = "\n",col.names = FALSE,row.names = FALSE)
    write.table(t(c(" ")), file = "TRAZA.txt", append = TRUE, quote = FALSE, sep = " ", eol = "\n",col.names = FALSE,row.names = FALSE)
  }else{
    sep<-append(sep,'-')
  }



  ####################### CUERPO PRINCIPAL ####################

  if (i+1<1){
    if (z<0) {
      return({})
    }
    else
    {
      #print(paste("encuentra resultado positivo ", k, " ",l) )
      result <- list(c(k,l))
      write.table(t(c(paste("?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?->"," [",result,"]"))), file = "TRAZA.txt",
                     append = TRUE, quote = FALSE, sep = " ", eol = "\n",col.names = FALSE,row.names = FALSE)
      return(result)
    }
  }
  if (z<D[i+1]) {
    return({})
  }

  I <- {}

  write.table(t(c(sep,"D",paste("   [",W[[1]][i+1],"]    "),i-1,z-1,k,l)), file = "TRAZA.txt", append = TRUE, quote = FALSE,
                 sep = "    ",eol = "\n",col.names = FALSE,row.names = FALSE)

  I <- union(I,INEXRECUR(W,i-1,z-1,k,l,sep))  #COMP DELECION


  for (bi in b){
    ki <- C(bi) + O(bi,k-1) + 1  #Precalculate C and O function
    li <- C(bi) + O(bi,l)  #Precalculate C and O function
    if (ki<=li){
      write.table(t(c(sep,"I",paste("   [",bi,"]    "),i,z-1,ki,li)), file = "TRAZA.txt", append = TRUE, quote = FALSE,
                     sep = "    ", eol = "\n",col.names = FALSE,row.names = FALSE)
      I <- union(I,INEXRECUR(W,i,z-1,k,l,sep))  #COMP INSERCION
      if (bi==W[[1]][i+1]){
        write.table(t(c(sep,"M",paste("   [",W[[1]][i+1],"]    "),i-1,z,ki,li)), file = "TRAZA.txt", append = TRUE,
                       quote = FALSE, sep = "    ",eol = "\n",col.names = FALSE,row.names = FALSE)
        I <- union(I,INEXRECUR(W,i-1,z,ki,li,sep))  #COMP MATCH
      }else{
        write.table(t(c(sep,"S",paste("[",bi,"->",W[[1]][i+1],"]"),i-1,z-1,ki,li)), file = "TRAZA.txt", append = TRUE,
                       quote = FALSE, sep = "    ",eol = "\n",col.names = FALSE,row.names = FALSE)
        I <- union(I,INEXRECUR(W,i-1,z-1,ki,li,sep))  #COMP SUSTITUCION
      }
    }
  }
  return(I)

} #end INEXRECUR

#ejemplo con busqueda de W="lol" en X="googol$"
#X <- "googol$"
X <- "TTGAAGAAGCAGGCTGCCATGTTGCAAGCTGCCTCATGGAGGGGATCAGCTGCGAGGAGCTAAGAGCCCC$"

#### OBTENER SUFIXARRAY DE X

SA_pre <- c()
SA_pre[1] <- X
for (i in 2:nchar(X)){
  SA_pre[i] <- paste(substring(X,i,nchar(X)),substring(X,1,i-1),sep='',collapse=NULL)
}
SA_list<-sort(SA_pre,index.return=TRUE)
SA<-SA_list$x
S<-SA_list$ix
B<-paste(substring(SA,nchar(X),nchar(X)),sep='',collapse=NULL)


########################## INPUTS ###########################

#ALFABETO
#b <- c("g","l","o")

D <- c(0,0,1)
W=list(c("l","o","l"))
i=2
z=1
INEXRECUR(W,i,z,0,6,"")

D <- c(0,0,0)
W=list(c("g","o","l"))
i=2
z=0
INEXRECUR(W,i,z,0,6,"")

D <- c(0,0,0,0)
W=list(c("g","o","o","g"))
i=3
z=0
INEXRECUR(W,i,z,0,6,"")

D <- c(0,0,0,1)
W=list(c("g","o","o","l"))
i=3
z=1
INEXRECUR(W,i,z,0,6,"")


# ejemplo nuevo

b <- c("A","C","G","T")
D <- c(0,0,1,1)
W=list(c("C","A","T","A"))
i=3
z=1
INEXRECUR(W,i,z,0,6,"")
