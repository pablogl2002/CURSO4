# AUTORES:
# Pablo García López

def exact_cover(listaConjuntos, U=None):

    # permitimos que nos pasen U, si no lo hacen lo calculamos:
    if U is None:
        U = set().union(*listaConjuntos) 
    
    def backtracking(sol, cjtAcumulado):
        # COMPLETAR
        # consulta los métodos isdisjoint y union de la clase set,
        # podrías necesitarlos
        if len(sol) == len(listaConjuntos):
            if len(cjtAcumulado) == len(U):
                yield sol.copy()
        else:
            cjt = listaConjuntos[len(sol)]
            if cjtAcumulado.isdisjoint(cjt):
                sol.append(cjt)
                yield from backtracking(sol, cjtAcumulado.union(cjt))
                sol.pop()
            sol.append({})
            yield from backtracking(sol, cjtAcumulado)
            sol.pop()

    yield from backtracking([], set())

if __name__ == "__main__":
    listaConjuntos = [{"casa","coche","gato"},
                      {"casa","bici"},
                      {"bici","perro"},
                      {"boli","gato"},
                      {"coche","gato","bici"},
                      {"casa", "moto"},
                      {"perro", "boli"},
                      {"coche","moto"},
                      {"casa"}]
    for solucion in exact_cover(listaConjuntos):
        print(solucion)
