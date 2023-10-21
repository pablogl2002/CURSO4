(define (domain flota-pract2)
(:requirements :durative-actions :typing :fluents :negative-preconditions :disjunctive-preconditions)
(:types dronL dronP - dron paqueteL paqueteP - paquete lugar)

(:predicates 
    (at ?l - lugar ?x - (either paqueteL paqueteP dronL dronP))
    (in ?d - (either dronL dronP) ?y - (either paqueteL paqueteP))
    (zona-zvr ?a - lugar)
    (punto-recarga ?a - lugar)
    (dronPesado ?a - dronP)
    (paquetePesado ?a - paqueteP)
    (cargador-ocupado ?a - lugar)
    (cargando ?a - dron)
)

(:functions
    (distancia ?c1 - lugar ?c2 - lugar)
    (coste-recargas)
    (carga-maxima ?a - dron)
    (carga ?a - dron)
    (velocidad ?a - dron)
    (duracion-recarga ?a - dron)
    (coste-recarga ?a - dron)
    (tiempo-recogida ?a - paquete)
    (tiempo-entrega)
    
)

(:durative-action recoger
    :parameters (?ini - lugar ?p - paquete ?d - dron)
    :duration (= ?duration (tiempo-recogida))
    :condition (and 
        (at start (or (and 
        (at ?ini ?p)
        (paquetePesado ?p)
        (dronPesado ?d)
        ) 
        (not (paquetePesado ?p))
        ))
        (over all (at ?ini ?d)))
    :effect (and 
        (at start (not (at ?ini ?p)))
        (at end (in ?d ?p))
    )
)

(:durative-action entregar
    :parameters (?fin - lugar ?p - paquete ?d - dron)
    :duration (= ?duration (tiempo-entrega))
    :condition (and 
        (at start (at ?fin ?p))
        (over all (at ?fin ?d)))
    :effect (and 
        (at start (not (in ?d ?p)))
        (at end (at ?fin ?p))
    )
)

(:durative-action volar
    :parameters (?ini - lugar ?fin - lugar ?d - dron)
    :duration (= ?duration (/ (distancia ?ini ?fin) (velocidad ?d)))
    :condition (and 
        (at start (and (<(carga ?d)(distancia ?ini ?fin))
        (or
        (and (not(dronPesado ?d)) (or (zona-zvr ?ini) (zona-zvr ?fin)))
        (and (dronPesado ?d) (not (or (zona-zvr ?ini) (zona-zvr ?fin))))
        )
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

(:durative-action recargar
    :parameters (?l - lugar ?d - dron ?p - paquete)
    :duration (= ?duration (duracion-recarga ?d))
    :condition (and 
        (at start (and 
            (punto-recarga ?l)
            (not (in ?d ?p)) 
            (not(cargador-ocupado ?l))
        ))
    )
    :effect (and 
        (at start (and 
            (cargador-ocupado ?l)
            (cargando ?d)

        ))
        (at end (and 
            (not (cargador-ocupado ?l))
            (not (cargando ?d))
            (assign (carga ?d) (carga-maxima ?d))
            (assign (coste-recargas) (+ (coste-recargas) (coste-recarga ?d)))
        ))
    )
)

)