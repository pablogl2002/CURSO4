(define (problem EjercicioP2)
    (:domain drones)

    (:objects
        dronL1 - dronL
        dronL2 - dronL
        dronL3 - dronL
        dronP1 - dronP
        dronP2 - dronP
        paqueteL1 - paqueteL
        paqueteL2 - paqueteL
        paqueteL3 - paqueteL
        paqueteP1 - paqueteP
        paqueteP2 - paqueteP
        almA - lugar
        almB - lugar
        almC - lugar
        almD - lugar
        almE - lugar
        almF - lugar


        almG - lugar
        paqueteL4 - paqueteL
        paqueteP3 - paqueteP
    )
    (:init

        ; Ejercicio 1
        (=(distancia almG almA) 70)
        (=(distancia almG almB) 70)
        (=(distancia almG almC) 70)
        (=(distancia almG almD) 70)
        (=(distancia almG almE) 70)
        (=(distancia almG almF) 70)
        (=(distancia almG almG) 0)

        (=(distancia almA almG) 60)
        (=(distancia almB almG) 60)
        (=(distancia almC almG) 60)
        (=(distancia almD almG) 60)
        (=(distancia almE almG) 60)
        (=(distancia almF almG) 60)
        (=(distancia almG almG) 0)

        (zona-zvr almG)
        (punto-recarga almG)

        (at almB paqueteL4)
        (at almD paqueteP3)
        
        ; Ejercicio 2
        (=(mantenimiento dronL1) 2)
        (=(mantenimiento dronL2) 2)
        (=(mantenimiento dronL3) 2)
        (=(mantenimiento dronP1) 2)
        (=(mantenimiento dronP2) 2)

        (=(coste-mantenimiento) 0)

        (punto-mantenimiento-libre almA)
        (punto-mantenimiento-libre almB)
        (punto-mantenimiento-libre almC)
        (punto-mantenimiento-libre almF)


        ;distancias desde el almacen A a otros almacenes
        (=(distancia almA almA) 0)
        (=(distancia almA almB) 16)
        (=(distancia almA almC) 20)
        (=(distancia almA almD) 28)
        (=(distancia almA almE) 60)
        (=(distancia almA almF) 84)

        ;distancias desde el almacen B a otros almacenes
        (=(distancia almB almA) 16)
        (=(distancia almB almB) 0)
        (=(distancia almB almC) 40)
        (=(distancia almB almD) 16)
        (=(distancia almB almE) 24)
        (=(distancia almB almF) 58)

        ;distancias desde el almacen C a otros almacenes
        (=(distancia almC almA) 20)
        (=(distancia almC almB) 40)
        (=(distancia almC almC) 0)
        (=(distancia almC almD) 32)
        (=(distancia almC almE) 56)
        (=(distancia almC almF) 32)

        ;distancias desde el almacen D a otros almacenes
        (=(distancia almD almA) 28)
        (=(distancia almD almB) 16)
        (=(distancia almD almC) 32)
        (=(distancia almD almD) 0)
        (=(distancia almD almE) 42)
        (=(distancia almD almF) 40)

        ;distancias desde el almacen E a otros almacenes
        (=(distancia almE almA) 60)
        (=(distancia almE almB) 24)
        (=(distancia almE almC) 56)
        (=(distancia almE almD) 42)
        (=(distancia almE almE) 0)
        (=(distancia almE almF) 100)

        ;distancias desde el almacen F a otros almacenes
        (=(distancia almF almA) 84)
        (=(distancia almF almB) 58)
        (=(distancia almF almC) 32)
        (=(distancia almF almD) 40)
        (=(distancia almF almE) 100)
        (=(distancia almF almF) 0)

        ;tiempos de recogida según el dron
        (=(tiempo-recogida paqueteL1) 1)
        (=(tiempo-recogida paqueteL2) 1)
        (=(tiempo-recogida paqueteL3) 1)
        (=(tiempo-recogida paqueteP1) 2)
        (=(tiempo-recogida paqueteP2) 2)

        ; tiempo de entrega del paquete indiferente de dron/paquete
        (=(tiempo-entrega) 2)

        ; zonas restringidas por las ZVR
        (zona-zvr almA)
        (zona-zvr almB)
        (zona-zvr almC)

        ; puntos de recarga
        (punto-recarga almA)
        (punto-recarga almB)
        (punto-recarga almC)
        (punto-recarga almF)

        ; lugar de inicio de los paquetes
        (at almB paqueteL1)
        (at almA paqueteL2)
        (at almF paqueteL3)
        (at almD paqueteP1)
        (at almF paqueteP2)

        ; lugar de inicio de los drones
        (at almA dronL1)
        (at almA dronL2)
        (at almC dronL3)
        (at almE dronP1)
        (at almD dronP2)

        ; decimos que al principio no tienen ningún paquete los drones
        (sin-paquetes dronL1)
        (sin-paquetes dronL2)
        (sin-paquetes dronL3)
        (sin-paquetes dronP1)
        (sin-paquetes dronP2)

        ; carga maxima de la bateria de los drones
        (=(carga-maxima dronL1) 100)
        (=(carga-maxima dronL2) 100)
        (=(carga-maxima dronL3) 150)
        (=(carga-maxima dronP1) 200)
        (=(carga-maxima dronP2) 220)

        ; carga inicial de la bateria de los drones
        (=(carga dronL1) 5)
        (=(carga dronL2) 10)
        (=(carga dronL3) 40)
        (=(carga dronP1) 40)
        (=(carga dronP2) 120)

        ; velocidad de vuelo de cada dron
        (=(velocidad dronL1) 2)
        (=(velocidad dronL2) 4)
        (=(velocidad dronL3) 4)
        (=(velocidad dronP1) 1)
        (=(velocidad dronP2) 2)

        ; duración recarga de la bateria de cada dron
        (=(duracion-recarga dronL1) 8)
        (=(duracion-recarga dronL2) 9)
        (=(duracion-recarga dronL3) 10)
        (=(duracion-recarga dronP1) 20)
        (=(duracion-recarga dronP2) 25)

        ; coste recarga bateria de cada dron
        (=(coste-recarga dronL1) 8)
        (=(coste-recarga dronL2) 10)
        (=(coste-recarga dronL3) 8)
        (=(coste-recarga dronP1) 9)
        (=(coste-recarga dronP2) 12)

        (=(coste-recargas) 0)

        (cargador-libre almA)
        (cargador-libre almB)
        (cargador-libre almC)
        (cargador-libre almF)

        
    )

(:goal (and
    (at almC paqueteL1)
    (at almB paqueteL2)
    (at almD paqueteL3)
    (at almF paqueteP1)
    (at almE paqueteP2)

    (at almB dronL1)
    (at almB dronL2)
    (at almB dronL3)
    (at almE dronP1)
    (at almE dronP2)
    
    ;Ejercicio 1
    (at almG paqueteL4)
    (at almF paqueteP3)
))


;(:metric minimize (+ (* 0.6 (total-time)) (* 0.4 (coste-recargas)))) 
(:metric minimize (+ (coste-mantenimiento) (+ (* 0.5 (total-time)) (* 0.7 (coste-recargas)))))

)