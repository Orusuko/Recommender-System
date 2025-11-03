;; ============================================
;; REGLAS DE RAZONAMIENTO PARA ÓRDENES SIMPLES
;; ============================================
;;
;; NOTA: CLIPS no soporta hechos anidados directamente
;; Para usar el sistema, ejecute:
;;   (assert (orden (marca apple) (modelo iphone16) (qty 30)))
;;   (run)
;;
;; El sistema automáticamente:
;;   1. Clasifica el cliente (menudista/mayorista)
;;   2. Aplica ofertas y descuentos
;;   3. Genera recomendaciones
;;   4. Actualiza el stock
;; ============================================

;; ============================================
;; REGLAS DE CLASIFICACIÓN DE CLIENTES
;; ============================================

;; Clasificar cliente como MENUDISTA (qty < 10) - cuando tipo es nil
(defrule clasificar-menudista-nil
  (declare (salience 100))
  ?orden <- (orden (marca ?marca) (modelo ?modelo) (qty ?qty) (tipo-cliente nil))
  (test (< ?qty 10))
  =>
  (modify ?orden (tipo-cliente menudista))
  (assert (cliente-tipo (orden-id 0) (qty ?qty) (tipo menudista)))
  (printout t crlf ">>> CLASIFICACIÓN DE CLIENTE <<<" crlf)
  (printout t "Cantidad: " ?qty " unidades" crlf)
  (printout t "TIPO: MENUDISTA (compra < 10 unidades)" crlf)
  (printout t "========================================" crlf))

;; Clasificar cliente como MENUDISTA (qty < 10) - cuando tipo es diferente
(defrule clasificar-menudista-diferente
  (declare (salience 99))
  ?orden <- (orden (marca ?marca) (modelo ?modelo) (qty ?qty) (tipo-cliente ?tipo))
  (test (< ?qty 10))
  (test (neq ?tipo menudista))
  =>
  (modify ?orden (tipo-cliente menudista))
  (assert (cliente-tipo (orden-id 0) (qty ?qty) (tipo menudista)))
  (printout t crlf ">>> CLASIFICACIÓN DE CLIENTE <<<" crlf)
  (printout t "Cantidad: " ?qty " unidades" crlf)
  (printout t "TIPO: MENUDISTA (compra < 10 unidades)" crlf)
  (printout t "========================================" crlf))

;; Clasificar cliente como MAYORISTA (qty >= 10) - cuando tipo es nil
(defrule clasificar-mayorista-nil
  (declare (salience 98))
  ?orden <- (orden (marca ?marca) (modelo ?modelo) (qty ?qty) (tipo-cliente nil))
  (test (>= ?qty 10))
  =>
  (modify ?orden (tipo-cliente mayorista))
  (assert (cliente-tipo (orden-id 0) (qty ?qty) (tipo mayorista)))
  (printout t crlf ">>> CLASIFICACIÓN DE CLIENTE <<<" crlf)
  (printout t "Cantidad: " ?qty " unidades" crlf)
  (printout t "TIPO: MAYORISTA (compra >= 10 unidades)" crlf)
  (printout t "========================================" crlf))

;; Clasificar cliente como MAYORISTA (qty >= 10) - cuando tipo es diferente
(defrule clasificar-mayorista-diferente
  (declare (salience 97))
  ?orden <- (orden (marca ?marca) (modelo ?modelo) (qty ?qty) (tipo-cliente ?tipo))
  (test (>= ?qty 10))
  (test (neq ?tipo mayorista))
  =>
  (modify ?orden (tipo-cliente mayorista))
  (assert (cliente-tipo (orden-id 0) (qty ?qty) (tipo mayorista)))
  (printout t crlf ">>> CLASIFICACIÓN DE CLIENTE <<<" crlf)
  (printout t "Cantidad: " ?qty " unidades" crlf)
  (printout t "TIPO: MAYORISTA (compra >= 10 unidades)" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS DE OFERTAS PARA MENUDISTAS
;; ============================================

;; Oferta 1: Menudista - iPhone 16 -> 6 meses sin intereses
(defrule oferta-menudista-iphone16
  (declare (salience 95))
  (orden (marca apple) (modelo ?modelo) (qty ?qty) (tipo-cliente menudista) (procesada 0))
  (test (or (eq ?modelo iphone16) (eq ?modelo iPhone16)))
  (smartphone (marca apple) (modelo iPhone16) (precio ?precio))
  (not (oferta (orden-id 0) (tipo-oferta meses-menudista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta meses-menudista)
            (descripcion "6 meses sin intereses para cliente MENUDISTA - iPhone 16")
            (meses 6)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente MENUDISTA - iPhone 16" crlf)
  (printout t "OFERTA: 6 MESES SIN INTERESES" crlf)
  (printout t "========================================" crlf))

;; Oferta 2: Menudista - Descuento 5% en accesorios
(defrule descuento-menudista-accesorios
  (declare (salience 94))
  (orden (tipo-cliente menudista) (procesada 0))
  (not (oferta (orden-id 0) (tipo-oferta descuento-accesorios-menudista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta descuento-accesorios-menudista)
            (descripcion "5% descuento en accesorios para cliente MENUDISTA")
            (descuento-porcentaje 5)
            (aplicada 0)))
  (printout t crlf ">>> DESCUENTO APLICADO <<<" crlf)
  (printout t "Cliente MENUDISTA" crlf)
  (printout t "DESCUENTO: 5% en accesorios" crlf)
  (printout t "========================================" crlf))

;; Oferta 3: Menudista - Vale de $500
(defrule vale-menudista
  (declare (salience 93))
  (orden (tipo-cliente menudista) (qty ?qty) (procesada 0))
  (test (>= ?qty 3))
  (not (oferta (orden-id 0) (tipo-oferta vale-menudista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta vale-menudista)
            (descripcion "Vale de $500 para cliente MENUDISTA (compra 3+ unidades)")
            (monto-vale 500.0)
            (aplicada 0)))
  (printout t crlf ">>> VALE APLICADO <<<" crlf)
  (printout t "Cliente MENUDISTA - Compra de 3+ unidades" crlf)
  (printout t "VALE REGALO: $500" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS DE OFERTAS PARA MAYORISTAS
;; ============================================

;; Oferta 1: Mayorista - iPhone 16 -> 12 meses sin intereses
(defrule oferta-mayorista-iphone16
  (declare (salience 92))
  (orden (marca apple) (modelo ?modelo) (qty ?qty) (tipo-cliente mayorista) (procesada 0))
  (test (or (eq ?modelo iphone16) (eq ?modelo iPhone16)))
  (smartphone (marca apple) (modelo iPhone16) (precio ?precio))
  (not (oferta (orden-id 0) (tipo-oferta meses-mayorista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta meses-mayorista)
            (descripcion "12 meses sin intereses para cliente MAYORISTA - iPhone 16")
            (meses 12)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente MAYORISTA - iPhone 16" crlf)
  (printout t "OFERTA: 12 MESES SIN INTERESES" crlf)
  (printout t "========================================" crlf))

;; Oferta 2: Mayorista - Descuento 10% en accesorios
(defrule descuento-mayorista-accesorios
  (declare (salience 91))
  (orden (tipo-cliente mayorista) (procesada 0))
  (not (oferta (orden-id 0) (tipo-oferta descuento-accesorios-mayorista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta descuento-accesorios-mayorista)
            (descripcion "10% descuento en accesorios para cliente MAYORISTA")
            (descuento-porcentaje 10)
            (aplicada 0)))
  (printout t crlf ">>> DESCUENTO APLICADO <<<" crlf)
  (printout t "Cliente MAYORISTA" crlf)
  (printout t "DESCUENTO: 10% en accesorios" crlf)
  (printout t "========================================" crlf))

;; Oferta 3: Mayorista - Descuento adicional 5% en compra
(defrule descuento-mayorista-compra
  (declare (salience 90))
  (orden (marca ?marca) (modelo ?modelo) (tipo-cliente mayorista) (qty ?qty) (procesada 0))
  (test (>= ?qty 10))
  (smartphone (marca ?marca) (modelo ?modelo-producto) (precio ?precio))
  (test (or (and (or (eq ?modelo iphone16) (eq ?modelo iPhone16)) (eq ?modelo-producto iPhone16))
            (and (not (eq ?modelo iphone16)) (not (eq ?modelo iPhone16)) (eq ?modelo ?modelo-producto))))
  (not (oferta (orden-id 0) (tipo-oferta descuento-mayorista-compra)))
  =>
  (bind ?total (* ?precio ?qty))
  (bind ?descuento (* ?total 0.05))
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta descuento-mayorista-compra)
            (descripcion "5% descuento adicional en compra para cliente MAYORISTA")
            (descuento-porcentaje 5)
            (aplicada 0)))
  (printout t crlf ">>> DESCUENTO APLICADO <<<" crlf)
  (printout t "Cliente MAYORISTA - Compra de " ?qty " unidades" crlf)
  (printout t "Total: $" ?total " - Descuento: $" ?descuento " (5%)" crlf)
  (printout t "DESCUENTO: 5% adicional en compra" crlf)
  (printout t "========================================" crlf))

;; Oferta 4: Mayorista - Vale de $2000
(defrule vale-mayorista
  (declare (salience 89))
  (orden (tipo-cliente mayorista) (qty ?qty) (procesada 0))
  (test (>= ?qty 10))
  (not (oferta (orden-id 0) (tipo-oferta vale-mayorista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta vale-mayorista)
            (descripcion "Vale de $2000 para cliente MAYORISTA")
            (monto-vale 2000.0)
            (aplicada 0)))
  (printout t crlf ">>> VALE APLICADO <<<" crlf)
  (printout t "Cliente MAYORISTA - Compra de " ?qty " unidades" crlf)
  (printout t "VALE REGALO: $2000" crlf)
  (printout t "========================================" crlf))

;; Oferta 5: Mayorista - Envío gratis
(defrule envio-gratis-mayorista
  (declare (salience 88))
  (orden (tipo-cliente mayorista) (qty ?qty) (procesada 0))
  (test (>= ?qty 20))
  (not (oferta (orden-id 0) (tipo-oferta envio-gratis-mayorista)))
  =>
  (assert (oferta 
            (oferta-id 0)
            (orden-id 0)
            (cliente-id 0)
            (tipo-oferta envio-gratis-mayorista)
            (descripcion "Envío gratis para cliente MAYORISTA (compra 20+ unidades)")
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente MAYORISTA - Compra de " ?qty " unidades" crlf)
  (printout t "OFERTA: ENVÍO GRATIS" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS DE RECOMENDACIONES
;; ============================================

;; Recomendación para Menudista
(defrule recomendacion-menudista
  (declare (salience 85))
  (orden (tipo-cliente menudista) (marca ?marca) (modelo ?modelo) (procesada 0))
  =>
  (printout t crlf ">>> RECOMENDACIONES PARA MENUDISTA <<<" crlf)
  (printout t "1. Considere comprar 10+ unidades para obtener beneficios MAYORISTA" crlf)
  (printout t "2. Aproveche el descuento del 5% en accesorios" crlf)
  (printout t "3. Con 3+ unidades obtiene vale de $500" crlf)
  (printout t "========================================" crlf))

;; Recomendación para Mayorista
(defrule recomendacion-mayorista
  (declare (salience 84))
  (orden (tipo-cliente mayorista) (qty ?qty) (procesada 0))
  =>
  (printout t crlf ">>> RECOMENDACIONES PARA MAYORISTA <<<" crlf)
  (printout t "1. Aproveche el descuento del 10% en accesorios" crlf)
  (printout t "2. Obtiene 5% descuento adicional en la compra" crlf)
  (printout t "3. Vale de $2000 para próximas compras" crlf)
  (printout t "4. Con 20+ unidades obtiene ENVÍO GRATIS" crlf)
  (printout t "5. Considere compras periódicas para mantener beneficios" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS DE ACTUALIZACIÓN DE STOCK
;; ============================================

;; Actualizar stock de iPhone 16
(defrule actualizar-stock-iphone16
  (declare (salience 75))
  ?orden <- (orden (marca apple) (modelo ?modelo) (qty ?qty-comprada) (procesada 0))
  (test (or (eq ?modelo iphone16) (eq ?modelo iPhone16)))
  ?producto <- (smartphone (marca apple) (modelo iPhone16) (stock ?stock-actual))
  (test (>= ?stock-actual ?qty-comprada))
  =>
  (bind ?stock-nuevo (- ?stock-actual ?qty-comprada))
  (modify ?producto (stock ?stock-nuevo))
  (modify ?orden (procesada 1))
  (assert (stock-actualizado 
            (marca apple) 
            (modelo iPhone16)
            (stock-anterior ?stock-actual)
            (cantidad-comprada ?qty-comprada)
            (stock-nuevo ?stock-nuevo)))
  (printout t crlf ">>> ACTUALIZACIÓN DE STOCK <<<" crlf)
  (printout t "Producto: iPhone 16" crlf)
  (printout t "Stock anterior: " ?stock-actual " unidades" crlf)
  (printout t "Cantidad comprada: " ?qty-comprada " unidades" crlf)
  (printout t "Stock nuevo: " ?stock-nuevo " unidades" crlf)
  (printout t "========================================" crlf))

;; Alerta de stock insuficiente
(defrule alerta-stock-insuficiente
  (declare (salience 70))
  (orden (marca apple) (modelo ?modelo-orden) (qty ?qty-comprada) (procesada 0))
  (test (or (eq ?modelo-orden iphone16) (eq ?modelo-orden iPhone16)))
  (smartphone (marca apple) (modelo iPhone16) (stock ?stock-actual))
  (test (< ?stock-actual ?qty-comprada))
  =>
  (printout t crlf ">>> ALERTA: STOCK INSUFICIENTE <<<" crlf)
  (printout t "Producto: iPhone 16" crlf)
  (printout t "Stock disponible: " ?stock-actual " unidades" crlf)
  (printout t "Cantidad solicitada: " ?qty-comprada " unidades" crlf)
  (printout t "Faltan: " (- ?qty-comprada ?stock-actual) " unidades" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS DE REPORTE FINAL
;; ============================================

;; Reporte de ofertas aplicadas
(defrule reporte-ofertas-aplicadas
  (declare (salience 10))
  =>
  (printout t crlf ">>> RESUMEN DE OFERTAS Y DESCUENTOS <<<" crlf)
  (printout t "Ejecute 'run' para ver detalles" crlf))

;; Mostrar stock actualizado
(defrule mostrar-stock-actualizado
  (declare (salience 8))
  (stock-actualizado (marca ?marca) (modelo ?modelo) (stock-nuevo ?stock))
  =>
  (printout t "Stock actualizado - " ?marca " " ?modelo ": " ?stock " unidades" crlf))

