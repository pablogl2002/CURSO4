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

(deftemplate temperatura 20 90
    ((baja (20 1)(30 1)(50 0))
    (media (30 0)(50 1)(60 1)(80 0))
    (alta (60 0)(80 1)))
)

(deftemplate duracion-secado 20 120
    ((corta (20 1)(30 1)(40 0))
    (media (30 0)(50 1)(70 1)(80 0))
    (larga (70 0)(80 1)(90 1)(110 0))
    (extralarga (80 0)(100 1)(120 1)))
)

(deftemplate secado
    (slot peso-crisp (type FLOAT))
    (slot humedad-crisp (type FLOAT))
    (slot temperatura-crisp (type FLOAT))
    (slot duracion-secado-crisp (type FLOAT))
)

(defrule leer_datos
    (initial-fact)
=>
    (printout t "Introduzca el peso en kg" crlf)
    (bind ?pesoAux (read))
    (fuzzify peso ?pesoAux 0.1)
    (printout t "Introduzca la humedad en %" crlf)
    (bind ?humedadAux (read))
    (fuzzify humedad ?humedadAux 0.1)
    (assert (secado (peso-crisp ?pesoAux)(humedad-crisp ?humedadAux)))
)

(deffacts prueba
    (secado (peso-crisp 2.0)(humedad-crisp 4.0))
)

(defrule bajo_seco
    ?f <- (secado (peso-crisp bajo)(humedad-crisp seco))
=>  
    (modify ?f (temperatura-crisp extremely baja))
    (modify ?f (duracion-secado-crisp extremely corta))
)

(defrule defuzzificar
    ?f <- (secado (temperatura-crisp ?temp)(duracion-secado-crisp ?dSec))

    =>
    (printout T "Temperatura por moment: " (moment-defuzzify ?temp) crlf)
    (printout T "Temperatura por maximum: " (maximum-defuzzify ?temp) crlf)
    (printout T "Duracion de secado por moment: " (moment-defuzzify ?dSec) crlf)
    (printout T "Duracion de secado por maximum: " (maximum-defuzzify ?dSec) crlf)
)