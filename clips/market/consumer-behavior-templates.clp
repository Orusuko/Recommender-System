;; ============================================
;; TEMPLATES PARA ANÁLISIS DE CONDUCTAS DE CONSUMO
;; ============================================

;; Template para almacenar estadísticas de consumo por cliente
(deftemplate customer-consumption-stats
  (slot customer-id)
  (slot total-orders (type INTEGER) (default 0))
  (slot total-spent (type FLOAT) (default 0.0))
  (slot average-order-value (type FLOAT) (default 0.0))
  (slot favorite-category)
  (slot last-order-date)
  (slot days-since-last-order (type INTEGER) (default 0))
  (slot customer-segment)  ; VIP, Regular, Inactivo, Nuevo
)

;; Template para análisis de patrones de compra
(deftemplate purchase-pattern
  (slot customer-id)
  (slot pattern-type)  ; bulk-buyer, frequent-buyer, occasional, seasonal
  (slot confidence (type FLOAT) (default 0.0))
  (slot evidence-count (type INTEGER) (default 0))
)

;; Template para análisis de productos por categoría
(deftemplate category-analysis
  (slot category)
  (slot total-sales (type INTEGER) (default 0))
  (slot total-revenue (type FLOAT) (default 0.0))
  (slot average-price (type FLOAT) (default 0.0))
  (slot popularity-score (type FLOAT) (default 0.0))
)

;; Template para recomendaciones de marketing
(deftemplate marketing-recommendation
  (slot customer-id)
  (slot recommendation-type)  ; discount, upsell, cross-sell, reactivation
  (slot target-product)
  (slot discount-percentage (type INTEGER) (default 0))
  (slot priority (type INTEGER) (default 0))  ; 1=alta, 2=media, 3=baja
  (slot reason)
)

;; Template para análisis de comportamiento temporal
(deftemplate temporal-behavior
  (slot customer-id)
  (slot purchase-frequency)  ; daily, weekly, monthly, quarterly, yearly
  (slot preferred-category)
  (slot price-sensitivity)  ; high, medium, low
  (slot brand-loyalty (type FLOAT) (default 0.0))
)

;; Template para órdenes extendidas con fecha
(deftemplate order-extended
  (slot order-number)
  (slot customer-id)
  (slot order-date)
  (slot order-total (type FLOAT) (default 0.0))
  (slot item-count (type INTEGER) (default 0))
)

;; Template para análisis de valor de cliente (CLV)
(deftemplate customer-lifetime-value
  (slot customer-id)
  (slot clv-score (type FLOAT) (default 0.0))
  (slot predicted-future-value (type FLOAT) (default 0.0))
  (slot retention-probability (type FLOAT) (default 0.0))
  (slot risk-level)  ; low, medium, high
)

;; Templates para hechos intermedios de procesamiento
(deftemplate order-processed
  (slot order-number)
)

(deftemplate order-total-processed
  (slot order-number)
)

(deftemplate category-preference
  (slot customer-id)
  (slot category)
  (slot order-number)
)

(deftemplate category-count
  (slot customer-id)
  (slot category)
  (slot count (type INTEGER))
)

(deftemplate segment-threshold
  (slot segment)
  (slot min-spent (type FLOAT) (default 0.0))
  (slot min-orders (type INTEGER) (default 0))
  (slot max-days-inactive (type INTEGER) (default 0))
  (slot max-days-since-registration (type INTEGER) (default 0))
)

(deftemplate current-date
  (slot date (default "2024-04-15"))
)

