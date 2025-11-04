
;; Template para representar el estado del mundo
(deftemplate estado
  (slot paso (default 0))                    ;; número de paso/acción
  (slot mono-posicion (default puerta))      ;; puerta, ventana, pared, centro
  (slot mono-nivel (default piso))           ;; piso, caja
  (slot mono-manos (default libres))         ;; libres, ocupadas-caja
  (slot caja-posicion (default puerta))      ;; puerta, ventana, pared, centro
  (slot tiene-platano (default no))          ;; si, no
  (slot objetivo-alcanzado (default no))     ;; si, no
)

;; Template para registrar el historial de acciones
(deftemplate historial-accion
  (slot numero-accion)
  (slot descripcion)
)

;;------------------------------------------------------------------------
;; ESTADO INICIAL DEL MUNDO
;;------------------------------------------------------------------------

(deffacts estado-inicial
  ;; Estado inicial: mono en puerta, caja en puerta, plátano no obtenido
  (estado
    (paso 0)
    (mono-posicion puerta)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion puerta)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  
  ;; Información sobre ubicaciones
  (ubicacion puerta "Entrada de la sala")
  (ubicacion ventana "Ventana con luz")
  (ubicacion pared "Pared lateral")
  (ubicacion centro "Centro de la sala (donde está el plátano)")
)

;;------------------------------------------------------------------------
;; REGLA 1: Mono se desplaza hacia la caja 
;;------------------------------------------------------------------------

(defrule mono-desplaza-hacia-caja
  ;; Condiciones:
  ;; - Mono está en piso (no en caja)
  ;; - Manos libres (no empujando nada)
  ;; - Mono y caja en diferente posición
  ;; - Aún no tiene plátano
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion ?posicion-mono)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion ?posicion-caja)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  (test (neq ?posicion-mono ?posicion-caja))
  =>
  ;; Acción: Mono se desplaza hacia la caja
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion ?posicion-caja)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion ?posicion-caja)
    (tiene-platano no)
    (objetivo-alcanzado no)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": MONO SE DESPLAZA" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ El mono camina de [" ?posicion-mono "] hacia [" ?posicion-caja "]" crlf)
  (printout t "▸ Estado: Manos libres, listo para empujar la caja" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 2: Mono se posiciona frente a la caja 
;;------------------------------------------------------------------------

(defrule mono-posiciona-caja
  ;; Condiciones:
  ;; - Mono está en piso y en la misma posición que la caja
  ;; - Manos libres
  ;; - Caja NO está en el centro aún
  ;; - Manos libres (preparadas para empujar)
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion ?posicion)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion ?posicion)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  (test (neq ?posicion centro))
  =>
  ;; Acción: Mono ocupa sus manos en la caja y se prepara
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion ?posicion)
    (mono-nivel piso)
    (mono-manos ocupadas-caja)
    (caja-posicion ?posicion)
    (tiene-platano no)
    (objetivo-alcanzado no)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": MONO SE POSICIONA EN LA CAJA" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ El mono se agacha e intenta agarrar la caja" crlf)
  (printout t "▸ Sus MANOS AHORA ESTÁN OCUPADAS con la caja" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 3: Mono empuja la caja hacia el centro
;;------------------------------------------------------------------------

(defrule mono-empuja-caja
  ;; Condiciones:
  ;; - Manos ocupadas con la caja (ya está agarrando)
  ;; - Caja NO está en el centro
  ;; - Mono y caja en la misma posición
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion ?posicion)
    (mono-nivel piso)
    (mono-manos ocupadas-caja)
    (caja-posicion ?posicion)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  (test (neq ?posicion centro))
  =>
  ;; Acción: Mono empuja la caja al centro
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion centro)
    (mono-nivel piso)
    (mono-manos ocupadas-caja)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": MONO EMPUJA LA CAJA" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ ¡EMMMMPUUUUUJON! El mono empuja fuertemente la caja" crlf)
  (printout t "▸ La caja se desplaza hasta el [CENTRO] de la sala" crlf)
  (printout t "▸ ¡Manos aún ocupadas con la caja!" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 4: Mono suelta la caja 
;;------------------------------------------------------------------------

(defrule mono-suelta-caja
  ;; Condiciones:
  ;; - Manos ocupadas con caja
  ;; - Mono y caja en el centro
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion centro)
    (mono-nivel piso)
    (mono-manos ocupadas-caja)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  =>
  ;; Acción: Mono suelta la caja y libera sus manos
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion centro)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": MONO SUELTA LA CAJA" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ El mono libera sus manos de la caja" crlf)
  (printout t "▸ ✋ MANOS LIBRES nuevamente" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 5: Mono sube a la caja
;;------------------------------------------------------------------------

(defrule mono-sube-caja
  ;; Condiciones:
  ;; - Mono en piso
  ;; - Manos libres
  ;; - Mono y caja en centro
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion centro)
    (mono-nivel piso)
    (mono-manos libres)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  =>
  ;; Acción: Mono sube a la caja
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion centro)
    (mono-nivel caja)
    (mono-manos libres)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": MONO SUBE A LA CAJA" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ El mono se pone en posición de trepar" crlf)
  (printout t "▸ ¡ARRIBA! El mono está ahora EN CIMA DE LA CAJA" crlf)
  (printout t "▸ 📏 Altura: Nivel CAJA - Ahora puede alcanzar el plátano" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 6: Mono agarra el plátano (SOLO si manos libres)
;;------------------------------------------------------------------------

(defrule mono-agarra-platano
  ;; Condiciones CRÍTICAS:
  ;; - Mono está EN LA CAJA
  ;; - Caja está en el CENTRO
  ;; - MANOS LIBRES (esto es crucial - no puede agarrar si tiene manos ocupadas)
  ;; - Aún no tiene el plátano
  ?estado <- (estado
    (paso ?paso)
    (mono-posicion centro)
    (mono-nivel caja)
    (mono-manos libres)
    (caja-posicion centro)
    (tiene-platano no)
    (objetivo-alcanzado no)
  )
  =>
  ;; Acción: Mono agarra el plátano - ¡ÉXITO!
  (retract ?estado)
  (assert (estado
    (paso (+ ?paso 1))
    (mono-posicion centro)
    (mono-nivel caja)
    (mono-manos libres)
    (caja-posicion centro)
    (tiene-platano si)
    (objetivo-alcanzado si)
  ))
  (printout t crlf "─────────────────────────────────────────" crlf)
  (printout t "PASO " (+ ?paso 1) ": ¡¡¡MONO AGARRA EL PLÁTANO!!!" crlf)
  (printout t "─────────────────────────────────────────" crlf)
  (printout t "▸ El mono extiende su brazo" crlf)
  (printout t "▸ Sus MANOS LIBRES le permiten agarrar el plátano" crlf)
  (printout t "▸ EL MONO TIENE EL PLÁTANO!!!" crlf)
)

;;------------------------------------------------------------------------
;; REGLA 7: Mostrar resumen final
;;------------------------------------------------------------------------

(defrule objetivo-alcanzado-final
  (estado 
    (paso ?paso-final)
    (objetivo-alcanzado si)
  )
  =>
  (printout t crlf)
  (printout t "╔═══════════════════════════════════════╗" crlf)
  (printout t "║    ✓ ¡OBJETIVO COMPLETADO! ✓         ║" crlf)
  (printout t "╠═══════════════════════════════════════╣" crlf)
  (printout t "║ El mono obtuvo el plátano             ║" crlf)
  (printout t "║ Pasos totales: " ?paso-final)
  (printout t "                                        ║" crlf)
  (printout t "║                                       ║" crlf)
  (printout t "║ SECUENCIA DE ACCIONES:                ║" crlf)
  (printout t "║ 1. Desplazarse a la caja              ║" crlf)
  (printout t "║ 2. Posicionarse en la caja            ║" crlf)
  (printout t "║ 3. Empujar caja al centro             ║" crlf)
  (printout t "║ 4. Soltar la caja                     ║" crlf)
  (printout t "║ 5. Subir a la caja                    ║" crlf)
  (printout t "║ 6. Agarrar el plátano                 ║" crlf)
  (printout t "║                                       ║" crlf)
  (printout t "║  PUNTO CLAVE:                         ║" crlf)
  (printout t "║ Las manos NO pueden estar ocupadas    ║" crlf)
  (printout t "║ para agarrar el plátano!              ║" crlf)
  (printout t "╚═══════════════════════════════════════╝" crlf crlf)
)
