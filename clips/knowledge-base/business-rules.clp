;; ============================================
;; REGLAS DE NEGOCIO - CONDICIÓN-ACCIÓN
;; ============================================

;; ============================================
;; REGLAS SOLICITADAS ESPECÍFICAMENTE
;; ============================================

;; REGLA 1: iPhone 16 con tarjeta Banamex Oro -> 24 meses sin intereses
(defrule oferta-iphone16-banamex
  (declare (salience 100))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca apple) (modelo iPhone16))
  (tarjetacred (cliente-id ?cid) (banco banamex) (grupo oro))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "24 meses sin intereses en iPhone 16 con tarjeta Banamex Oro")
            (meses 24)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente " ?cid " - Orden " ?oid crlf)
  (printout t "iPhone 16 con tarjeta Banamex Oro: 24 MESES SIN INTERESES" crlf)
  (printout t "========================================" crlf))

;; REGLA 2: Samsung Note 21 con tarjeta Liverpool VISA -> 12 meses sin intereses
(defrule oferta-samsung-note21-liverpool
  (declare (salience 99))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca samsung) (modelo Note21))
  (tarjetacred (cliente-id ?cid) (banco liverpool) (grupo visa))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "12 meses sin intereses en Samsung Note 21 con tarjeta Liverpool VISA")
            (meses 12)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente " ?cid " - Orden " ?oid crlf)
  (printout t "Samsung Note 21 con tarjeta Liverpool VISA: 12 MESES SIN INTERESES" crlf)
  (printout t "========================================" crlf))

;; REGLA 3: MacBook Air + iPhone16 al contado -> 100 pesos en vales por cada 1000 pesos
(defrule oferta-macbook-iphone-contado
  (declare (salience 98))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca apple) (modelo macbookair))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca apple) (modelo iPhone16))
  (orden-compra (orden-id ?oid) (total ?total) (metodo-pago efectivo))
  (not (oferta (orden-id ?oid) (tipo-oferta vale-regalo)))
  =>
  (bind ?monto-vale (* (div ?total 1000.0) 100.0))
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta vale-regalo)
            (descripcion "Vale por compra al contado de MacBook Air + iPhone16")
            (monto-vale ?monto-vale)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente " ?cid " - Orden " ?oid crlf)
  (printout t "MacBook Air + iPhone16 al contado (Total: $" ?total ")" crlf)
  (printout t "VALE REGALO: $" ?monto-vale " (100 pesos por cada 1000 pesos)" crlf)
  (printout t "========================================" crlf))

;; REGLA 4: Compra de Smartphone -> ofrecer funda y mica con 15% descuento
(defrule oferta-accesorios-smartphone
  (declare (salience 97))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca ?marca) (modelo ?modelo))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-accesorios)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-accesorios)
            (descripcion "15% descuento en funda y mica protectora")
            (descuento-porcentaje 15)
            (aplicada 0)))
  (printout t crlf ">>> OFERTA APLICADA <<<" crlf)
  (printout t "Cliente " ?cid " - Orden " ?oid crlf)
  (printout t "Compra de Smartphone " ?marca " " ?modelo crlf)
  (printout t "OFERTA: Funda y mica protectora con 15% DESCUENTO" crlf)
  (printout t "========================================" crlf))

;; ============================================
;; REGLAS ADICIONALES DE NEGOCIO (20+ REGLAS)
;; ============================================

;; REGLA 5: Compra de MacBook Pro -> ofrecer 18 meses sin intereses con cualquier tarjeta
(defrule oferta-macbookpro-meses-intereses
  (declare (salience 96))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca apple) (modelo macbookpro))
  (tarjetacred (cliente-id ?cid))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "18 meses sin intereses en MacBook Pro")
            (meses 18)
            (aplicada 0)))
  (printout t "Oferta: MacBook Pro - 18 meses sin intereses (Orden " ?oid ")" crlf))

;; REGLA 6: Cliente nuevo (menos de 30 días) -> 10% descuento en primera compra
(defrule descuento-cliente-nuevo
  (declare (salience 95))
  (cliente (cliente-id ?cid) (fecha-registro ?fecha))
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (total ?total))
  (test (or (eq ?fecha "2024-04-05") (eq ?fecha "2024-03-10")))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-cliente-nuevo)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-cliente-nuevo)
            (descripcion "10% descuento cliente nuevo")
            (descuento-porcentaje 10)
            (aplicada 0)))
  (printout t "Oferta: Cliente nuevo - 10% descuento en primera compra (Orden " ?oid ")" crlf))

;; REGLA 7: Compra mayor a $40000 -> vale de $2000
(defrule vale-compra-mayor
  (declare (salience 94))
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (total ?total))
  (test (> ?total 40000))
  (not (oferta (orden-id ?oid) (tipo-oferta vale-regalo)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta vale-regalo)
            (descripcion "Vale por compra mayor a $40000")
            (monto-vale 2000.0)
            (aplicada 0)))
  (printout t "Oferta: Compra mayor a $40000 - Vale de $2000 (Orden " ?oid ")" crlf))

;; REGLA 8: Compra de iPhone 15 o superior -> cargador inalámbrico gratis
(defrule regalo-cargador-iphone15
  (declare (salience 93))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca apple) (modelo ?modelo))
  (test (or (eq ?modelo iPhone15) (eq ?modelo iPhone16)))
  (not (oferta (orden-id ?oid) (tipo-oferta regalo-cargador)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta regalo-cargador)
            (descripcion "Cargador inalámbrico gratis con iPhone 15/16")
            (aplicada 0)))
  (printout t "Oferta: iPhone 15/16 - Cargador inalámbrico GRATIS (Orden " ?oid ")" crlf))

;; REGLA 9: Compra de 2 o más productos Apple -> 5% descuento adicional
(defrule descuento-multiples-apple
  (declare (salience 92))
  ?item1 <- (item-orden (orden-id ?oid) (cliente-id ?cid) (marca apple) (modelo ?modelo1))
  ?item2 <- (item-orden (orden-id ?oid) (cliente-id ?cid) (marca apple) (modelo ?modelo2))
  (test (neq ?modelo1 ?modelo2))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-multiples)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-multiples)
            (descripcion "5% descuento por comprar 2+ productos Apple")
            (descuento-porcentaje 5)
            (aplicada 0)))
  (printout t "Oferta: 2+ productos Apple - 5% descuento adicional (Orden " ?oid ")" crlf))

;; REGLA 10: Compra de computador -> mouse y teclado con 20% descuento
(defrule oferta-accesorios-computador
  (declare (salience 91))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-perifericos)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-perifericos)
            (descripcion "20% descuento en mouse y teclado")
            (descuento-porcentaje 20)
            (aplicada 0)))
  (printout t "Oferta: Compra de computador - Mouse y teclado 20% descuento (Orden " ?oid ")" crlf))

;; REGLA 11: Tarjeta BBVA Visa -> 6 meses sin intereses en compras mayores a $15000
(defrule meses-bbva-visa
  (declare (salience 90))
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (total ?total) (metodo-pago tarjeta))
  (test (> ?total 15000))
  (tarjetacred (cliente-id ?cid) (banco bbva) (grupo visa))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "6 meses sin intereses con BBVA Visa")
            (meses 6)
            (aplicada 0)))
  (printout t "Oferta: BBVA Visa - 6 meses sin intereses (Orden " ?oid ")" crlf))

;; REGLA 12: Compra de Samsung Galaxy S24 -> funda protectora gratis
(defrule regalo-funda-samsung
  (declare (salience 89))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca samsung) (modelo GalaxyS24))
  (not (oferta (orden-id ?oid) (tipo-oferta regalo-funda)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta regalo-funda)
            (descripcion "Funda protectora gratis con Samsung Galaxy S24")
            (aplicada 0)))
  (printout t "Oferta: Samsung Galaxy S24 - Funda protectora GRATIS (Orden " ?oid ")" crlf))

;; REGLA 13: Compra al contado mayor a $50000 -> 5% descuento adicional
(defrule descuento-contado-mayor
  (declare (salience 88))
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (total ?total) (metodo-pago efectivo))
  (test (> ?total 50000))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-contado)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-contado)
            (descripcion "5% descuento adicional por pago al contado mayor a $50000")
            (descuento-porcentaje 5)
            (aplicada 0)))
  (printout t "Oferta: Pago al contado > $50000 - 5% descuento adicional (Orden " ?oid ")" crlf))

;; REGLA 14: Compra de iMac -> auriculares inalámbricos con 25% descuento
(defrule oferta-auriculares-imac
  (declare (salience 87))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca apple) (modelo imac))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-auriculares)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-auriculares)
            (descripcion "25% descuento en auriculares inalámbricos")
            (descuento-porcentaje 25)
            (aplicada 0)))
  (printout t "Oferta: iMac - Auriculares inalámbricos 25% descuento (Orden " ?oid ")" crlf))

;; REGLA 15: Cliente con tarjeta Santander -> 3 meses sin intereses en productos mayores a $10000
(defrule meses-santander
  (declare (salience 86))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (precio ?precio))
  (test (> ?precio 10000))
  (tarjetacred (cliente-id ?cid) (banco santander))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "3 meses sin intereses con tarjeta Santander")
            (meses 3)
            (aplicada 0)))
  (printout t "Oferta: Santander - 3 meses sin intereses (Orden " ?oid ")" crlf))

;; REGLA 16: Compra de Xiaomi -> vale de $500 para próxima compra
(defrule vale-xiaomi
  (declare (salience 85))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca xiaomi))
  (not (oferta (orden-id ?oid) (tipo-oferta vale-regalo)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta vale-regalo)
            (descripcion "Vale de $500 por compra de Xiaomi")
            (monto-vale 500.0)
            (aplicada 0)))
  (printout t "Oferta: Xiaomi - Vale de $500 para próxima compra (Orden " ?oid ")" crlf))

;; REGLA 17: Compra de Dell XPS -> soporte para laptop gratis
(defrule regalo-soporte-dell
  (declare (salience 84))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca dell) (modelo xps15))
  (not (oferta (orden-id ?oid) (tipo-oferta regalo-soporte)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta regalo-soporte)
            (descripcion "Soporte para laptop gratis con Dell XPS")
            (aplicada 0)))
  (printout t "Oferta: Dell XPS - Soporte para laptop GRATIS (Orden " ?oid ")" crlf))

;; REGLA 18: Compra de accesorios mayor a $5000 -> 10% descuento
(defrule descuento-accesorios-mayor
  (declare (salience 83))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto accesorio) (precio ?precio))
  (test (> ?precio 2000))
  (orden-compra (orden-id ?oid) (total ?total))
  (test (> ?total 5000))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-accesorios)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-accesorios)
            (descripcion "10% descuento en accesorios mayor a $5000")
            (descuento-porcentaje 10)
            (aplicada 0)))
  (printout t "Oferta: Accesorios > $5000 - 10% descuento (Orden " ?oid ")" crlf))

;; REGLA 19: Tarjeta HSBC American Express -> 9 meses sin intereses en compras mayores a $25000
(defrule meses-hsbc-amex
  (declare (salience 82))
  (orden-compra (orden-id ?oid) (cliente-id ?cid) (total ?total) (metodo-pago tarjeta))
  (test (> ?total 25000))
  (tarjetacred (cliente-id ?cid) (banco hsbc) (grupo american))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "9 meses sin intereses con HSBC American Express")
            (meses 9)
            (aplicada 0)))
  (printout t "Oferta: HSBC Amex - 9 meses sin intereses (Orden " ?oid ")" crlf))

;; REGLA 20: Compra de Lenovo ThinkPad -> teclado mecánico con 30% descuento
(defrule oferta-teclado-lenovo
  (declare (salience 81))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca lenovo) (modelo thinkpad))
  (not (oferta (orden-id ?oid) (tipo-oferta descuento-teclado)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta descuento-teclado)
            (descripcion "30% descuento en teclado mecánico")
            (descuento-porcentaje 30)
            (aplicada 0)))
  (printout t "Oferta: Lenovo ThinkPad - Teclado mecánico 30% descuento (Orden " ?oid ")" crlf))

;; REGLA 21: Compra de Huawei -> protector de pantalla gratis
(defrule regalo-protector-huawei
  (declare (salience 80))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone) (marca huawei))
  (not (oferta (orden-id ?oid) (tipo-oferta regalo-protector)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta regalo-protector)
            (descripcion "Protector de pantalla gratis con Huawei")
            (aplicada 0)))
  (printout t "Oferta: Huawei - Protector de pantalla GRATIS (Orden " ?oid ")" crlf))

;; REGLA 22: Compra de HP Pavilion -> vale de $1000 para accesorios
(defrule vale-accesorios-hp
  (declare (salience 79))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca hp) (modelo pavilion))
  (not (oferta (orden-id ?oid) (tipo-oferta vale-regalo)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta vale-regalo)
            (descripcion "Vale de $1000 para accesorios")
            (monto-vale 1000.0)
            (aplicada 0)))
  (printout t "Oferta: HP Pavilion - Vale de $1000 para accesorios (Orden " ?oid ")" crlf))

;; REGLA 23: Compra de Dell Inspiron -> 12 meses sin intereses con cualquier tarjeta
(defrule meses-dell-inspiron
  (declare (salience 78))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto compu) (marca dell) (modelo inspiron))
  (tarjetacred (cliente-id ?cid))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "12 meses sin intereses en Dell Inspiron")
            (meses 12)
            (aplicada 0)))
  (printout t "Oferta: Dell Inspiron - 12 meses sin intereses (Orden " ?oid ")" crlf))

;; REGLA 24: Tarjeta Banorte Visa -> 6 meses sin intereses en smartphones
(defrule meses-banorte-smartphone
  (declare (salience 77))
  (item-orden (orden-id ?oid) (cliente-id ?cid) (tipo-producto smartphone))
  (tarjetacred (cliente-id ?cid) (banco banorte) (grupo visa))
  (orden-compra (orden-id ?oid) (metodo-pago tarjeta))
  (not (oferta (orden-id ?oid) (tipo-oferta meses-sin-intereses)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta meses-sin-intereses)
            (descripcion "6 meses sin intereses con Banorte Visa en smartphones")
            (meses 6)
            (aplicada 0)))
  (printout t "Oferta: Banorte Visa - 6 meses sin intereses en smartphones (Orden " ?oid ")" crlf))

;; REGLA 25: Compra de 3 o más productos -> envío gratis + vale de $500
(defrule oferta-multiples-productos
  (declare (salience 76))
  ?item1 <- (item-orden (orden-id ?oid) (cliente-id ?cid) (modelo ?modelo1))
  ?item2 <- (item-orden (orden-id ?oid) (cliente-id ?cid) (modelo ?modelo2))
  ?item3 <- (item-orden (orden-id ?oid) (cliente-id ?cid) (modelo ?modelo3))
  (test (and (neq ?modelo1 ?modelo2) (neq ?modelo1 ?modelo3) (neq ?modelo2 ?modelo3)))
  (not (oferta (orden-id ?oid) (tipo-oferta envio-gratis)))
  =>
  (assert (oferta 
            (oferta-id ?oid) 
            (orden-id ?oid)
            (cliente-id ?cid)
            (tipo-oferta envio-gratis)
            (descripcion "Envío gratis + vale de $500 por comprar 3+ productos")
            (monto-vale 500.0)
            (aplicada 0)))
  (printout t "Oferta: 3+ productos - Envío gratis + vale $500 (Orden " ?oid ")" crlf))

;; ============================================
;; REGLAS DE REPORTE DE OFERTAS
;; ============================================

;; Mostrar todas las ofertas aplicadas
(defrule mostrar-ofertas
  (declare (salience 10))
  (oferta (orden-id ?oid) (cliente-id ?cid) (tipo-oferta ?tipo) (descripcion ?desc) (aplicada 0))
  =>
  (printout t "Oferta pendiente - Orden: " ?oid " | Cliente: " ?cid " | " ?desc crlf))

