# AUTORES:
# Pablo García López

def variacionesRepeticion(elementos, cantidad):
    
    def backtracking(sol):
        if len(sol) == cantidad:
            yield sol.copy()
        else:
            for opcion in elementos:
                sol.append(opcion)
                yield from backtracking(sol)
                sol.pop()

        

    yield from backtracking([])


def permutaciones(elementos):

    def backtracking(sol):
        if len(sol) == len(elementos):
            yield sol.copy()
        else:
            for opcion in elementos:
                if opcion not in sol:
                    sol.append(opcion)
                    yield from backtracking(sol)
                    sol.pop()

    yield from backtracking([])

def combinaciones(elementos, cantidad):

    def backtracking(sol, index):
        if len(sol) == cantidad or len(sol) == len(elementos):
            yield sol.copy()
        else:
            
            for i in range(index, len(elementos)):
                if elementos[i] not in sol:
                    sol.append(elementos[i])
                    yield from backtracking(sol,i)
                    sol.pop()

        

    yield from backtracking([],0)

# COMPLETAR las actividades 1 y 2 para permutaciones y combinaciones
    
if __name__ == "__main__":
    for n in (1,2,3):
        print('Variaciones con repeticion n =',n)
        for x in variacionesRepeticion(['tomate','queso','anchoas'],n):
            print(x)

    # probar las actividades 1 y 2 para permutaciones y combinaciones

    print('Permutaciones')
    for x in permutaciones(['tomate','queso','anchoas']):
        print(x)

    for n in (1,2,3):
        print('Combinaciones n =',n)
        for x in combinaciones(['tomate','queso','anchoas','aceitunas'],n):
            print(x)
