;; ============================================
;; DEMOSTRACIÓN COMPLETA DEL SISTEMA
;; ============================================
;; Este script demuestra todas las funcionalidades:
;; 1. Carga de todos los componentes
;; 2. Pruebas de cliente MENUDISTA (qty < 10)
;; 3. Pruebas de cliente MAYORISTA (qty >= 10)
;; 4. Ofertas aplicadas
;; 5. Descuentos aplicados
;; 6. Recomendaciones
;; 7. Actualización de stock

(printout t crlf)
(printout t "================================================" crlf)
(printout t "   DEMOSTRACIÓN: SISTEMA DE ÓRDENES CLIPS" crlf)
(printout t "================================================" crlf)
(printout t crlf)

;; PASO 1: CARGA DE COMPONENTES
(printout t "PASO 1: Cargando componentes del sistema..." crlf)
(printout t "---" crlf)

(printout t "  [1/5] Cargando templates..." crlf)
(load "templates.clp")

(printout t "  [2/5] Cargando hechos iniciales..." crlf)
(load "facts.clp")

(printout t "  [3/5] Cargando reglas generales..." crlf)
(load "rules.clp")

(printout t "  [4/5] Cargando reglas de negocio..." crlf)
(load "business-rules.clp")

(printout t "  [5/5] Cargando reglas de razonamiento..." crlf)
(load "reasoning-rules.clp")

(printout t "✓ Sistema cargado exitosamente" crlf)
(printout t crlf)

;; PASO 2: INICIALIZACIÓN
(printout t "PASO 2: Inicializando memoria de trabajo..." crlf)
(printout t "---" crlf)
(reset)
(printout t "✓ Memoria inicializada" crlf)
(printout t crlf)

;; PASO 3: VERIFICAR PRODUCTOS INICIALES
(printout t "PASO 3: Productos iniciales en stock..." crlf)
(printout t "---" crlf)
(printout t "Comando: (facts)" crlf)
(printout t crlf)
(facts)
(printout t crlf)

;; PASO 4: PRUEBA 1 - CLIENTE MENUDISTA (qty: 5)
(printout t "================================================" crlf)
(printout t "PRUEBA 1: CLIENTE MENUDISTA (qty: 5 unidades)" crlf)
(printout t "================================================" crlf)
(printout t crlf)

(printout t "Comando: (assert (orden (marca apple) (modelo iphone16) (qty 5)))" crlf)
(assert (orden (marca apple) (modelo iphone16) (qty 5)))
(printout t crlf)

(printout t "Ejecutando: (run)" crlf)
(printout t "---" crlf)
(run)
(printout t crlf)

;; PASO 5: PRUEBA 2 - CLIENTE MAYORISTA (qty: 15)
(printout t "================================================" crlf)
(printout t "PRUEBA 2: CLIENTE MAYORISTA (qty: 15 unidades)" crlf)
(printout t "================================================" crlf)
(printout t crlf)

(printout t "Limpiando y reiniciando..." crlf)
(clear)
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")
(reset)
(printout t "✓ Sistema reinicializado" crlf)
(printout t crlf)

(printout t "Comando: (assert (orden (marca apple) (modelo iphone16) (qty 15)))" crlf)
(assert (orden (marca apple) (modelo iphone16) (qty 15)))
(printout t crlf)

(printout t "Ejecutando: (run)" crlf)
(printout t "---" crlf)
(run)
(printout t crlf)

;; PASO 6: PRUEBA 3 - MAYORISTA CON ENVÍO GRATIS (qty: 25)
(printout t "================================================" crlf)
(printout t "PRUEBA 3: MAYORISTA CON ENVÍO GRATIS (qty: 25)" crlf)
(printout t "================================================" crlf)
(printout t crlf)

(printout t "Limpiando y reiniciando..." crlf)
(clear)
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")
(load "business-rules.clp")
(load "reasoning-rules.clp")
(reset)
(printout t "✓ Sistema reinicializado" crlf)
(printout t crlf)

(printout t "Comando: (assert (orden (marca apple) (modelo iphone16) (qty 25)))" crlf)
(assert (orden (marca apple) (modelo iphone16) (qty 25)))
(printout t crlf)

(printout t "Ejecutando: (run)" crlf)
(printout t "---" crlf)
(run)
(printout t crlf)

;; FINAL
(printout t "================================================" crlf)
(printout t "✓ DEMOSTRACIÓN COMPLETADA" crlf)
(printout t "================================================" crlf)
(printout t crlf)
(printout t "Resumen:" crlf)
(printout t "  ✓ Templates cargados" crlf)
(printout t "  ✓ Hechos iniciales cargados" crlf)
(printout t "  ✓ Reglas generales cargadas" crlf)
(printout t "  ✓ Reglas de negocio cargadas" crlf)
(printout t "  ✓ Reglas de razonamiento cargadas" crlf)
(printout t "  ✓ Clasificación menudista/mayorista funcionando" crlf)
(printout t "  ✓ Ofertas y descuentos aplicados" crlf)
(printout t "  ✓ Recomendaciones mostradas" crlf)
(printout t "  ✓ Stock actualizado" crlf)
(printout t crlf)
