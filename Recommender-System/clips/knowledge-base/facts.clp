;; ============================================
;; BASE DE CONOCIMIENTOS - HECHOS
;; ============================================

;; ============================================
;; HECHOS DE SMARTPHONES
;; ============================================
(deffacts smartphones
  (smartphone (marca apple) (modelo iPhone16) (color rojo) (precio 27000.0) (almacenamiento "128GB") (sistema-operativo iOS) (stock 15))
  (smartphone (marca apple) (modelo iPhone15) (color negro) (precio 24000.0) (almacenamiento "256GB") (sistema-operativo iOS) (stock 8))
  (smartphone (marca apple) (modelo iPhone14) (color azul) (precio 20000.0) (almacenamiento "128GB") (sistema-operativo iOS) (stock 12))
  (smartphone (marca samsung) (modelo GalaxyS24) (color negro) (precio 25000.0) (almacenamiento "256GB") (sistema-operativo Android) (stock 10))
  (smartphone (marca samsung) (modelo GalaxyS23) (color blanco) (precio 22000.0) (almacenamiento "128GB") (sistema-operativo Android) (stock 6))
  (smartphone (marca samsung) (modelo Note21) (color negro) (precio 28000.0) (almacenamiento "256GB") (sistema-operativo Android) (stock 8))
  (smartphone (marca xiaomi) (modelo RedmiNote13) (color gris) (precio 8000.0) (almacenamiento "128GB") (sistema-operativo Android) (stock 20))
  (smartphone (marca huawei) (modelo P50) (color dorado) (precio 18000.0) (almacenamiento "256GB") (sistema-operativo HarmonyOS) (stock 5))
)

;; ============================================
;; HECHOS DE COMPUTADORES
;; ============================================
(deffacts computadores
  (compu (marca apple) (modelo macbookpro) (color gris) (precio 47000.0) (procesador "M3 Pro") (memoria-ram "16GB") (disco-duro "512GB SSD") (stock 7))
  (compu (marca apple) (modelo macbookair) (color plata) (precio 32000.0) (procesador "M2") (memoria-ram "8GB") (disco-duro "256GB SSD") (stock 12))
  (compu (marca apple) (modelo imac) (color azul) (precio 55000.0) (procesador "M3") (memoria-ram "16GB") (disco-duro "1TB SSD") (stock 3))
  (compu (marca dell) (modelo xps15) (color negro) (precio 42000.0) (procesador "Intel i7") (memoria-ram "32GB") (disco-duro "1TB SSD") (stock 8))
  (compu (marca dell) (modelo inspiron) (color gris) (precio 18000.0) (procesador "Intel i5") (memoria-ram "16GB") (disco-duro "512GB SSD") (stock 15))
  (compu (marca hp) (modelo pavilion) (color plata) (precio 15000.0) (procesador "AMD Ryzen 5") (memoria-ram "8GB") (disco-duro "256GB SSD") (stock 20))
  (compu (marca lenovo) (modelo thinkpad) (color negro) (precio 35000.0) (procesador "Intel i7") (memoria-ram "16GB") (disco-duro "512GB SSD") (stock 10))
)

;; ============================================
;; HECHOS DE ACCESORIOS
;; ============================================
(deffacts accesorios
  (accesorio (nombre "Cable USB-C") (tipo cable) (marca anker) (precio 500.0) (compatibilidad universal) (stock 50))
  (accesorio (nombre "Cable Lightning") (tipo cable) (marca apple) (precio 800.0) (compatibilidad iPhone) (stock 30))
  (accesorio (nombre "Funda iPhone 16") (tipo funda) (marca spigen) (precio 1200.0) (compatibilidad iPhone16) (stock 25))
  (accesorio (nombre "Funda Samsung Galaxy") (tipo funda) (marca samsung) (precio 1000.0) (compatibilidad GalaxyS24) (stock 20))
  (accesorio (nombre "Cargador Rápido 20W") (tipo cargador) (marca anker) (precio 600.0) (compatibilidad universal) (stock 40))
  (accesorio (nombre "Auriculares Inalámbricos") (tipo auriculares) (marca sony) (precio 3500.0) (compatibilidad universal) (stock 15))
  (accesorio (nombre "Mouse Inalámbrico") (tipo mouse) (marca logitech) (precio 800.0) (compatibilidad universal) (stock 35))
  (accesorio (nombre "Teclado Mecánico") (tipo teclado) (marca corsair) (precio 2500.0) (compatibilidad universal) (stock 12))
  (accesorio (nombre "Protector de Pantalla iPhone") (tipo protector) (marca belkin) (precio 400.0) (compatibilidad iPhone) (stock 60))
  (accesorio (nombre "Mica Protectora iPhone") (tipo mica) (marca belkin) (precio 350.0) (compatibilidad iPhone) (stock 55))
  (accesorio (nombre "Funda Protectora Samsung") (tipo funda) (marca samsung) (precio 900.0) (compatibilidad GalaxyS24) (stock 22))
  (accesorio (nombre "Soporte para Laptop") (tipo soporte) (marca amazon) (precio 1200.0) (compatibilidad universal) (stock 18))
)

;; ============================================
;; HECHOS DE CLIENTES
;; ============================================
(deffacts clientes
  (cliente (cliente-id 1) (nombre Juan) (apellido Pérez) (email "juan.perez@email.com") (telefono "555-1234") (direccion "Calle Principal 123") (fecha-registro "2024-01-15"))
  (cliente (cliente-id 2) (nombre María) (apellido González) (email "maria.gonzalez@email.com") (telefono "555-5678") (direccion "Avenida Central 456") (fecha-registro "2024-02-20"))
  (cliente (cliente-id 3) (nombre Carlos) (apellido Rodríguez) (email "carlos.rodriguez@email.com") (telefono "555-9012") (direccion "Boulevard Norte 789") (fecha-registro "2024-03-10"))
  (cliente (cliente-id 4) (nombre Ana) (apellido Martínez) (email "ana.martinez@email.com") (telefono "555-3456") (direccion "Calle Sur 321") (fecha-registro "2024-01-25"))
  (cliente (cliente-id 5) (nombre Luis) (apellido Sánchez) (email "luis.sanchez@email.com") (telefono "555-7890") (direccion "Plaza Mayor 654") (fecha-registro "2024-04-05"))
)

;; ============================================
;; HECHOS DE TARJETAS DE CRÉDITO
;; ============================================
(deffacts tarjetas-credito
  (tarjetacred (tarjeta-id 1) (cliente-id 1) (banco bbva) (grupo visa) (numero "****1234") (exp-date "01-12-25") (limite 50000.0) (disponible 35000.0))
  (tarjetacred (tarjeta-id 2) (cliente-id 1) (banco santander) (grupo mastercard) (numero "****5678") (exp-date "06-11-24") (limite 30000.0) (disponible 15000.0))
  (tarjetacred (tarjeta-id 3) (cliente-id 2) (banco bbva) (grupo visa) (numero "****9012") (exp-date "03-09-26") (limite 40000.0) (disponible 40000.0))
  (tarjetacred (tarjeta-id 4) (cliente-id 3) (banco hsbc) (grupo american) (numero "****3456") (exp-date "12-10-24") (limite 60000.0) (disponible 25000.0))
  (tarjetacred (tarjeta-id 5) (cliente-id 4) (banco banorte) (grupo visa) (numero "****7890") (exp-date "08-07-25") (limite 35000.0) (disponible 35000.0))
  (tarjetacred (tarjeta-id 6) (cliente-id 5) (banco bbva) (grupo visa) (numero "****2468") (exp-date "05-04-25") (limite 45000.0) (disponible 45000.0))
  (tarjetacred (tarjeta-id 7) (cliente-id 2) (banco banamex) (grupo oro) (numero "****3457") (exp-date "09-12-25") (limite 60000.0) (disponible 60000.0))
  (tarjetacred (tarjeta-id 8) (cliente-id 3) (banco liverpool) (grupo visa) (numero "****7891") (exp-date "11-08-26") (limite 50000.0) (disponible 50000.0))
  (tarjetacred (tarjeta-id 9) (cliente-id 4) (banco banamex) (grupo oro) (numero "****2345") (exp-date "02-06-25") (limite 55000.0) (disponible 55000.0))
)

;; ============================================
;; HECHOS DE VALES
;; ============================================
(deffacts vales
  (vale (vale-id 1) (cliente-id 1) (codigo "VALE2024001") (monto 1000.0) (fecha-emision "2024-01-20") (fecha-expiracion "2024-07-20") (usado 0) (descripcion "Vale de bienvenida"))
  (vale (vale-id 2) (cliente-id 2) (codigo "VALE2024002") (monto 500.0) (fecha-emision "2024-02-25") (fecha-expiracion "2024-08-25") (usado 0) (descripcion "Vale promocional"))
  (vale (vale-id 3) (cliente-id 3) (codigo "VALE2024003") (monto 2000.0) (fecha-emision "2024-03-15") (fecha-expiracion "2024-09-15") (usado 1) (descripcion "Vale por fidelidad"))
  (vale (vale-id 4) (cliente-id 4) (codigo "VALE2024004") (monto 1500.0) (fecha-emision "2024-04-01") (fecha-expiracion "2024-10-01") (usado 0) (descripcion "Vale de cumpleaños"))
  (vale (vale-id 5) (cliente-id 5) (codigo "VALE2024005") (monto 800.0) (fecha-emision "2024-04-10") (fecha-expiracion "2024-10-10") (usado 0) (descripcion "Vale promocional"))
  (vale (vale-id 6) (cliente-id 1) (codigo "VALE2024006") (monto 3000.0) (fecha-emision "2024-02-10") (fecha-expiracion "2024-08-10") (usado 1) (descripcion "Vale por compra mayor"))
)

;; ============================================
;; HECHOS DE ÓRDENES DE COMPRA
;; ============================================
(deffacts ordenes-compra
  (orden-compra (orden-id 1001) (cliente-id 1) (fecha "2024-01-25") (total 27000.0) (estado completada) (metodo-pago tarjeta))
  (orden-compra (orden-id 1002) (cliente-id 2) (fecha "2024-02-28") (total 47000.0) (estado completada) (metodo-pago tarjeta))
  (orden-compra (orden-id 1003) (cliente-id 3) (fecha "2024-03-15") (total 22000.0) (estado procesada) (metodo-pago tarjeta))
  (orden-compra (orden-id 1004) (cliente-id 1) (fecha "2024-04-10") (total 8000.0) (estado pendiente) (metodo-pago vale))
  (orden-compra (orden-id 1005) (cliente-id 4) (fecha "2024-04-12") (total 32000.0) (estado completada) (metodo-pago tarjeta))
  (orden-compra (orden-id 1006) (cliente-id 5) (fecha "2024-04-15") (total 15000.0) (estado pendiente) (metodo-pago efectivo))
  (orden-compra (orden-id 1007) (cliente-id 2) (fecha "2024-04-20") (total 27000.0) (estado pendiente) (metodo-pago tarjeta))
  (orden-compra (orden-id 1008) (cliente-id 3) (fecha "2024-04-22") (total 28000.0) (estado pendiente) (metodo-pago tarjeta))
  (orden-compra (orden-id 1009) (cliente-id 4) (fecha "2024-04-25") (total 59000.0) (estado pendiente) (metodo-pago efectivo))
)

;; Items de órdenes (productos comprados)
(deffacts items-ordenes
  (item-orden (orden-id 1001) (cliente-id 1) (tipo-producto smartphone) (marca apple) (modelo iPhone15) (color negro) (precio 24000.0) (cantidad 1))
  (item-orden (orden-id 1002) (cliente-id 2) (tipo-producto compu) (marca apple) (modelo macbookpro) (color gris) (precio 47000.0) (cantidad 1))
  (item-orden (orden-id 1007) (cliente-id 2) (tipo-producto smartphone) (marca apple) (modelo iPhone16) (color rojo) (precio 27000.0) (cantidad 1))
  (item-orden (orden-id 1008) (cliente-id 3) (tipo-producto smartphone) (marca samsung) (modelo Note21) (color negro) (precio 28000.0) (cantidad 1))
  (item-orden (orden-id 1009) (cliente-id 4) (tipo-producto compu) (marca apple) (modelo macbookair) (color plata) (precio 32000.0) (cantidad 1))
  (item-orden (orden-id 1009) (cliente-id 4) (tipo-producto smartphone) (marca apple) (modelo iPhone16) (color rojo) (precio 27000.0) (cantidad 1))
)

