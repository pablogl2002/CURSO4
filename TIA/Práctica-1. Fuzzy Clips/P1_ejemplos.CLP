
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

(deftemplate edad
    0 120 anyos
    ((infantil (12 1)(20 0))
    (joven (10 0)(15 1)(25 1)(30 0))
    (adulta (20 0)(30 1)(60 1)(70 0))
    (mayor (60 0)(70 1))))

;(plot-fuzzy-value t ".*+-" 1 90
;    (create-fuzzy-value edad infantil)
;    (create-fuzzy-value edad joven)
;    (create-fuzzy-value edad adulta)
;    (create-fuzzy-value edad mayor)
;)

