## Practica 1 BIO: realizada por Pablo García López ##

# 4.1.2 INTRODUCCION A R

# 1 - asignacion

v1 <- 10.56
v2 <- 3 + rnorm(1)
vector1 <- c(-2, -2, -2)
matriz1 <- matrix(c(v1, v2, 3, 4, 5, 6), nrow = 2, ncol = 3)
matriz1

matriz[1,3] <- -1
matriz[2, ] <- vector1
matriz1 <- edit(matriz1)
ls()

ls(pat="v")

rm(v1)
ls()

rm(list = ls(pat="v"))
gc()
ls()

# 2 - leyendo y escribiendo

frame1 <- read.table(file="datosPrueba.txt")
frame2 <- frame1[1:3,1:10]
write.table(frame2, file = "datosReducido.txt", sep = " ", row.names = FALSE, col.names = FALSE)
file.show("datosReducido.txt")

# 3 - vectores

x <- c(1.1, 2.3, 3.3, 4.4, 5.5, 6.6, 7.7)
x[2]

sample(x,5)

sort(runif(100, min=1, max=5))

x <- rep(1:10, times = 2)
x
unique(x)

# 4 - Cambio de tipos

x <- as.integer(runif(100, min=1, max=5))
xc <- as.character(x)
xn <- as.numeric(xc)
x <- as.integer(runif(100, min=1, max=5))
x[x == 1] <- "A"
x[x == 2] <- "T"
x[x == 3] <- "G"
x[x == 4] <- "C"

paste(x, sep="", collapse="")

# 5 - Busqueda y comparaciones

letters
letters == "c"
which(rep(letters, 2) == "c")

intersect(month.name[1:4], month.name[3:7])

x <- c(month.name[1:4], month.name[3:7])
x[duplicated(x)]
unique(x)

# 6 - Factores

diagnostico <- factor(c("glioblastoma", "glioblastoma", "metastasis", "metastasis", "glioblastoma", "meningioma", "meningioma"))
diagnostico

diagnosticofr <- table(diagnostico)
diagnosticofr


expresion <- c(10.5, 11.4, 5.2, 3.2, 9.3, 1.2, 4.2)
tapply(expresion, diagnostico, mean)


# 7 - Matrices

x <- matrix(1:30, 3, 10, byrow = T)
x <- matrix(1:30, 10, 3, byrow = F)
x[c(1:5), 3]
mean(x[c(1:5), 3])

x[9, 2] <- 50
dim(x)
dim(x) <- c(3, 5, 2)
dim(x)

# 8 - Listas

expresion <- c(10.5, 11.4, 5.2, 3.2, 9.3, 1.2, 4.2)
diagnostico <- factor(c("glioblastoma", "glioblastoma", "metastasis", "metastasis", "glioblastoma", "meningioma", "meningioma"))
corpus <- list(variable = expresion, clase = diagnostico)
corpus$variable
corpus$clase

# 9 - Data frames

frame2 <- data.frame(y1 = rnorm(12), y2 = rnorm(12), y3 = rnorm(12), y4 = rnorm(12))
rownames(frame2) <- month.name[1:12]
names(frame2) <- c("y4", "y3", "y2", "y1")
dim(frame2)

data.frame(frame2[, 2:4])
frame2[1:5, 1:2]
summary(frame2)

x <- 1:10
x <- x[1:12]
frame3 <- data.frame(x, y = 12:1)
is.na(x)

sapply(frame3, mean, na.rm = T)
apply(frame3, 1, mean, na.rm = T)
frame3[is.na(frame3), 1] <- 0
apply(frame3, 1, mean, na.rm = T)

# 10 - Creacion de una funci�n

funcionEjemplo <- function(argumento1, argumento2, argumento3 = 100.5) {
  media <- mean(c(argumento1, argumento2, argumento3))
  mensaje <- paste("La media de:", argumento1, ",\n\t", argumento2,
  "y", argumento3, "es", media)
  print(mensaje)
  return(media)
  }

r <- funcionEjemplo(10, 50, 60)
r

# 11 - Manejo de directorios

dir()
getwd()

# 12 - Representaciones gr�ficas

x <- rnorm(10)
y <- 1:10
z <- 10:1
plot(x, y, main = "Main title", sub = "subtitle", xlab = "x-label", ylab = "y-label")

plot(x, y, type = "p", col = "red", lwd = 4, pch = 3)
abline(h = 5, col = "brown")
abline(v = 0, col = "brown")
lines(x, y, lty = 2)

pie(c(glio = 3, meta = 2, meni = 2, astro = 4), main = "Tumores")



# 4.2.2 BIOCONDUCTOR

library(annotate)
library(geneplotter)
library("hgu95av2.db")
newChrom <- buildChromLocation("hgu95av2.db")
cPlot(newChrom)
data(sample.ExpressionSet)
cColor(featureNames(sample.ExpressionSet), "red", newChrom)

cPlot(newChrom, c("2"), fg = "yellow", scale = "relative")
cColor(featureNames(sample.ExpressionSet), "red", newChrom)
