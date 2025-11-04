;; ============================================
;; HECHOS EXTENDIDOS PARA ANÁLISIS DE CONSUMO
;; ============================================

;; Datos históricos adicionales de órdenes
(deffacts historical-orders
  ;; Órdenes del cliente 102 (mary)
  (order-extended (order-number 300) (customer-id 102) (order-date "2024-01-15") (order-total 199.99) (item-count 1))
  (order-extended (order-number 305) (customer-id 102) (order-date "2024-02-20") (order-total 399.99) (item-count 1))
  (order-extended (order-number 310) (customer-id 102) (order-date "2024-03-10") (order-total 99.99) (item-count 1))
  
  ;; Órdenes del cliente 103 (bob)
  (order-extended (order-number 301) (customer-id 103) (order-date "2024-01-20") (order-total 3999.90) (item-count 10))
  (order-extended (order-number 306) (customer-id 103) (order-date "2024-02-25") (order-total 199.99) (item-count 1))
  (order-extended (order-number 311) (customer-id 103) (order-date "2024-04-05") (order-total 399.99) (item-count 1))
  
  ;; Órdenes adicionales para otros clientes
  (order-extended (order-number 302) (customer-id 104) (order-date "2024-03-01") (order-total 199.99) (item-count 1))
  (order-extended (order-number 303) (customer-id 104) (order-date "2024-03-15") (order-total 99.99) (item-count 1))
)

;; Items adicionales para análisis
(deffacts extended-items
  ;; Items de órdenes históricas
  (line-item (order-number 305) (customer-id 102) (part-number 2341) (quantity 1))
  (line-item (order-number 310) (customer-id 102) (part-number 3412) (quantity 1))
  
  (line-item (order-number 306) (customer-id 103) (part-number 1234) (quantity 1))
  (line-item (order-number 311) (customer-id 103) (part-number 2341) (quantity 1))
  
  (line-item (order-number 302) (customer-id 104) (part-number 1234) (quantity 1))
  (line-item (order-number 303) (customer-id 104) (part-number 3412) (quantity 1))
)

;; Más clientes para análisis
(deffacts additional-customers
  (customer (customer-id 104) (name alice) (address "123 Main St") (phone 3311111111))
  (customer (customer-id 105) (name charlie) (address "456 Oak Ave") (phone 3322222222))
)

;; Más productos para análisis
(deffacts additional-products
  (product (name "SSD 1TB") (category storage) (part-number 1235) (price 149.99))
  (product (name "HDD 2TB") (category storage) (part-number 1236) (price 89.99))
  (product (name "Bluetooth Speaker") (category electronics) (part-number 2342) (price 79.99))
  (product (name "Wireless Mouse") (category electronics) (part-number 2343) (price 29.99))
  (product (name "Mechanical Keyboard") (category mechanics) (part-number 3413) (price 129.99))
)

;; Configuración de segmentos
(deffacts segment-definitions
  (segment-threshold (segment VIP) (min-spent 1000.0) (min-orders 3))
  (segment-threshold (segment Regular) (min-spent 200.0) (min-orders 1))
  (segment-threshold (segment Inactivo) (max-days-inactive 90))
  (segment-threshold (segment Nuevo) (max-days-since-registration 30))
)

;; Fecha actual para cálculos
(deffacts current-date
  (current-date (date "2024-04-15"))
)

