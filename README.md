# 🧠 Configurador Dinámico de Swap y ZRAM para Linux

Este script fue creado por **Jeffersson Pretell** como una herramienta personal para automatizar la configuración del **swap** y **ZRAM** en sistemas Linux Debian/Ubuntu.  
No fue hecho con fines de distribución, ni como un paquete oficial: simplemente es un **script práctico que guardo en GitHub para cuando vuelva a necesitarlo**.

---

## 🎯 ¿Por qué lo hice?

A veces reinstalo Linux o configuro laptops nuevas, y no quiero estar recordando cada paso para:

- Ajustar el tamaño correcto del swap según la RAM
- Activar ZRAM (swap comprimido en RAM)
- Evitar congelamientos del sistema por uso intensivo de memoria
- Aplicar buenas prácticas como `swappiness = 15`

Este script me ahorra tiempo y errores. Es simple, confiable, y adaptable.

---

## 📦 ¿Qué hace?

✔️ Detecta automáticamente cuánta RAM tiene el equipo  
✔️ Calcula y crea un `swapfile` con tamaño proporcional  
✔️ Instala y activa `zram-config`  
✔️ Ajusta el `swappiness` del sistema para mayor eficiencia  
✔️ Deja todo listo tras reiniciar

---

## 📐 Lógica para calcular el tamaño de swap

| RAM detectada   | Swap asignado     |
|------------------|-------------------|
| ≤ 4 GiB          | RAM × 2           |
| 4 – 8 GiB        | RAM × 1.5         |
| > 8 GiB          | RAM × 1.0         |

---
