;; ============================================
;; BASE DE CONOCIMIENTOS - SCRIPT PRINCIPAL
;; ============================================

(printout t crlf)
(printout t "============================================" crlf)
(printout t "BASE DE CONOCIMIENTOS - SISTEMA DE TIENDA" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Paso 1: Cargar templates
(printout t "[1/3] Cargando templates..." crlf)
(load "templates.clp")

;; Paso 2: Cargar hechos
(printout t "[2/3] Cargando hechos..." crlf)
(load "facts.clp")

;; Paso 3: Cargar reglas
(printout t "[3/4] Cargando reglas..." crlf)
(load "rules.clp")

;; Paso 4: Cargar reglas de negocio
(printout t "[4/5] Cargando reglas de negocio..." crlf)
(load "business-rules.clp")

;; Paso 5: Cargar reglas de razonamiento
(printout t "[5/5] Cargando reglas de razonamiento..." crlf)
(load "reasoning-rules.clp")

(printout t crlf)
(printout t "Inicializando memoria de trabajo..." crlf)
(reset)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "INVENTARIO DE PRODUCTOS" crlf)
(printout t "============================================" crlf)
(printout t crlf)

(printout t "--- SMARTPHONES ---" crlf)
(run)

(printout t crlf)
(printout t "--- COMPUTADORES ---" crlf)
(run)

(printout t crlf)
(printout t "--- ACCESORIOS ---" crlf)
(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "CLIENTES Y MÉTODOS DE PAGO" crlf)
(printout t "============================================" crlf)
(printout t crlf)

(printout t "--- CLIENTES ---" crlf)
(run)

(printout t crlf)
(printout t "--- TARJETAS DE CRÉDITO ---" crlf)
(run)

(printout t crlf)
(printout t "--- VALES ---" crlf)
(run)

(printout t crlf)
(printout t "--- ÓRDENES DE COMPRA ---" crlf)
(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "ANÁLISIS Y ALERTAS" crlf)
(printout t "============================================" crlf)
(printout t crlf)

(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "REGLAS DE NEGOCIO - OFERTAS APLICADAS" crlf)
(printout t "============================================" crlf)
(printout t crlf)

(run)

(printout t crlf)
(printout t "============================================" crlf)
(printout t "FIN DEL REPORTE" crlf)
(printout t "============================================" crlf)
(printout t crlf)

;; Mostrar todos los hechos en memoria
(printout t "Hechos en memoria de trabajo:" crlf)
(facts)

