# 🧠 Configurador Dinámico de Swap y ZRAM para Linux

Este script fue diseñado por **Jeffersson Pretell** para automatizar y optimizar la configuración de memoria virtual en sistemas Linux (Debian/Ubuntu).  
Ajusta automáticamente el tamaño del **swapfile** y habilita **ZRAM** (swap comprimido en RAM), adaptándose a la cantidad de RAM física disponible.

---

## 🎯 Objetivo

- Mejorar el rendimiento general del sistema.
- Prevenir congelamientos por saturación de RAM.
- Usar la RAM de forma eficiente y dinámica (ZRAM).
- Aplicar buenas prácticas con `swappiness`.

---

## 📦 Características

✅ Detección automática de la cantidad de RAM  
✅ Cálculo proporcional del tamaño de `swapfile`  
✅ Creación, activación y registro de swap en `/etc/fstab`  
✅ Instalación y activación de ZRAM (`zram-config`)  
✅ Ajuste de `vm.swappiness=15` para evitar uso anticipado del swap  
✅ Compatible con Debian, Ubuntu y derivados

---

## 📐 Lógica para asignación dinámica de swap

| RAM detectada   | Swap asignado     |
|------------------|-------------------|
| ≤ 4 GiB          | RAM × 2           |
| 4 – 8 GiB        | RAM × 1.5         |
| > 8 GiB          | RAM × 1.0         |

---

## 🚀 Instalación y uso

### 1. Clona o descarga este script

```bash
git clone https://github.com/tu_usuario/configurador-swap-zram.git
cd configurador-swap-zram
