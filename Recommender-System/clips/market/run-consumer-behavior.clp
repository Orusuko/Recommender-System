;; ============================================
;; SISTEMA BASADO EN CONOCIMIENTO
;; Análisis de Conductas de Consumo
;; ============================================

(printout t crlf)
(printout t "============================================" crlf)
(printout t "SISTEMA DE ANÁLISIS DE CONDUCTAS DE CONSUMO" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Paso 1: Cargar templates base
(printout t "[1/6] Cargando templates base..." crlf)
(load "templates.clp")

;; Paso 2: Cargar templates extendidos para análisis
(printout t "[2/6] Cargando templates de análisis..." crlf)
(load "consumer-behavior-templates.clp")

;; Paso 3: Cargar hechos base
(printout t "[3/6] Cargando hechos base..." crlf)
(load "facts.clp")

;; Paso 4: Cargar hechos extendidos
(printout t "[4/6] Cargando hechos históricos..." crlf)
(load "consumer-behavior-facts.clp")

;; Paso 5: Cargar reglas base
(printout t "[5/6] Cargando reglas base..." crlf)
(load "rules.clp")

;; Paso 6: Cargar reglas de análisis
(printout t "[6/6] Cargando reglas de análisis..." crlf)
(load "consumer-behavior-rules.clp")

(printout t crlf)
(printout t "Inicializando memoria de trabajo..." crlf)
(reset)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "EJECUTANDO MOTOR DE INFERENCIA" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Ejecutar el motor de inferencia
(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "ANÁLISIS COMPLETADO" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Mostrar todos los hechos generados
(printout t "Hechos en la memoria de trabajo:" crlf)
(facts)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "FIN DEL ANÁLISIS" crlf)
(printout t "============================================" crlf)

