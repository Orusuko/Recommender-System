;; ============================================
;; SCRIPT DE PRUEBAS RÁPIDAS
;; ============================================
;; 
;; Este script ejecuta pruebas automáticas del sistema
;;

(printout t crlf)
(printout t "============================================" crlf)
(printout t "SISTEMA DE PRUEBAS AUTOMÁTICAS" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Cargar todos los componentes
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")

(printout t "Sistema cargado correctamente." crlf)
(printout t crlf)

;; ============================================
;; PRUEBA 1: Orden MENUDISTA (qty = 5)
;; ============================================
(printout t "============================================" crlf)
(printout t "PRUEBA 1: Cliente MENUDISTA (qty = 5)" crlf)
(printout t "============================================" crlf)
(reset)
(assert (orden (marca apple) (modelo iphone16) (qty 5)))
(run)

(printout t crlf)
(printout t "Presione Enter para continuar..." crlf)
(readline)

;; ============================================
;; PRUEBA 2: Orden MAYORISTA (qty = 30)
;; ============================================
(printout t crlf)
(printout t "============================================" crlf)
(printout t "PRUEBA 2: Cliente MAYORISTA (qty = 30)" crlf)
(printout t "============================================" crlf)
(clear)
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")
(reset)
(assert (orden (marca apple) (modelo iphone16) (qty 30)))
(run)

(printout t crlf)
(printout t "Presione Enter para continuar..." crlf)
(readline)

;; ============================================
;; PRUEBA 3: Caso límite (qty = 10)
;; ============================================
(printout t crlf)
(printout t "============================================" crlf)
(printout t "PRUEBA 3: Caso límite (qty = 10)" crlf)
(printout t "============================================" crlf)
(clear)
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")
(reset)
(assert (orden (marca apple) (modelo iphone16) (qty 10)))
(run)

(printout t crlf)
(printout t "Presione Enter para continuar..." crlf)
(readline)

;; ============================================
;; PRUEBA 4: Caso límite (qty = 9)
;; ============================================
(printout t crlf)
(printout t "============================================" crlf)
(printout t "PRUEBA 4: Caso límite (qty = 9)" crlf)
(printout t "============================================" crlf)
(clear)
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")
(reset)
(assert (orden (marca apple) (modelo iphone16) (qty 9)))
(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "PRUEBAS COMPLETADAS" crlf)
(printout t "============================================" crlf)
(printout t crlf)

