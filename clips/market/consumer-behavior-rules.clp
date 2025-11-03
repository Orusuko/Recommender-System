;; ============================================
;; REGLAS DE ANÁLISIS DE CONDUCTAS DE CONSUMO
;; ============================================

;; ============================================
;; REGLAS DE CÁLCULO DE ESTADÍSTICAS
;; ============================================

;; Inicializar estadísticas de cliente
(defrule initialize-customer-stats
  (declare (salience 100))
  (customer (customer-id ?cid))
  (not (customer-consumption-stats (customer-id ?cid)))
  =>
  (assert (customer-consumption-stats 
            (customer-id ?cid) 
            (total-orders 0)
            (total-spent 0.0)
            (average-order-value 0.0)
            (customer-segment Nuevo))))

;; Contar órdenes por cliente - método iterativo
(defrule count-order-increment
  (declare (salience 95))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-orders ?current))
  (order-extended (order-number ?order) (customer-id ?cid))
  (not (order-processed (order-number ?order)))
  (bind ?new-count (+ ?current 1))
  =>
  (assert (order-processed (order-number ?order)))
  (modify ?stats (total-orders ?new-count)))

;; Calcular total gastado - acumular desde órdenes
(defrule calculate-total-from-order
  (declare (salience 90))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-spent ?current))
  (order-extended (order-number ?order) (customer-id ?cid) (order-total ?order-total))
  (not (order-total-processed (order-number ?order)))
  (bind ?new-total (+ ?current ?order-total))
  =>
  (assert (order-total-processed (order-number ?order)))
  (modify ?stats (total-spent ?new-total)))

;; Calcular valor promedio de orden
(defrule calculate-average-order-value
  (declare (salience 85))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (total-orders ?orders) 
              (total-spent ?spent)
              (average-order-value ?current))
  (test (> ?orders 0))
  (bind ?avg (/ ?spent ?orders))
  (test (<> ?avg ?current))
  =>
  (modify ?stats (average-order-value ?avg)))

;; ============================================
;; REGLAS DE ANÁLISIS DE CATEGORÍAS
;; ============================================

;; Analizar categoría favorita de cada cliente
(defrule analyze-favorite-category
  (declare (salience 80))
  (order-extended (order-number ?order) (customer-id ?cid))
  (line-item (order-number ?order) (part-number ?part))
  (product (part-number ?part) (category ?cat))
  (not (category-preference (customer-id ?cid) (category ?cat) (order-number ?order)))
  =>
  (assert (category-preference (customer-id ?cid) (category ?cat) (order-number ?order))))

;; Determinar categoría favorita - versión simplificada (primera categoría encontrada)
(defrule determine-favorite-category-simple
  (declare (salience 75))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (favorite-category ?current))
  (category-preference (customer-id ?cid) (category ?cat))
  (test (or (eq ?current nil) (eq ?current "")))
  =>
  (modify ?stats (favorite-category ?cat)))

;; ============================================
;; REGLAS DE CLASIFICACIÓN DE SEGMENTOS
;; ============================================

;; Clasificar cliente VIP
(defrule classify-vip-customer
  (declare (salience 70))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (total-spent ?spent) 
              (total-orders ?orders)
              (customer-segment ?current))
  (segment-threshold (segment VIP) (min-spent ?min-spent) (min-orders ?min-orders))
  (test (>= ?spent ?min-spent))
  (test (>= ?orders ?min-orders))
  (test (<> ?current VIP))
  =>
  (modify ?stats (customer-segment VIP))
  (printout t "Cliente " ?cid " clasificado como VIP" crlf))

;; Clasificar cliente Regular
(defrule classify-regular-customer
  (declare (salience 65))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (total-spent ?spent) 
              (total-orders ?orders)
              (customer-segment ?current))
  (segment-threshold (segment Regular) (min-spent ?min-spent) (min-orders ?min-orders))
  (test (>= ?spent ?min-spent))
  (test (>= ?orders ?min-orders))
  (test (<> ?current Regular))
  (test (<> ?current VIP))
  =>
  (modify ?stats (customer-segment Regular))
  (printout t "Cliente " ?cid " clasificado como Regular" crlf))

;; Calcular días desde última orden
(defrule calculate-days-since-last-order
  (declare (salience 60))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (last-order-date ?last-date)
              (days-since-last-order ?current))
  (current-date (date ?today))
  (bind ?days 30)  ; Simplificado - en producción usaría cálculo real de fechas
  (test (<> ?days ?current))
  =>
  (modify ?stats (days-since-last-order ?days)))

;; Actualizar fecha de última orden
(defrule update-last-order-date
  (declare (salience 61))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (last-order-date ?current))
  (order-extended (order-number ?order) (customer-id ?cid) (order-date ?new-date))
  (test (<> ?new-date ?current))
  =>
  (modify ?stats (last-order-date ?new-date)))

;; Clasificar cliente Inactivo
(defrule classify-inactive-customer
  (declare (salience 59))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (days-since-last-order ?days)
              (customer-segment ?current))
  (segment-threshold (segment Inactivo) (max-days-inactive ?max-days))
  (test (> ?days ?max-days))
  (test (<> ?current Inactivo))
  =>
  (modify ?stats (customer-segment Inactivo))
  (printout t "Cliente " ?cid " clasificado como Inactivo (" ?days " días sin comprar)" crlf))

;; ============================================
;; REGLAS DE ANÁLISIS DE PATRONES
;; ============================================

;; Identificar cliente que compra en grandes cantidades (bulk buyer)
(defrule identify-bulk-buyer
  (declare (salience 55))
  (customer-consumption-stats (customer-id ?cid))
  (order-extended (order-number ?order) (customer-id ?cid))
  (line-item (order-number ?order) (part-number ?part) (quantity ?q))
  (test (> ?q 5))
  (not (purchase-pattern (customer-id ?cid) (pattern-type bulk-buyer)))
  =>
  (assert (purchase-pattern 
            (customer-id ?cid) 
            (pattern-type bulk-buyer) 
            (evidence-count 1)
            (confidence 0.8)))
  (printout t "Cliente " ?cid " identificado como comprador en grandes cantidades" crlf))

;; Identificar cliente frecuente
(defrule identify-frequent-buyer
  (declare (salience 54))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-orders ?orders))
  (test (>= ?orders 3))
  (not (purchase-pattern (customer-id ?cid) (pattern-type frequent-buyer)))
  =>
  (assert (purchase-pattern 
            (customer-id ?cid) 
            (pattern-type frequent-buyer) 
            (evidence-count ?orders)
            (confidence 0.75)))
  (printout t "Cliente " ?cid " identificado como comprador frecuente (" ?orders " órdenes)" crlf))

;; ============================================
;; REGLAS DE RECOMENDACIONES DE MARKETING
;; ============================================

;; Recomendación: Descuento para clientes inactivos
(defrule recommend-reactivation-discount
  (declare (salience 50))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (customer-segment Inactivo)
              (favorite-category ?fav-cat))
  (product (category ?fav-cat) (name ?prod-name) (part-number ?part))
  (not (marketing-recommendation (customer-id ?cid) (recommendation-type reactivation)))
  =>
  (assert (marketing-recommendation 
            (customer-id ?cid)
            (recommendation-type reactivation)
            (target-product ?prod-name)
            (discount-percentage 30)
            (priority 1)
            (reason "Cliente inactivo - ofrecer descuento para reactivación")))
  (printout t "RECOMENDACIÓN: Cliente " ?cid " - Descuento 30% en " ?prod-name " para reactivación" crlf))

;; Recomendación: Upsell para clientes VIP
(defrule recommend-upsell-vip
  (declare (salience 49))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (customer-segment VIP)
              (favorite-category ?fav-cat))
  (product (category ?fav-cat) (name ?prod-name) (part-number ?part) (price ?price))
  (test (> ?price 200))
  (not (marketing-recommendation (customer-id ?cid) (recommendation-type upsell)))
  =>
  (assert (marketing-recommendation 
            (customer-id ?cid)
            (recommendation-type upsell)
            (target-product ?prod-name)
            (discount-percentage 15)
            (priority 2)
            (reason "Cliente VIP - ofrecer producto premium con descuento")))
  (printout t "RECOMENDACIÓN: Cliente VIP " ?cid " - Upsell: " ?prod-name " con 15% descuento" crlf))

;; Recomendación: Descuento para nuevos clientes sin compras
(defrule recommend-new-customer-discount
  (declare (salience 47))
  (customer (customer-id ?cid))
  (not (order-extended (customer-id ?cid)))
  (not (marketing-recommendation (customer-id ?cid)))
  =>
  (assert (marketing-recommendation 
            (customer-id ?cid)
            (recommendation-type discount)
            (target-product "cualquier producto")
            (discount-percentage 25)
            (priority 1)
            (reason "Cliente nuevo sin compras - ofrecer descuento de bienvenida")))
  (printout t "RECOMENDACIÓN: Cliente nuevo " ?cid " - Descuento 25% de bienvenida" crlf))

;; Recomendación: Cross-sell basado en categoría favorita
(defrule recommend-cross-sell
  (declare (salience 48))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (favorite-category ?fav-cat))
  (order-extended (order-number ?order1) (customer-id ?cid))
  (line-item (order-number ?order1) (part-number ?part1))
  (product (category ?fav-cat) (name ?prod-name) (part-number ?part2))
  (test (<> ?part1 ?part2))
  (not (marketing-recommendation (customer-id ?cid) (recommendation-type cross-sell) (target-product ?prod-name)))
  =>
  (assert (marketing-recommendation 
            (customer-id ?cid)
            (recommendation-type cross-sell)
            (target-product ?prod-name)
            (discount-percentage 10)
            (priority 3)
            (reason "Cross-sell basado en categoría favorita")))
  (printout t "RECOMENDACIÓN: Cliente " ?cid " - Cross-sell: " ?prod-name " con 10% descuento" crlf))

;; ============================================
;; REGLAS DE ANÁLISIS DE VALOR DE CLIENTE
;; ============================================

;; Calcular Customer Lifetime Value (CLV)
(defrule calculate-clv
  (declare (salience 40))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (total-spent ?spent)
              (total-orders ?orders)
              (average-order-value ?avg))
  (test (> ?orders 0))
  (bind ?clv (* ?avg 12))  ; Proyección anual
  (not (customer-lifetime-value (customer-id ?cid)))
  =>
  (assert (customer-lifetime-value 
            (customer-id ?cid)
            (clv-score ?clv)
            (predicted-future-value ?clv)))
  (printout t "CLV calculado para cliente " ?cid ": $" ?clv crlf))

;; Evaluar riesgo de pérdida de cliente - Alto
(defrule assess-retention-risk-high
  (declare (salience 35))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (days-since-last-order ?days))
  ?clv <- (customer-lifetime-value (customer-id ?cid) (clv-score ?clv-value) (risk-level ?current-risk))
  (test (> ?days 90))
  (test (<> ?current-risk high))
  =>
  (modify ?clv 
          (risk-level high) 
          (retention-probability 0.3))
  (printout t "Cliente " ?cid " tiene riesgo HIGH de pérdida (CLV: $" ?clv-value ")" crlf))

;; Evaluar riesgo de pérdida de cliente - Medio
(defrule assess-retention-risk-medium
  (declare (salience 34))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid) 
              (days-since-last-order ?days))
  ?clv <- (customer-lifetime-value (customer-id ?cid) (clv-score ?clv-value) (risk-level ?current-risk))
  (test (> ?days 60))
  (test (<= ?days 90))
  (test (<> ?current-risk medium))
  (test (<> ?current-risk high))
  =>
  (modify ?clv 
          (risk-level medium) 
          (retention-probability 0.6))
  (printout t "Cliente " ?cid " tiene riesgo MEDIUM de pérdida (CLV: $" ?clv-value ")" crlf))

;; ============================================
;; REGLAS DE REPORTE Y RESUMEN
;; ============================================

;; Reporte de resumen de cliente
(defrule generate-customer-summary
  (declare (salience 10))
  (customer (customer-id ?cid) (name ?name))
  ?stats <- (customer-consumption-stats 
              (customer-id ?cid)
              (total-orders ?orders)
              (total-spent ?spent)
              (average-order-value ?avg)
              (customer-segment ?segment))
  ?clv <- (customer-lifetime-value (customer-id ?cid) (clv-score ?clv-value))
  =>
  (printout t crlf "=== RESUMEN DE CLIENTE ===" crlf)
  (printout t "ID: " ?cid " | Nombre: " ?name crlf)
  (printout t "Total Órdenes: " ?orders crlf)
  (printout t "Total Gastado: $" ?spent crlf)
  (printout t "Valor Promedio de Orden: $" ?avg crlf)
  (printout t "Segmento: " ?segment crlf)
  (printout t "CLV: $" ?clv-value crlf)
  (printout t "========================" crlf crlf))

;; Reporte de recomendaciones por prioridad
(defrule report-recommendations
  (declare (salience 5))
  (marketing-recommendation 
    (customer-id ?cid) 
    (recommendation-type ?type) 
    (target-product ?prod)
    (discount-percentage ?disc)
    (priority ?pri)
    (reason ?reason))
  =>
  (printout t "RECOMENDACIÓN [Prioridad " ?pri "]: Cliente " ?cid crlf)
  (printout t "  Tipo: " ?type crlf)
  (printout t "  Producto: " ?prod crlf)
  (printout t "  Descuento: " ?disc "%" crlf)
  (printout t "  Razón: " ?reason crlf crlf))

;; ============================================
;; REGLAS DE ANÁLISIS DE COMPORTAMIENTO TEMPORAL
;; ============================================

;; Analizar frecuencia de compra - versión simplificada
(defrule analyze-purchase-frequency-high
  (declare (salience 45))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-orders ?orders))
  (test (>= ?orders 10))
  (not (temporal-behavior (customer-id ?cid)))
  =>
  (assert (temporal-behavior 
            (customer-id ?cid)
            (purchase-frequency daily)))
  (printout t "Cliente " ?cid " tiene frecuencia de compra: daily" crlf))

(defrule analyze-purchase-frequency-medium
  (declare (salience 44))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-orders ?orders))
  (test (>= ?orders 5))
  (test (< ?orders 10))
  (not (temporal-behavior (customer-id ?cid)))
  =>
  (assert (temporal-behavior 
            (customer-id ?cid)
            (purchase-frequency weekly)))
  (printout t "Cliente " ?cid " tiene frecuencia de compra: weekly" crlf))

(defrule analyze-purchase-frequency-low
  (declare (salience 43))
  ?stats <- (customer-consumption-stats (customer-id ?cid) (total-orders ?orders))
  (test (>= ?orders 2))
  (test (< ?orders 5))
  (not (temporal-behavior (customer-id ?cid)))
  =>
  (assert (temporal-behavior 
            (customer-id ?cid)
            (purchase-frequency monthly)))
  (printout t "Cliente " ?cid " tiene frecuencia de compra: monthly" crlf))
