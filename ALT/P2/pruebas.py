import sys
from exactcover import exact_cover

# AUTORES:
# (poner aquí el nombre o 2 nombres del equipo de prácticas

def langford_data_structure(N):
    # n1,n2,... means that the value has been used
    # p0,p1,... means that the position has been used
    def value(i):
        return sys.intern(f'n{i}')
    def position(i):
        return sys.intern(f'p{i}')
    # crear la lista de conjuntos que resuelva la
    # secuencia de Langford con exact_cover
    # COMPLETAR
    listaConjuntos = []
    for i in range(1, N+1):
        for j in range(1, 2*N):
            if (j+i) < 2*N-1:
                listaConjuntos.append({position(j-1), position(j+i+1), value(i)})
    #print(listaConjuntos)
    return listaConjuntos


aux = langford_data_structure(4)
print(aux)
print(exact_cover(aux))