;; ============================================
;; SCRIPT DE PRUEBA CORREGIDO PARA ÓRDENES SIMPLES
;; ============================================
;; 
;; Uso:
;; (load "test-orden-fixed.clp")
;; (reset)
;; (assert (orden (marca apple) (modelo iphone16) (qty 30)))
;; (run)
;;

(printout t crlf)
(printout t "============================================" crlf)
(printout t "SISTEMA DE RAZONAMIENTO PARA ÓRDENES" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; IMPORTANTE: Cargar templates PRIMERO
(printout t "[1/5] Cargando templates..." crlf)
(load "templates.clp")

;; Luego cargar hechos
(printout t "[2/5] Cargando hechos..." crlf)
(load "facts.clp")

;; Luego cargar reglas básicas
(printout t "[3/5] Cargando reglas básicas..." crlf)
(load "rules.clp")

;; Luego cargar reglas de negocio
(printout t "[4/5] Cargando reglas de negocio..." crlf)
(load "business-rules.clp")

;; Finalmente cargar reglas de razonamiento
(printout t "[5/5] Cargando reglas de razonamiento..." crlf)
(load "reasoning-rules.clp")

(printout t crlf)
(printout t "Sistema cargado correctamente." crlf)
(printout t "Listo para recibir órdenes." crlf)
(printout t crlf)
(printout t "Ejemplo de uso:" crlf)
(printout t "  (reset)" crlf)
(printout t "  (assert (orden (marca apple) (modelo iphone16) (qty 30)))" crlf)
(printout t "  (run)" crlf)
(printout t crlf)

