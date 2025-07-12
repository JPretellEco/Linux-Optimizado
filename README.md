# 🧠 Configurador Dinámico de Swap y ZRAM para Linux

---

## 1. ¿Por qué y para qué hice este script?

Este script fue creado por **Jeffersson Pretell Velasquez** como una herramienta **personal**, con un solo propósito:

> 📌 "No quiero volver a buscar ni recordar cómo configurar bien el swap y ZRAM cada vez que reinstalo Linux."

Quiero que al iniciar un sistema nuevo, pueda simplemente ejecutar este script y:
- Tener **swap correctamente configurado y adaptado a la RAM** de la máquina.
- Activar **ZRAM** para que el sistema tenga mayor elasticidad y velocidad ante carga pesada.
- Ajustar automáticamente parámetros como `swappiness` sin andar tocando mil archivos.

Este no es un proyecto para compartir o clonar masivamente. Es una herramienta de respaldo personal, para asegurarme de que **mi sistema Linux siempre tenga un rendimiento óptimo desde el primer día**.

---

## 2. ¿Qué es el swap y por qué es importante?

### 🔄 ¿Qué es el swap?

El **swap** es una zona de memoria virtual que el sistema operativo usa como respaldo cuando la RAM se llena. Puede estar en forma de:
- Un **archivo** (`/swapfile`)
- Una **partición**
- O incluso **en RAM comprimida** (ZRAM)

### ⚙️ ¿Por qué es importante configurarlo bien?

- Si no hay swap, y la RAM se llena, el sistema puede **congelarse** o **cerrar programas forzosamente**.
- Si el swap está mal dimensionado, puede **ralentizar el sistema** al abusar del disco.
- Si está bien configurado (especialmente con **ZRAM**), el sistema puede trabajar con más fluidez y estabilidad, incluso con poca RAM.

### 🧠 ¿Y por qué compartirlo con la RAM?

**ZRAM** permite crear swap **dentro de la propia RAM**, pero **comprimida**. Esto da como resultado:
- Un uso más eficiente de la memoria.
- Accesos más rápidos que el disco tradicional.
- Menos desgaste de SSDs (ya que se usa menos el swapfile en disco).

Por eso este script activa **ZRAM** primero y le da prioridad sobre el swap en disco, dejando ambos listos.

---

## 📐 ¿Cómo calcula el script el tamaño del swap?

El script detecta automáticamente cuánta RAM tiene tu equipo y sigue esta lógica:

| RAM detectada   | Swap asignado     |
|------------------|-------------------|
| ≤ 4 GiB          | RAM × 2           |
| 4 – 8 GiB        | RAM × 1.5         |
| > 8 GiB          | RAM × 1.0         |

Esto asegura que el swap esté bien balanceado para cada caso, sin exagerar ni quedarse corto.

---

## ⚙️ ¿Qué hace exactamente el script?

✔️ Detecta cuánta RAM tienes  
✔️ Calcula el tamaño adecuado de swap  
✔️ Elimina cualquier swapfile anterior  
✔️ Crea y activa un nuevo `swapfile`  
✔️ Instala y configura `zram-config`  
✔️ Ajusta `vm.swappiness=15`  
✔️ Agrega el swapfile a `/etc/fstab` para que se cargue al iniciar  
✔️ Muestra un resumen final

---
