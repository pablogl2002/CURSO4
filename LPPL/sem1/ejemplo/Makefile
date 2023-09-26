
######################################################################
###  SEMINARIO 1: PABLO GARCÍA LÓPEZ 4CO21 <pgarlop@etsinf.upv.es> ###
######################################################################

# Directorios de trabajo
SRCDIR = src
INCDIR = include
# Opciones de compilacion
COPT = -Wall
CLIB = -lfl
OBJS = ./pablo.o  ./principal.o 
#
cmc:	$(OBJS)
	gcc  $(OBJS)  -I$(INCDIR)  $(COPT)  $(CLIB) -o cmc
principal.o: $(SRCDIR)/principal.c
	gcc  -I$(INCDIR) $(COPT) -c $(SRCDIR)/principal.c
pablo.o:	pablo.c 
	gcc  -I$(INCDIR) $(COPT) -c pablo.c
pablo.c:	$(SRCDIR)/pablo.l 
	flex -opablo.c $(SRCDIR)/pablo.l 

clean:
	rm -f ./pablo.c ./*.o  
###############################################################################
