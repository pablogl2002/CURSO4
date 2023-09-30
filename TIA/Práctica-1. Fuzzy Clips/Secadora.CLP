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
    (slot mom-temperatura-crisp (type FLOAT))
    (slot max-temperatura-crisp (type FLOAT))
    (slot mom-duracion-secado-crisp (type FLOAT))
    (slot max-duracion-secado-crisp (type FLOAT))
)

(defrule leer_datos
    (initial-fact)
=>
    (printout t "Introduzca el peso en kg" crlf)
    (bind ?peso-crisp (read))
    (fuzzify peso ?peso-crisp 0.1)
    (printout t "Introduzca la humedad en %" crlf)
    (bind ?humedad-crisp (read))
    (fuzzify humedad ?humedad-crisp 0.1)
)

