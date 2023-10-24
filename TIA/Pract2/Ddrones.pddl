(define (domain drones)
(:requirements :durative-actions :typing :fluents)
(:types dronP dronL paqueteP paqueteL lugar)

(:predicates
    (at ?l - lugar ?x - (either paqueteL paqueteP dronP dronL))
    (in ?d - (either dronL dronP) ?y - (either paqueteL paqueteP))
    (zona-zvr ?a - lugar)
    (punto-recarga ?a - lugar)
    (cargador-libre ?a - lugar)
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
    :duration (= ?duration (tiempo-recogida ?d))
    :condition (and 
        (at start (at ?ini ?p))
        (at start (at ?ini ?d))
        (at start (sin-paquetes ?d))

        (over all (at ?ini ?d))
        
        (at end (at ?ini ?d))
    )
    :effect (and 
        (at start (not (sin-paquetes ?d)))
        (at end (in ?d ?p))
        (at end (not (at ?ini ?p)))
    )
)

(:durative-action recoger_pesado
    :parameters (?ini - lugar ?p - paqueteP ?d - dronP)
    :duration (= ?duration (tiempo-recogida ?d))
    :condition (and 
        (at start (at ?ini ?p))
        (at start (at ?ini ?d))
        (at start (sin-paquetes ?d))

        (over all (at ?ini ?d))

        (at end (at ?ini ?d))
    )
    :effect (and 
        (at start (not (sin-paquetes ?d)))
        (at end (in ?d ?p))
        (at end (not (at ?ini ?p)))
    )
)

(:durative-action entregar
    :parameters (?fin - lugar ?p - (either paqueteL paqueteP) ?d - (either dronL dronP))
    :duration (= ?duration (tiempo-entrega ?d))
    :condition (and
        (at start (not (sin-paquetes ?d)))
        (at start (at ?fin ?d))
        (at start (in ?d ?p))

        (over all (at ?fin ?d))
        
        (at end (at ?fin ?d))
    )
    
    :effect (and 
        (at start (not (in ?d ?p)))
        (at start (sin-paquetes ?d))
        (at end (at ?fin ?p))
    )
)


(:durative-action volar-L
    :parameters (?ini - lugar ?fin - lugar ?d - dronL)
    :duration (= ?duration (/ (distancia ?ini ?fin) (velocidad ?d)))
    :condition (and 
        (at start (>=(carga ?d)(distancia ?ini ?fin)))
        (at start (at ?ini ?d))
    )

    :effect (and 
        (at start (not (at ?ini ?d)))
        (at end (at ?fin ?d))
        (at end (decrease (carga ?d) (distancia ?ini ?fin)))
    )
)

(:durative-action volar-P
    :parameters (?ini - lugar ?fin - lugar ?d - dronP)
    :duration (= ?duration (/ (distancia ?ini ?fin) (velocidad ?d)))
    :condition (and 
        (at start (>=(carga ?d)(distancia ?ini ?fin)))
        (at start (at ?ini ?d))        
        (at start (not(zona-zvr ?fin)))
        
        (over all (not(zona-zvr ?fin)))
        
        (at end (not(zona-zvr ?fin)))

    )
    
    :effect (and 
        (at start (not (at ?ini ?d)))
        (at end (at ?fin ?d))
        (at end (decrease (carga ?d) (distancia ?ini ?fin)))
    )
)

(:durative-action recargar
    :parameters (?l - lugar ?d - (either dronL dronP))
    :duration (= ?duration (duracion-recarga ?d))
    :condition (and 
        (at start (at ?l ?d))
        (at start (punto-recarga ?l))
        (at start (cargador-libre ?l))
        (at start (sin-paquetes ?d))

        (over all (at ?l ?d))
        (over all (punto-recarga ?l))
        (over all (sin-paquetes ?d))

        (at end (at ?l ?d))
        (at end (punto-recarga ?l))
        (at end (sin-paquetes ?d))
    )
    :effect (and 
        (at start (not (cargador-libre ?l)))
        (at end (cargador-libre ?l))
        (at end (assign (carga ?d) (carga-maxima ?d)))
        (at end (increase (coste-recargas) (coste-recarga ?d)))
    )
)

)