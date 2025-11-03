;; ============================================
;; BASE DE CONOCIMIENTOS - TEMPLATES
;; ============================================

;; Template para Smartphones
(deftemplate smartphone
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio (type FLOAT))
  (slot almacenamiento (default ""))
  (slot sistema-operativo (default ""))
  (slot stock (type INTEGER) (default 0))
)

;; Template para Computadores
(deftemplate compu
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio (type FLOAT))
  (slot procesador (default ""))
  (slot memoria-ram (default ""))
  (slot disco-duro (default ""))
  (slot stock (type INTEGER) (default 0))
)

;; Template para Accesorios
(deftemplate accesorio
  (slot nombre)
  (slot tipo)  ; cable, funda, cargador, auriculares, etc.
  (slot marca)
  (slot precio (type FLOAT))
  (slot compatibilidad)  ; iPhone, Samsung, universal, etc.
  (slot stock (type INTEGER) (default 0))
)

;; Template para Clientes
(deftemplate cliente
  (slot cliente-id (type INTEGER))
  (slot nombre)
  (slot apellido)
  (slot email)
  (slot telefono)
  (slot direccion)
  (slot fecha-registro)
)

;; Template para Orden de Compra
(deftemplate orden-compra
  (slot orden-id (type INTEGER))
  (slot cliente-id (type INTEGER))
  (slot fecha)
  (slot total (type FLOAT) (default 0.0))
  (slot estado)  ; pendiente, procesada, completada, cancelada
  (slot metodo-pago)  ; tarjeta, efectivo, vale
)

;; Template para Tarjetas de Crédito
(deftemplate tarjetacred
  (slot tarjeta-id (type INTEGER))
  (slot cliente-id (type INTEGER))
  (slot banco)
  (slot grupo)  ; visa, mastercard, american express, etc.
  (slot numero (default ""))
  (slot exp-date)  ; fecha de expiración formato MM-YY o MM-AA-YY
  (slot limite (type FLOAT) (default 0.0))
  (slot disponible (type FLOAT) (default 0.0))
)

;; Template para Vales
(deftemplate vale
  (slot vale-id (type INTEGER))
  (slot cliente-id (type INTEGER))
  (slot codigo)
  (slot monto (type FLOAT))
  (slot fecha-emision)
  (slot fecha-expiracion)
  (slot usado (type INTEGER) (default 0))  ; 0=no usado, 1=usado
  (slot descripcion (default ""))
)

;; Template para Items de Orden (productos en una orden)
(deftemplate item-orden
  (slot orden-id (type INTEGER))
  (slot cliente-id (type INTEGER))
  (slot tipo-producto)  ; smartphone, compu, accesorio
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio (type FLOAT))
  (slot cantidad (type INTEGER) (default 1))
)

;; Template para Ofertas y Promociones
(deftemplate oferta
  (slot oferta-id (type INTEGER))
  (slot orden-id (type INTEGER))
  (slot cliente-id (type INTEGER))
  (slot tipo-oferta)  ; meses-sin-intereses, descuento-accesorios, vale-regalo
  (slot descripcion)
  (slot meses (type INTEGER) (default 0))
  (slot descuento-porcentaje (type INTEGER) (default 0))
  (slot monto-vale (type FLOAT) (default 0.0))
  (slot aplicada (type INTEGER) (default 0))  ; 0=no aplicada, 1=aplicada
)

;; Template para órdenes simples (sin cliente específico)
;; Nota: CLIPS no soporta hechos anidados directamente
;; Se usa: (assert (orden (marca apple) (modelo iphone16) (qty 30)))
(deftemplate orden
  (slot marca)
  (slot modelo)
  (slot qty (type INTEGER) (default 1))
  (slot tipo-cliente)  ; menudista, mayorista
  (slot procesada (type INTEGER) (default 0))  ; 0=no procesada, 1=procesada
)

;; Template para clasificación de clientes
(deftemplate cliente-tipo
  (slot orden-id (type INTEGER))
  (slot qty (type INTEGER))
  (slot tipo)  ; menudista, mayorista
  (slot descuento-aplicado (type INTEGER) (default 0))
)

;; Template para actualización de stock
(deftemplate stock-actualizado
  (slot marca)
  (slot modelo)
  (slot stock-anterior (type INTEGER))
  (slot cantidad-comprada (type INTEGER))
  (slot stock-nuevo (type INTEGER))
)

