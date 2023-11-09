(deffunction fuzzify (?fztemplate ?value ?delta)
    (bind ?low (get-u-from ?fztemplate))
    (bind ?hi  (get-u-to   ?fztemplate))

    (if (<= ?value ?low)
        then
        (assert-string
            (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
        else
        (if (>= ?value ?hi)
            then
            (assert-string
                (format nil "(%s (%g 0.0) (%g 1.0))"
                            ?fztemplate (- ?hi ?delta) ?hi))
            else
            (assert-string
                (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
                            ?fztemplate (max ?low (- ?value ?delta))
                            ?value (min ?hi (+ ?value ?delta)) ))
        )
    )
)

(deftemplate peso 0 10 kg
    ((bajo (3 1)(5 0))
    (medio (3 0)(4 1)(7 1)(10 0))
    (alto (8 0)(9 1)))
)

(deftemplate humedad 0 50 ptj
    ((seco (5 1)(10 0))
    (humedo (5 0)(15 1)(30 1)(40 0))
    (mojado (35 0)(40 1)))
)

(deftemplate temperatura 20 110 Celsius
    ((baja (30 1)(50 0))
    (media (30 0)(50 1)(60 1)(80 0))
    (alta (60 0)(80 1))
    (vapor (s 80 105))
    (supervapor (pi 10 100))
    )
)

(deftemplate duracion-secado 20 120 min
    ((corta (30 1)(40 0))
    (media (30 0)(50 1)(70 1)(80 0))
    (larga (70 0)(80 1)(90 1)(110 0))
    (extralarga (80 0)(100 1)))
)

(deftemplate velocidad 0 1000 rpm
    ((baja (300 1) (400 0))
    (media (s 600 800))
    (alta (700 0)(800 1)))
)

(deftemplate secado
    (slot peso-crisp (type FLOAT))
    (slot humedad-crisp (type FLOAT))

    (slot modo (type INTEGER))
    (slot eco (type INTEGER))

    (slot mom-temperatura-crisp (type FLOAT))
    (slot mom-duracion-secado-crisp (type FLOAT))
    (slot max-temperatura-crisp (type FLOAT))
    (slot max-duracion-secado-crisp (type FLOAT))
)

(defrule leer-datos
    (initial-fact)
=>
    (printout t "Introduzca el peso en kg" crlf)
    (bind ?pesoAux (read))
    (printout t "Introduzca la humedad en %" crlf)
    (bind ?humedadAux (read))
    (printout t "Introduzca el modo a actuar EST (0) o HIEST (1))" crlf)
    (bind ?modoAux (read))
    (printout t "ECO: ON (1) OFF (0))" crlf)
    (bind ?ecoAux (read))

    (assert (secado (peso-crisp ?pesoAux)(humedad-crisp ?humedadAux) (modo ?modoAux) (eco ?ecoAux)))
    (if (= ?modoAux 0)
        then (fuzzify temperatura 100 0)
    )
    (if (= ?modoAux 1)
        then (fuzzify temperatura 110 0)
    )

    (fuzzify peso ?pesoAux 0)
    (fuzzify humedad ?humedadAux 0)
)

(defrule eco-on
    ?f <- (secado (eco ?v))
=>
    if (= ?v 1)
        then(
            (assert(duracion-secado larga))
            (assert(temperatura media))
            (assert(velocidad somewhat baja))
        )
)

(defrule velocidad-bajo-more-or-

    (peso bajo)
    (temperatura more-or-less vapor)
=>
    (assert (velocidad alta))
)

(defrule velocidad-medio-vapor
    (peso medio)
    (temperatura vapor)
=>
    (assert (velocidad media))
)

(defrule velocidad-alto-supervapor
    (peso medio)
    (temperatura supervapor)
=>
    (assert (velocidad media))
)


(defrule bajo-seco
    (peso bajo)
    (humedad seco)
=>  
    (assert (temperatura extremely baja))
    (assert (duracion-secado corta))
)

(defrule bajo-humedo
    (peso bajo)
    (humedad humedo)
=>  
    (assert (temperatura media))
    (assert (duracion-secado somewhat corta))
)

(defrule bajo-mojado
    (peso bajo)
    (humedad mojado)
=>  
    (assert (temperatura alta))
    (assert (duracion-secado media))
)


(defrule medio-seco
    (peso medio)
    (humedad seco)
=>  
    (assert (temperatura very baja))
    (assert (duracion-secado very corta))
)

(defrule medio-humedo
    (peso medio)
    (humedad humedo)
=>  
    (assert (temperatura more-or-less media))
    (assert (duracion-secado somewhat media))
)

(defrule medio-mojado
    (peso medio)
    (humedad mojado)
=>  
    (assert (temperatura more-or-less alta))
    (assert (duracion-secado larga))
)



(defrule alto-seco
    (peso alto)
    (humedad seco)
=>  
    (assert (temperatura more-or-less baja))
    (assert (duracion-secado more-or-less corta))
)

(defrule alto-humedo
    (peso alto)
    (humedad humedo)
=>  
    (assert (temperatura alta))
    (assert (duracion-secado larga))
)

(defrule alto-mojado
    (peso alto)
    (humedad mojado)
=>  
    (assert (temperatura extremely alta))
    (assert (duracion-secado extralarga))
)


(defrule velocidad-very-alta
    (velocidad very alta)
=>
    (printout T "posibles arrugas debido a la velocidad")
)


(defrule defuzzificar-salida
    (declare (salience -1))
    (temperatura ?t)
    (duracion-secado ?d)
    (velocidad ?v)
    ?f <- (secado (mom-temperatura-crisp ?a)(mom-duracion-secado-crisp ?b)(max-temperatura-crisp ?c)(max-duracion-secado-crisp ?e))    
=>
    (bind ?momT (moment-defuzzify ?t))
    (bind ?maxT (maximum-defuzzify ?t))
    (bind ?momD (moment-defuzzify ?d))
    (bind ?maxD (maximum-defuzzify ?d))
    (bind ?momV (moment-defuzzify ?v))

    (modify ?f (mom-temperatura-crisp ?momT)(mom-duracion-secado-crisp ?momD)(max-temperatura-crisp ?maxT)(max-duracion-secado-crisp ?maxD))

    (printout T "Temperatura (mom):" ?momT crlf)
    (printout T "Temperatura (max):" ?maxT crlf)
    (printout T "Duración (mom):" ?momD crlf)
    (printout T "Duración (max):" ?maxD crlf)
    (printout T "Velocidad (mom):" ?momV crlf)

    (halt)
)