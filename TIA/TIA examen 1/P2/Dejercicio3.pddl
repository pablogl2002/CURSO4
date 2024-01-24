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

    ; Ejercicio 2
    (cargando ?d - (either dronL dronP))
    (manteniendo ?d - (either dronL dronP))
    (punto-mantenimiento-libre ?l - lugar)
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
    
    ; Ejercicio 3
    (brazo-robotico ?l - lugar)
    
    ;Ejercicio 2
    (mantenimiento ?d - (either dronL dronP))
    (coste-mantenimiento)
)

(:durative-action recoger_ligero
    :parameters (?ini - lugar ?p - paqueteL ?d - (either dronL dronP))
    :duration (= ?duration (tiempo-recogida ?p))
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
    :duration (= ?duration (tiempo-recogida ?p))
    :condition (and 
        (at start (at ?ini ?p))
        (at start (at ?ini ?d))
        (at start (sin-paquetes ?d))

        (over all (at ?ini ?d))

        (at end (at ?ini ?d))

        ; Ejercicio 3
        (at start (> (brazo-robotico ?ini) 0))
    )
    :effect (and 
        (at start (not (sin-paquetes ?d)))
        (at end (in ?d ?p))
        (at end (not (at ?ini ?p)))

        ; Ejercicio 3
        (at start (decrease (brazo-robotico ?ini) 1))
    )
)

(:durative-action entregar
    :parameters (?fin - lugar ?p - (either paqueteL paqueteP) ?d - (either dronL dronP))
    :duration (= ?duration (tiempo-entrega))
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
        ; Ejercicio 2
        (at start (> (mantenimiento ?d) 0))

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
        ; Ejercicio 2
        (at start (> (mantenimiento ?d) 0))

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

; Ejercicio 2
(:durative-action mantener-Dron
    :parameters (?l - lugar ?d - (either dronL dronP))
    :duration (= ?duration 5)
    :condition (and 
        (at start (>= (mantenimiento ?d) 0))
        (at start (punto-recarga ?l))
        (at start (at ?l ?d))
        (at start (punto-mantenimiento-libre ?l))

        (at start (not (cargando ?d)))
        
        (over all (at ?l ?d))
        (at end (at ?l ?d))

    )
    :effect (and 
        (at start (not (punto-mantenimiento-libre ?l)))
        (at end (increase (coste-mantenimiento) 5))
        (at end (punto-mantenimiento-libre ?l))

        (at end (assign (mantenimiento ?d) 2))

        (at start (manteniendo ?d))
        (at end (not(manteniendo ?d)))
    )
)

; Ejercicio 2
(:durative-action mantener-dos-Drones
    :parameters (?l - lugar ?d1 - (either dronL dronP) ?d2 - (either dronL dronP))
    :duration (= ?duration 8)
    :condition (and 
        (at start (>= (mantenimiento ?d1) 0))
        (at start (>= (mantenimiento ?d2) 0))

        (at start (punto-recarga ?l))
        (at start (at ?l ?d1))
        (at start (at ?l ?d2))
        (at start (punto-mantenimiento-libre ?l))

        (over all (not(= ?d1 ?d2)))

        (at start (not (cargando ?d1)))
        (at start (not (cargando ?d2)))
        
        (over all (at ?l ?d1))
        (at end (at ?l ?d1))

        (over all (at ?l ?d2))
        (at end (at ?l ?d2))

    )
    :effect (and 
        (at start (not (punto-mantenimiento-libre ?l)))
        (at end (increase (coste-mantenimiento) 9))
        (at end (punto-mantenimiento-libre ?l))

        (at start (manteniendo ?d1))
        (at start (manteniendo ?d2))
    
        (at end (not(manteniendo ?d1)))
        (at end (not(manteniendo ?d2)))
        (at end (assign (mantenimiento ?d1) 2))
        (at end (assign (mantenimiento ?d2) 2))
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
        ; Ejercicio 2
        (at start (not (manteniendo ?d)))
    
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
        ;Ejercicio 2
        (at start (cargando ?d))
        (at end (not(cargando ?d)))
    )
)

)