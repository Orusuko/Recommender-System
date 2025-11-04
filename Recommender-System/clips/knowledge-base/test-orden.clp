;; ============================================
;; SCRIPT DE PRUEBA PARA ÓRDENES SIMPLES
;; ============================================
;; 
;; Uso:
;; clips -f test-orden.clp
;;

(printout t crlf)
(printout t "============================================" crlf)
(printout t "SISTEMA DE RAZONAMIENTO PARA ÓRDENES" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Cargar todos los componentes (IMPORTANTE: templates primero)
(printout t "Cargando templates..." crlf)
(load "templates.clp")

(printout t "Cargando hechos..." crlf)
(load "facts.clp")

(printout t "Cargando reglas..." crlf)
(load "rules.clp")

(printout t "Cargando reglas de negocio..." crlf)
(load "business-rules.clp")

(printout t "Cargando reglas de razonamiento..." crlf)
(load "reasoning-rules.clp")

(printout t "Sistema cargado exitosamente." crlf)
(printout t crlf)

;; Inicializar el sistema
(reset)

;; Crear una orden de prueba (menudista)
(assert (orden (marca apple) (modelo iphone16) (qty 5)))

(printout t "============================================" crlf)
(printout t "PROCESANDO ORDEN - CLIENTE MENUDISTA (qty: 5)" crlf)
(printout t "============================================" crlf)
(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "Fin de la prueba" crlf)
(printout t "============================================" crlf)

