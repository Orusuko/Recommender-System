# 📋 Lista de Comandos para Demostración Completa

## ⚡ Opción 1: Ejecutar Demo Automática (RECOMENDADA)

```bash
cd clips/knowledge-base
clips -f demo-completo.clp
```

**Tiempo:** ~30 segundos
**Resultado:** Muestra todas las 3 pruebas automáticamente

---

## 🖥️ Opción 2: Ejecutar Comandos Manualmente

### PASO 1: Iniciar CLIPS

```bash
cd clips/knowledge-base
clips
```

---

### PASO 2: Cargar Componentes

```clips
CLIPS> (load "templates.clp")
TRUE

CLIPS> (load "facts.clp")
TRUE

CLIPS> (load "rules.clp")
TRUE

CLIPS> (load "business-rules.clp")
TRUE

CLIPS> (load "reasoning-rules.clp")
TRUE
```

✓ **Verificación:** Todos deben retornar `TRUE`

---

### PASO 3: Inicializar Sistema

```clips
CLIPS> (reset)
```

---

### PASO 4: Ver Productos en Stock

```clips
CLIPS> (facts)
```

**Salida esperada:**
- iPhone 16 con stock
- Samsung Note 21 con stock
- MacBook Pro con stock
- Accesorios
- Etc.

---

### PRUEBA 1: CLIENTE MENUDISTA (qty: 5)

```clips
CLIPS> (assert (orden (marca apple) (modelo iphone16) (qty 5)))
<Fact-N>

CLIPS> (run)
```

**Resultado esperado:**
- ✓ Clasificación: MENUDISTA
- ✓ Oferta: 6 meses sin intereses
- ✓ Descuento: 5% en accesorios
- ✓ Recomendaciones para menudista

---

### PRUEBA 2: CLIENTE MAYORISTA (qty: 15)

Primero, reiniciar el sistema:

```clips
CLIPS> (clear)

CLIPS> (load "templates.clp")
TRUE

CLIPS> (load "facts.clp")
TRUE

CLIPS> (load "rules.clp")
TRUE

CLIPS> (load "business-rules.clp")
TRUE

CLIPS> (load "reasoning-rules.clp")
TRUE

CLIPS> (reset)
```

Luego, crear la orden:

```clips
CLIPS> (assert (orden (marca apple) (modelo iphone16) (qty 15)))
<Fact-N>

CLIPS> (run)
```

**Resultado esperado:**
- ✓ Clasificación: MAYORISTA
- ✓ Oferta: 12 meses sin intereses
- ✓ Descuento: 10% en accesorios
- ✓ Descuento adicional: 5% en compra
- ✓ Vale: $2000
- ✓ Recomendaciones para mayorista

---

### PRUEBA 3: MAYORISTA CON ENVÍO GRATIS (qty: 25)

Reiniciar nuevamente:

```clips
CLIPS> (clear)

CLIPS> (load "templates.clp")
TRUE

CLIPS> (load "facts.clp")
TRUE

CLIPS> (load "rules.clp")
TRUE

CLIPS> (load "business-rules.clp")
TRUE

CLIPS> (load "reasoning-rules.clp")
TRUE

CLIPS> (reset)
```

Crear la orden:

```clips
CLIPS> (assert (orden (marca apple) (modelo iphone16) (qty 25)))
<Fact-N>

CLIPS> (run)
```

**Resultado esperado:**
- ✓ Clasificación: MAYORISTA
- ✓ Oferta: 12 meses sin intereses
- ✓ Descuento: 10% en accesorios
- ✓ Descuento adicional: 5% en compra
- ✓ Vale: $2000
- ✓ **ENVÍO GRATIS** (porque qty >= 20)
- ✓ Recomendaciones para mayorista

---

### VERIFICACIONES ADICIONALES

#### Ver todos los hechos en memoria:

```clips
CLIPS> (facts)
```

#### Ver todas las ofertas generadas:

```clips
CLIPS> (facts)
; Busca líneas que empiecen con (oferta ...
```

#### Ver clasificación del cliente:

```clips
CLIPS> (facts)
; Busca líneas que empiecen con (cliente-tipo ...
```

#### Ver stock actualizado:

```clips
CLIPS> (facts)
; Busca líneas que empiecen con (stock-actualizado ...
```

#### Ver todas las reglas cargadas:

```clips
CLIPS> (list-defrules)
```

**Debe mostrar:**
- clasificar-menudista-nil
- clasificar-menudista-diferente
- clasificar-mayorista-nil
- clasificar-mayorista-diferente
- oferta-menudista-iphone16
- descuento-menudista-accesorios
- vale-menudista
- oferta-mayorista-iphone16
- descuento-mayorista-accesorios
- descuento-mayorista-compra
- vale-mayorista
- envio-gratis-mayorista
- recomendacion-menudista
- recomendacion-mayorista
- actualizar-stock-iphone16
- alerta-stock-insuficiente
- Y más...

#### Ver templates definidos:

```clips
CLIPS> (list-deftemplates)
```

**Debe mostrar:**
- orden
- cliente-tipo
- stock-actualizado
- oferta
- smartphone
- compu
- accesorio
- Y más...

---

### SALIR DE CLIPS

```clips
CLIPS> (exit)
```

---

## 📊 Resumen de Pruebas

| Prueba | Cantidad | Clasificación | Ofertas | Descuentos | Recomendaciones | Stock |
|--------|----------|----------------|---------|-----------|-----------------|-------|
| 1 | 5 | MENUDISTA | 6 meses | 5% | SÍ | Actualizado |
| 2 | 15 | MAYORISTA | 12 meses | 10% + 5% | SÍ | Actualizado |
| 3 | 25 | MAYORISTA | 12 meses | 10% + 5% | SÍ + Envío Gratis | Actualizado |

---

## ✅ Checklist de Verificación

### Después de cada prueba, verifica:

- [ ] ¿Se muestra la clasificación correcta?
- [ ] ¿Se aplican las ofertas correctas?
- [ ] ¿Se aplican los descuentos correctos?
- [ ] ¿Se muestran las recomendaciones?
- [ ] ¿Se actualiza el stock?
- [ ] ¿No hay errores en la salida?

---

## 🎯 Lo que Demuestra Este Sistema

✅ **Base de Conocimientos Completa**
- Templates para 7 tipos de entidades
- Hechos iniciales de productos, clientes, tarjetas, etc.

✅ **Reglas de Negocio**
- 25+ reglas de ofertas y descuentos
- Descuentos en accesorios
- Vales por compra
- Envío gratis para mayoristas

✅ **Razonamiento Automático**
- Clasificación automática de clientes (menudista/mayorista)
- Aplicación de ofertas según clasificación
- Generación de recomendaciones
- Actualización de stock

✅ **Funcionalidades CLIPS**
- Pattern matching
- Forward chaining (motor de inferencia)
- Modificación de hechos
- Generación de nuevos hechos
- Salience (prioridad de reglas)

---

## 💡 Comandos Útiles Adicionales

### Depuración

```clips
; Ver reglas que se activaron
CLIPS> (watch activations)
CLIPS> (assert (orden (marca apple) (modelo iphone16) (qty 10)))
CLIPS> (run)

; Desactivar watch
CLIPS> (unwatch all)
```

### Inspección

```clips
; Ver contenido de una regla
CLIPS> (ppdefrule nombre-de-regla)

; Ver contenido de un template
CLIPS> (ppdeftemplate nombre-template)

; Ver la agenda (reglas activas)
CLIPS> (agenda)
```

---

## 🚀 Próximos Pasos

1. ✅ Ejecuta `clips -f demo-completo.clp`
2. ✅ Verifica que todas las pruebas pasen
3. ✅ Luego ejecuta los comandos manuales para entender mejor
4. ✅ Experimenta creando tus propias órdenes

---

**¡El sistema está completamente funcional y listo para demostrar!** 🎉
