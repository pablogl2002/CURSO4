;; CPOEbasic.bat: PLANTILLA DEL CODIGO DEL SISTEMA CPOE

;; ___________ TEMPLATES __________________

; Template 1: persona a la que se prescribe
(deftemplate persona
  (slot ID)
  (slot edad)         
  (multislot alergias)     ;lista de alergias del paciente
  (multislot enfermedades)    ;lista de alimentos actualmente ingeridos
  (multislot sintomas)     ;lista de sintomas actuales del paciente
)

; Template 2: historico de componentes activos prescritos, incluido la dosis acumulada

(deftemplate persona-componenteActivo-dosis
  (slot persona)
  (slot componenteActivo)
  (slot dosis))

; Template 3: medicamento

(deftemplate medicamento
  (slot ID)
  (slot componenteActivo)
  (multislot componentes)
  (multislot presentacion)
  (multislot indicacion)
)

; Template 4: prescripcion

(deftemplate prescripcion
  (slot ID)
  (slot persona)
  (slot medicamento)
  (slot dosis)
)

; Template 5: componente

(deftemplate componente
  (slot ID)
  (multislot es-un)
  (slot dosisMaximaAdultos)
  (slot dosisMaximaNinyos)
  (multislot contraindicacion-enfermedad)
  (multislot contraindicacion-interaccion)
  (multislot contraindicacion-sintoma)
)

;; ___________ FUNCTIONS __________________


(deffunction accion-detener (?pr ?p ?m ?t ?i)
  (bind ?id (fact-slot-value ?pr ID))
  (printout t "Detener prescripcion " ?id " de " ?m " a " ?p " por " ?t " de " ?i "." crlf)
  (retract ?pr)
)

(deffunction accion-administrar-nuevo (?pr ?p ?m ?c ?d)
  (bind ?id (fact-slot-value ?pr ID))
  (printout t "Administar prescripcion " ?id ": " ?d " dosis de " ?m " a " ?p "." crlf)
  (assert (persona-componenteActivo-dosis (persona ?p) (componenteActivo ?c) (dosis ?d)))
  (retract ?pr)
)

(deffunction accion-administrar-continuacion (?pr ?p ?m ?c ?d ?pcd)
  (bind ?id (fact-slot-value ?pr ID))
  (bind ?dosis (fact-slot-value ?pcd dosis))
  (printout t "Administar prescripcion " ?id ": " ?d " dosis de " ?m " a " ?p "." crlf)
  (modify ?pcd (dosis (+ ?d ?dosis)))
  (retract ?pr)
)

;; ___________  FACTS  __________________

;; Facts 1:

(deffacts Terminologia "relacion taxonomica de analgesicos"

(componente (ID amina)
	    (es-un analgesico)
	    (contraindicacion-sintoma empeoramiento dolorNinyo5Dias dolorAdunto10Dias fiebre3Dias fiebre3Dias)) ;;fiebre3Dias para que se propague a paracetamol
		
(componente (ID antinflamatorio-no-esteroide) (es-un analgesico))
(componente (ID cannabinoide) (es-un analgesico))
(componente (ID opioide) (es-un analgesico))
(componente (ID fenacetina)(es-un amina))
(componente  (ID paracetamol) (es-un amina)
	     (contraindicacion-interaccion analgesico)
	     (contraindicacion-enfermedad higado renal cardiaco pulmonar anemia alcoholismo-menor alcolismo-mayor embarazo lactancia)
	     (contraindicacion-sintoma empeoramiento dolorNinyo5Dias dolorAdunto10Dias)
	     (dosisMaximaAdultos 8)
	     (dosisMaximaNinyos 5)
)
(componente (ID aspirina)  (es-un antinflamatorio-no-esteroide))
(componente (ID celecoxib)(es-un antinflamatorio-no-esteroide))
(componente (ID diclofenaco)(es-un  antinflamatorio-no-esteroide))
(componente (ID ibuprofeno)(es-un  antinflamatorio-no-esteroide))
(componente (ID ketoprofeno)(es-un  antinflamatorio-no-esteroide))
(componente (ID ketorolaco)(es-un  antinflamatorio-no-esteroide))
(componente (ID meloxicam)(es-un  antinflamatorio-no-esteroide))
(componente (ID naproxeno)(es-un  antinflamatorio-no-esteroide))
(componente (ID rofecoxib)(es-un  antinflamatorio-no-esteroide))
(componente (ID indometacina)(es-un  antinflamatorio-no-esteroide))

(componente (ID cannabis)(es-un cannabinoide))
(componente (ID tetrahidrocannabinol)(es-un cannabinoide))

(componente (ID alfentanilo)(es-un opioide))
(componente (ID carfentanilo)(es-un opioide))
(componente (ID buprenorfina)(es-un opioide) )
(componente (ID codeina)(es-un opioide) )
(componente (ID codeinona)(es-un opioide))
(componente (ID dextropropoxifeno)(es-un opioide) )
(componente (ID dihidrocodeina)(es-un opioide) )
(componente (ID beta-endorfina)(es-un opioide) )
(componente (ID fentanilo)(es-un opioide) )
(componente (ID heroina)(es-un opioide) )
(componente (ID hidrocodona)(es-un opioide))
(componente (ID hidromorfona)(es-un opioide))
(componente (ID metadona)(es-un opioide) )
(componente (ID morfina)(es-un opioide) )
(componente (ID morfinona)(es-un opioide))
(componente (ID oxicodona)(es-un opioide) )
(componente (ID oximorfona)(es-un opioide) )
(componente (ID meperidina)(es-un opioide) )
(componente (ID remifentanilo)(es-un opioide))
(componente (ID sufentanilo)(es-un opioide) )
(componente (ID tebaina)(es-un opioide) )
(componente (ID tramadol)(es-un opioide))
)

;; Facts 2:

(deffacts Vademucum "Medicamentos en la Farmacia"
  (medicamento (ID Mundogen500mgComprimidosEFG)
  	       (componenteActivo paracetamol)
	       (componentes paracetamol almidon-pregelatimizado povidona acido-estearico)
	       (presentacion comprimido 500)
	       (indicacion fiebre dolor-muscular dolor-cabeza dolor-intensidad-leve dolor-intensidad-moderada)
  )

  (medicamento (ID Termalgin650mgComprimidos)
  	       (componenteActivo paracetamol)
	       (componentes paracetamol talco almido-maiz silice coloidal-anhidra celulosa-microcristalina almidon-pregelatimizado povidona acido-estearico)
	       (presentacion comprimido 650)
	       (indicacion fiebre dolor-muscular dolor-cabeza dolor-intensidad-leve dolor-intensidad-moderada)
  )
)

;; ___________  RULES __________________

(defrule extiende-alergias-terminologia
  (componente (ID ?z) (es-un ?x))
  ?p <- (persona (alergias $?a ?x $?b))
  (not (test (member$ ?z ?a)))
  (not (test (member$ ?z ?b)))
  =>
  (modify ?p (alergias ?a ?x ?b ?z))
;;  (printout t ?p.ID " " ?p.alergias crlf)
)

(defrule extiende-interaccion-terminologia
  (componente (ID ?z) (es-un ?x))
  ?c <- (componente (ID ?id)(contraindicacion-interaccion $?a ?x $?b))
  (not (test (member$ ?z ?a)))
  (not (test (member$ ?z ?b)))
  (not (test (eq ?z ?id))) ;; un componente no puede estar contraindicado consigo mismo
  =>
  (modify ?c (contraindicacion-interaccion ?a ?x ?b ?z))
)

(defrule extiende-enfermedad-terminologia
  (componente (ID ?z) (es-un ?x))
  (componente (ID ?x)(contraindicacion-enfermedad $?a ?e $?b))
  ?c <- (componente (ID ?z)(contraindicacion-enfermedad $?e2))
  (not (test (member$ ?e ?e2)))
  =>
  (modify ?c (contraindicacion-enfermedad ?e2 ?e))
)

(defrule extiende-sintoma-terminologia
  (componente (ID ?z) (es-un ?x))
  (componente (ID ?x)(contraindicacion-sintoma $?a ?e $?b))
  ?c <- (componente (ID ?z)(contraindicacion-sintoma $?e2))
  (not (test (member$ ?e ?e2)))
  =>
  (modify ?c (contraindicacion-sintoma ?e2 ?e))
)

(defrule contraindicacion-alergia-componente
  (persona (ID ?p) (alergias $?a))
  (medicamento  (ID ?m) (componentes $?c))
  ?pr <- (prescripcion (medicamento ?m) (persona ?p))
  (test (> (length$ (intersection$ ?a ?c)) 0))
  =>
  (accion-detener ?pr ?p ?m alergia (intersection$ ?a ?c))
)

(defrule contraindicacion-componente-enfermedad
  (componente (ID ?c) (contraindicacion-enfermedad $?ce))
  (medicamento (ID ?m) (componentes $? ?c $?))
  ?pr <- (prescripcion (persona ?p) (medicamento ?m))
  (persona (ID ?p) (enfermedades $?e))
  (test (> (length$ (intersection$ ?e ?ce)) 0))
  =>
  (accion-detener ?pr ?p ?m enfermedad (intersection$ ?e ?ce))
)

(defrule contraindicacion-componente-sintoma
  (componente (ID ?c) (contraindicacion-sintoma $?cs))
  (medicamento (ID ?m) (componentes $? ?c $?))
  ?pr <- (prescripcion (persona ?p) (medicamento ?m))
  (persona (ID ?p) (sintomas $?s))
  (test (> (length$ (intersection$ ?s ?cs)) 0))
  =>
  (accion-detener ?pr ?p ?m sintoma (intersection$ ?s ?cs))
)

(defrule contraindicacion-componente-interaccion
  (persona-componenteActivo-dosis (persona ?p) (componenteActivo ?c2))
  ?pr <- (prescripcion (persona ?p) (medicamento ?m))
  (medicamento (ID ?m) (componentes $? ?c $?))
  (componente (ID ?c) (contraindicacion-interaccion $? ?c2 $?))
  =>
  (accion-detener ?pr ?p ?m interaccion ?c2)
)

(defrule contraindicacion-dosis-adulto
  ?pr <- (prescripcion (persona ?p) (medicamento ?m)(dosis ?d))
  (persona (ID ?p) (edad ?edad&:(> ?edad 11)))
  (medicamento (ID ?m) (componenteActivo ?ca))
  (componente (ID ?ca) (dosisMaximaAdultos ?d1))
  (persona-componenteActivo-dosis (persona ?p) (componenteActivo ?ca) (dosis ?dh))
  (test (> (+ ?d ?dh) ?d1))
  =>
  (accion-detener ?pr ?p ?m dosisAcumulada (+ ?d ?dh))
)

(defrule contraindicacion-dosis-ninyo
  ?pr <- (prescripcion (persona ?p) (medicamento ?m)(dosis ?d))
  (persona (ID ?p) (edad ?edad&:(<= ?edad 11)))
  (medicamento (ID ?m) (componenteActivo ?ca))
  (componente (ID ?ca) (dosisMaximaNinyos ?d1))
  (persona-componenteActivo-dosis (persona ?p) (componenteActivo ?ca) (dosis ?dh))
  (test (> (+ ?d ?dh) ?d1))
  =>
  (accion-detener ?pr ?p ?m dosisAcumulada (+ ?d ?dh))
)

(defrule prescripcion-correcta-continuacion
  (declare (salience -99))
  ?pr <- (prescripcion (persona ?p) (medicamento ?m)(dosis ?d))
  (medicamento (ID ?m) (componenteActivo ?c))
  ?pcd <- (persona-componenteActivo-dosis (persona ?p) (componenteActivo ?c) (dosis ?dh))
  =>
  (accion-administrar-continuacion ?pr ?p ?m ?c ?d ?pcd)
)

(defrule prescripcion-correcta-nueva
  (declare (salience -100))
  ?pr <- (prescripcion (persona ?p) (medicamento ?m)(dosis ?d))
  (medicamento (ID ?m) (componenteActivo ?c))
  =>
  (accion-administrar-nuevo ?pr ?p ?m ?c ?d)
)

;; __ TODO: EJERCICIO 3__

; EJERCICIO 3.1
;(deffunction accion-sugerir-alternativa (?pr ?p ?m ?t ?i ?m2)
  ;   ;TODO
  ;)

; EJERCICIO 3.2
;(defrule contraindicacion-alergia-componente-sugiere-alternativa
  ;    ;TODO
  ;)

; EJERCICIO 3.6
;(defrule contraindicacion-alergia-componente-sugiere-alternativa
  ;    ;TODO
  ;)

;; ___________  FACTS __________________

(deffacts ejemploSituacion
  (persona (ID Juan)
  	  (edad 32)
	  (alergias pescado penicilina)
	  (enfermedades renal)
	  (sintomas fiebre)
  )

  (persona (ID Salva)
  	  (edad 29)
	  (alergias nil)
	  (sintomas dolor-muscular)
  )
  (persona-componenteActivo-dosis (persona Salva)
  				  (componenteActivo fentanilo)
				  (dosis 2)
  )

  (prescripcion (ID Juan-20100505-1001)
  		(persona Juan)
  		(medicamento Mundogen500mgComprimidosEFG)
		(dosis 1)
  )
  
  (prescripcion (ID Salva-20100505-2225)
  		(persona Salva)
  		(medicamento Mundogen500mgComprimidosEFG)
		(dosis 1)
  )


;; __ TO DO: EJERCICIO 2__

; EJERCICIO 2.2
  ;Paciente Jose, de 37 años, es alérgico a los analgésicos, y se le prescribe 1 dosis de Mundogen500mgComprimidosEFG, lo que debe detenerse por alergia al paracetamol (que es un analgésico de tipo amina).
  ; define la persona Jose
  ; (persona (ID Jose)
    ;TODO
  ; )
  ; define la prescripcion Jose-20100505-2342, con 1 dosis de Mundogen500mgComprimidosEFG
  ; (prescripcion (ID Jose-20100505-2342)
   ;TODO
  ; )

;; __ TO DO: EJERCICIO 3 __

   ; EJERCICIO 3.3
   ;(persona (ID Javier)
      ;TODO
    ;)

    ; EJERCICIO 3.4
    ;(prescripcion (ID Javier-20100505-50001)
       ;TODO
    ;)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(reset)
(run)
