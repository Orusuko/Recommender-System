;; ============================================
;; BASE DE CONOCIMIENTOS - REGLAS
;; ============================================

;; ============================================
;; REGLAS DE CONSULTA Y BÚSQUEDA
;; ============================================

;; Mostrar todos los smartphones disponibles
(defrule mostrar-smartphones
  (smartphone (marca ?marca) (modelo ?modelo) (color ?color) (precio ?precio) (stock ?stock))
  =>
  (printout t "Smartphone: " ?marca " " ?modelo " - Color: " ?color " - Precio: $" ?precio " - Stock: " ?stock crlf))

;; Mostrar todos los computadores disponibles
(defrule mostrar-computadores
  (compu (marca ?marca) (modelo ?modelo) (color ?color) (precio ?precio) (stock ?stock))
  =>
  (printout t "Computador: " ?marca " " ?modelo " - Color: " ?color " - Precio: $" ?precio " - Stock: " ?stock crlf))

;; Mostrar todos los accesorios disponibles
(defrule mostrar-accesorios
  (accesorio (nombre ?nombre) (tipo ?tipo) (marca ?marca) (precio ?precio) (compatibilidad ?comp) (stock ?stock))
  =>
  (printout t "Accesorio: " ?nombre " (" ?tipo ") - Marca: " ?marca " - Precio: $" ?precio " - Compatible: " ?comp " - Stock: " ?stock crlf))

;; Mostrar información de clientes
(defrule mostrar-clientes
  (cliente (cliente-id ?id) (nombre ?nombre) (apellido ?apellido) (email ?email) (telefono ?tel))
  =>
  (printout t "Cliente ID: " ?id " - " ?nombre " " ?apellido " - Email: " ?email " - Tel: " ?tel crlf))

;; Mostrar información de tarjetas de crédito
(defrule mostrar-tarjetas
  (tarjetacred (tarjeta-id ?tid) (cliente-id ?cid) (banco ?banco) (grupo ?grupo) (exp-date ?exp) (limite ?lim) (disponible ?disp))
  =>
  (printout t "Tarjeta ID: " ?tid " - Cliente: " ?cid " - Banco: " ?banco " " ?grupo " - Exp: " ?exp " - Disponible: $" ?disp " / $" ?lim crlf))

;; Mostrar información de vales
(defrule mostrar-vales
  (vale (vale-id ?vid) (cliente-id ?cid) (codigo ?cod) (monto ?monto) (usado ?usado) (fecha-expiracion ?exp))
  =>
  (printout t "Vale ID: " ?vid " - Cliente: " ?cid " - Código: " ?cod " - Monto: $" ?monto " - Estado: " (if (= ?usado 1) then "USADO" else "DISPONIBLE") " - Expira: " ?exp crlf))

;; Mostrar órdenes de compra
(defrule mostrar-ordenes
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (fecha ?fecha) (total ?total) (estado ?estado) (metodo-pago ?pago))
  =>
  (printout t "Orden ID: " ?oid " - Cliente: " ?cid " - Fecha: " ?fecha " - Total: $" ?total " - Estado: " ?estado " - Pago: " ?pago crlf))

;; ============================================
;; REGLAS DE ANÁLISIS
;; ============================================

;; Buscar smartphones por marca
(defrule buscar-smartphone-por-marca
  (smartphone (marca ?marca) (modelo ?modelo) (precio ?precio) (stock ?stock))
  =>
  (printout t "Encontrado: " ?marca " " ?modelo " - $" ?precio " (Stock: " ?stock ")" crlf))

;; Buscar computadores por precio máximo
(defrule buscar-computador-precio-max
  (compu (marca ?marca) (modelo ?modelo) (precio ?precio))
  (test (<= ?precio 20000))
  =>
  (printout t "Computador económico: " ?marca " " ?modelo " - $" ?precio crlf))

;; Buscar accesorios compatibles con iPhone
(defrule buscar-accesorios-iphone
  (accesorio (nombre ?nombre) (tipo ?tipo) (precio ?precio) (compatibilidad ?comp))
  (test (or (eq ?comp iPhone) (eq ?comp universal)))
  =>
  (printout t "Accesorio compatible iPhone: " ?nombre " (" ?tipo ") - $" ?precio crlf))

;; Verificar tarjetas próximas a vencer
(defrule tarjetas-por-vencer
  (tarjetacred (tarjeta-id ?tid) (cliente-id ?cid) (banco ?banco) (exp-date ?exp))
  (test (or (eq ?exp "06-11-24") (eq ?exp "12-10-24")))
  =>
  (printout t "ALERTA: Tarjeta ID " ?tid " del cliente " ?cid " (" ?banco ") vence pronto: " ?exp crlf))

;; Verificar vales disponibles
(defrule vales-disponibles
  (vale (vale-id ?vid) (cliente-id ?cid) (codigo ?cod) (monto ?monto) (usado 0))
  =>
  (printout t "Vale disponible: " ?cod " - Cliente " ?cid " - Monto: $" ?monto crlf))

;; ============================================
;; REGLAS DE VALIDACIÓn
;; ============================================

;; Verificar si hay stock disponible
(defrule verificar-stock-smartphone
  (smartphone (marca ?marca) (modelo ?modelo) (stock ?stock))
  (test (< ?stock 5))
  =>
  (printout t "ALERTA STOCK: " ?marca " " ?modelo " tiene solo " ?stock " unidades" crlf))

;; Verificar si hay stock disponible en computadores
(defrule verificar-stock-computador
  (compu (marca ?marca) (modelo ?modelo) (stock ?stock))
  (test (< ?stock 5))
  =>
  (printout t "ALERTA STOCK: " ?marca " " ?modelo " tiene solo " ?stock " unidades" crlf))

;; Verificar vales expirados
(defrule vales-expirados
  (vale (vale-id ?vid) (codigo ?cod) (cliente-id ?cid) (fecha-expiracion ?exp) (usado 0))
  (test (or (eq ?exp "2024-01-20") (eq ?exp "2024-02-10")))
  =>
  (printout t "ALERTA: Vale " ?cod " del cliente " ?cid " expiró el " ?exp crlf))

;; ============================================
;; REGLAS DE REPORTE
;; ============================================

;; Resumen de inventario
(defrule resumen-inventario
  =>
  (printout t crlf "=== RESUMEN DE INVENTARIO ===" crlf)
  (printout t "Ejecute 'run' para ver detalles" crlf))

;; Resumen de clientes
(defrule resumen-clientes
  =>
  (printout t crlf "=== RESUMEN DE CLIENTES ===" crlf)
  (printout t "Ejecute 'run' para ver detalles" crlf))

