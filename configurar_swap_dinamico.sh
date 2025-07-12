#!/bin/bash

# Script: configurar_swap_dinamico.sh
# Autor: Jeffersson Pretell
# Propósito: Detectar RAM instalada y crear swap y zram proporcionales

echo "🧠 Detectando RAM física total del sistema..."
total_ram_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
total_ram_gb=$(( (total_ram_kb / 1024 / 1024) + 1 ))  # Redondea al siguiente GiB

echo "💾 RAM detectada: ${total_ram_gb} GiB"

# Reglas proporcionales:
# - Si RAM ≤ 4 GiB → swap = RAM x2
# - Si RAM 4-8 GiB → swap = RAM x1.5
# - Si RAM > 8 GiB → swap = RAM x1 (sin hibernación)
if [ "$total_ram_gb" -le 4 ]; then
    swap_size_gb=$(( total_ram_gb * 2 ))
elif [ "$total_ram_gb" -le 8 ]; then
    swap_size_gb=$(( total_ram_gb * 3 / 2 ))
else
    swap_size_gb=$(( total_ram_gb ))
fi

echo "📐 Swap asignado dinámicamente: ${swap_size_gb} GiB"

# 1. Desactivar y eliminar swap anterior
echo "🔧 Eliminando swap anterior si existe..."
sudo swapoff /swapfile 2>/dev/null
sudo rm -f /swapfile

# 2. Crear nuevo swapfile
echo "📦 Creando swapfile de ${swap_size_gb} GiB..."
sudo fallocate -l ${swap_size_gb}G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=$((swap_size_gb * 1024)) status=progress

# 3. Permisos y activación
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# 4. Registro en fstab
if ! grep -q "/swapfile" /etc/fstab; then
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

# 5. Instalar ZRAM
echo "⚡ Instalando zram-config..."
sudo apt update
sudo apt install -y zram-config

# 6. Ajustar swappiness a 15
echo "🧠 Ajustando swappiness a 15..."
echo 'vm.swappiness=15' | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf

# 7. Reporte final
echo -e "\n✅ Swap y ZRAM configurados proporcionalmente:"
free -h
echo -e "\n📄 Detalles de swap:"
cat /proc/swaps
echo -e "\n🧠 Swappiness actual:"
cat /proc/sys/vm/swappiness

echo -e "\n🌀 Se recomienda reiniciar para que ZRAM inicie correctamente.\n"
