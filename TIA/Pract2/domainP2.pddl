(define (domain flota-pract2)
(:requirements :durative-actions :typing :fluents)
(:types dronP dronL paqueteP paqueteL lugar)

(:predicates
    (at ?l - lugar ?x - (either paqueteL paqueteP dronP dronL))
    (in ?d - (either dronL dronP) ?y - (either paqueteL paqueteP))
    (zona-zvr ?a - lugar)
    (punto-recarga ?a - lugar)
    (cargador-ocupado ?a - lugar)
    (sin-paquetes ?d - (either dronL dronP))
)

(:functions
    (distancia ?c1 - lugar ?c2 - lugar)
    (coste-recargas)
    (carga-maxima ?a - (either dronL dronP))
    (carga ?a - (either dronL dronP))
    (velocidad ?a - (either dronL dronP))
    (duracion-recarga ?a - (either dronL dronP))
    (coste-recarga ?a - (either dronL dronP))
    (tiempo-recogida ?a - (either paqueteL paqueteP))
    (tiempo-entrega)   
)

(:durative-action recoger_ligero
    :parameters (?ini - lugar ?p - paqueteL ?d - (either dronL dronP))
    :duration (= ?duration (tiempo-recogida))
    :condition (and 
        (at start (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
        (over all (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
        (at end (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
    )
    :effect (and 
        (at start
            (not (sin-paquetes ?d))
        )
        (at end (and 
            (in ?d ?p)             
            (not (at ?ini ?p))
        ))
    )
)

(:durative-action recoger_pesado
    :parameters (?ini - lugar ?p - paqueteP ?d - dronP)
    :duration (= ?duration (tiempo-recogida))
    :condition (and 
        (at start (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
        (over all (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
        (at end (and
            (at ?ini ?p)
            (at ?ini ?d)
            (sin-paquetes ?d)
        ))
    )
    :effect (and 
        (at start
            (not (sin-paquetes ?d))
        )
        (at end (and 
            (in ?d ?p)             
            (not (at ?ini ?p))
        ))
    )
)

(:durative-action entregar
    :parameters (?fin - lugar ?p - (either paqueteL paqueteP) ?d - (either dronL dronP))
    :duration (= ?duration (tiempo-entrega))
    :condition (and
        (at start (and
            (not(sin-paquetes ?d))
            (at ?fin ?d)
            (in ?d ?p)
        ))
        (over all (and
            (not(sin-paquetes ?d))
            (at ?fin ?d)
            (in ?d ?p)
        ))
        (at end (and
            (not(sin-paquetes ?d))
            (at ?fin ?d)
            (in ?d ?p)
        ))
    )
    
    :effect (and 
        (at start (not (in ?d ?p)))
        (at end (and
            (at ?fin ?p)
            (sin-paquetes ?d)
        ))
    )
)

(:durative-action volar-L
    :parameters (?ini - lugar ?fin - lugar ?d - dronL)
    :duration (= ?duration (/ (distancia ?ini ?fin) (velocidad ?d)))
    :condition (and 
        (at start (and 
            (>=(carga ?d)(distancia ?ini ?fin))
            (at ?ini ?d)
        ))
        (over all (and 
            (at ?ini ?d)
        ))
        (at end (and
            (at ?ini ?d)
        ))
    )

    :effect (and 
        (at start (not (at ?ini ?d)))
        (at end (and 
            (at ?fin ?d)
            (decrease (carga ?d) (distancia ?ini ?fin))
        ))
    )
)

(:durative-action volar-P
    :parameters (?ini - lugar ?fin - lugar ?d - dronP)
    :duration (= ?duration (/ (distancia ?ini ?fin) (velocidad ?d)))
    :condition (and 
        (at start (and 
            (>=(carga ?d)(distancia ?ini ?fin))
            (not(zona-zvr ?fin))
        ))
        (over all (and 
            (not(zona-zvr ?fin))
        ))
        (at end (and 
            (not(zona-zvr ?fin))
        ))
    )
    
    :effect (and 
        (at start (not (at ?ini ?d)))
        (at end (and 
            (at ?fin ?d)
            (decrease (carga ?d) (distancia ?ini ?fin))
        ))
    )
)



; falta comprobar
(:durative-action recargar
    :parameters (?l - lugar ?d - (either dronL dronP) ?p - (either paqueteL paqueteP))
    :duration (= ?duration (duracion-recarga ?d))
    :condition (and 
        (at start (and 
            (at ?l ?d)
            (punto-recarga ?l)
            (not (in ?d ?p)) 
            (not(cargador-ocupado ?l))
            (sin-paquetes ?d)
        ))
        (over all (and 
            (at ?l ?d)
            (punto-recarga ?l)
            (not (in ?d ?p)) 
            (not(cargador-ocupado ?l))
            (sin-paquetes ?d)
        ))
        (at end (and 
            (at ?l ?d)
            (punto-recarga ?l)
            (not (in ?d ?p)) 
            (not(cargador-ocupado ?l))
            (sin-paquetes ?d)
        ))
    )
    :effect (and 
        (at start (and 
            (cargador-ocupado ?l)
        ))
        (at end (and 
            (not (cargador-ocupado ?l))
            (assign (carga ?d) (carga-maxima ?d))
            (increase  (coste-recargas) (coste-recarga ?d))
        ))
    )
)


)