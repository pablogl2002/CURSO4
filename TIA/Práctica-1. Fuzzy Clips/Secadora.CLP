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
    ((bajo (0 1)(3 1)(5 0))
    (medio (3 0)(4 1)(7 1)(10 0))
    (alto (8 0)(9 1)))
)

(deftemplate humedad 0 50 ptj
    ((seco (0 1)(5 1)(10 0))
    (humedo (5 0)(15 1)(30 1)(40 0))
    (mojado (35 0)(40 1)(50 1)))
)

(deftemplate temperatura 20 90 Celsius
    ((baja (20 1)(30 1)(50 0))
    (media (30 0)(50 1)(60 1)(80 0))
    (alta (60 0)(80 1)))
)

(deftemplate duracion-secado 20 120 min
    ((corta (20 1)(30 1)(40 0))
    (media (30 0)(50 1)(70 1)(80 0))
    (larga (70 0)(80 1)(90 1)(110 0))
    (extralarga (80 0)(100 1)(120 1)))
)

(deftemplate secado
    (slot peso-crisp (type FLOAT))
    (slot humedad-crisp (type FLOAT))
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
    (assert (secado (peso-crisp ?pesoAux)(humedad-crisp ?humedadAux)))
    (fuzzify peso ?pesoAux 0)
    (fuzzify humedad ?humedadAux 0)
)




(defrule bajo-seco
    (peso bajo)
    (humedad seco)
=>  
    (assert (temperatura extremely baja))
    (assert (duracion-secado extremely corta))
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
    (assert (temperatura very alta))
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




(defrule defuzzificar-salida
    (declare (salience -1))
    (temperatura ?t)
    (duracion-secado ?d)
    ?f <- (secado (mom-temperatura-crisp ?a)(mom-duracion-secado-crisp ?b)(max-temperatura-crisp ?c)(max-duracion-secado-crisp ?e))    
=>
    (bind ?momT (moment-defuzzify ?t))
    (bind ?maxT (maximum-defuzzify ?t))
    (bind ?momD (moment-defuzzify ?d))
    (bind ?maxD (maximum-defuzzify ?d))

    (modify ?f (mom-temperatura-crisp ?momT)(mom-duracion-secado-crisp ?momD)(max-temperatura-crisp ?maxT)(max-duracion-secado-crisp ?maxD))

    (printout T "Temperatura (mom):" ?momT crlf)
    (printout T "Temperatura (max):" ?maxT crlf)
    (printout T "Duración (mom):" ?momD crlf)
    (printout T "Duración (max):" ?maxD crlf)
    (halt)
)