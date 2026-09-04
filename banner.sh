#!/data/data/com.termux/files/usr/bin/bash
# =============================================================
#  Custom Termux Banner
#  Metni ~/.termux_banner.conf dosyasından okur ve ASCII'ye çevirir.
#  GitHub'a yüklemek için hazırlanmıştır.
# =============================================================

# ---------- Renkler (Matrix / Koyu Yeşil Tema) ----------
RESET='\033[0m'
BOLD='\033[1m'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BR_RED='\033[1;31m'
BR_GREEN='\033[1;32m'
BR_YELLOW='\033[1;33m'
BR_CYAN='\033[1;36m'

# Matrix paleti: logo parlak yeşil, çerçeve koyu yeşil, etiket soluk yeşil, değer parlak yeşil
MTX_LOGO='\033[1;92m'      # Parlak (bold) yeşil - logo
MTX_FRAME='\033[0;32m'     # Koyu yeşil - kutu çerçevesi
MTX_LABEL='\033[2;32m'     # Soluk/dim yeşil - etiketler
MTX_VALUE='\033[1;92m'     # Parlak yeşil - değerler
MTX_SEP='\033[0;32m'       # Koyu yeşil - iki nokta ayracı
MTX_OK='\033[1;92m'        # Parlak yeşil - onay mesajı

# ---------- Font kütüphanesini yükle ----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/ascii_font.sh" ]; then
    source "$SCRIPT_DIR/ascii_font.sh"
elif [ -f "$HOME/.termux_ascii_font.sh" ]; then
    source "$HOME/.termux_ascii_font.sh"
else
    echo "Hata: ascii_font.sh bulunamadı."
    exit 1
fi

# ---------- Hacker logo modülünü yükle ----------
if [ -f "$SCRIPT_DIR/hacker_logo.sh" ]; then
    source "$SCRIPT_DIR/hacker_logo.sh"
elif [ -f "$HOME/.termux_hacker_logo.sh" ]; then
    source "$HOME/.termux_hacker_logo.sh"
fi

# ---------- Kullanıcı ayarları ----------
CONFIG_FILE="$HOME/.termux_banner.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi
BANNER_TEXT="${BANNER_TEXT:-WLTR}"
SUBTITLE_TEXT="${SUBTITLE_TEXT:-ETHICAL HACKER}"
SHOW_HACKER_LOGO="${SHOW_HACKER_LOGO:-true}"

# ---------- Sistem Bilgisi Toplama ----------
get_device_model() { getprop ro.product.model 2>/dev/null || echo "Bilinmiyor"; }
get_android_version() { getprop ro.build.version.release 2>/dev/null || echo "Bilinmiyor"; }
get_termux_arch() { uname -m 2>/dev/null || echo "Bilinmiyor"; }

get_uptime() {
    if [ -r /proc/uptime ]; then
        up_seconds=$(cut -d. -f1 /proc/uptime)
        printf '%dg %ds %dd' $((up_seconds/86400)) $((up_seconds%86400/3600)) $((up_seconds%3600/60))
    else
        echo "Bilinmiyor"
    fi
}

get_storage() { df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $3 " / " $2 " (%" $5 " dolu)"}'; }

get_ram() {
    if [ -r /proc/meminfo ]; then
        total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
        avail=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
        used=$((total - avail))
        printf '%d MB / %d MB' $((used/1024)) $((total/1024))
    else
        echo "Bilinmiyor"
    fi
}

get_battery() {
    if command -v termux-battery-status >/dev/null 2>&1; then
        termux-battery-status 2>/dev/null | grep -o '"percentage": [0-9]*' | grep -o '[0-9]*'
    else
        echo "N/A"
    fi
}

get_date() { date "+%d/%m/%Y - %H:%M:%S"; }

# ---------- Kutu Çizim Fonksiyonu ----------
draw_line() {
    printf "${MTX_FRAME}┌"
    for _ in $(seq 1 58); do printf '─'; done
    printf "┐${RESET}\n"
}

draw_bottom() {
    printf "${MTX_FRAME}└"
    for _ in $(seq 1 58); do printf '─'; done
    printf "┘${RESET}\n"
}

draw_row() {
    local label="$1"
    local value="$2"
    printf "${MTX_FRAME}│ ${MTX_LABEL}%-14s${MTX_SEP}: ${MTX_VALUE}%-38s${MTX_FRAME}│${RESET}\n" "$label" "$value"
}

# ---------- Banner Çıktısı ----------
clear

# Orijinal hacker logosu (gradyan renkli kurukafa)
if [ "$SHOW_HACKER_LOGO" = "true" ] && command -v print_hacker_logo >/dev/null 2>&1; then
    print_hacker_logo
    echo ""
fi

# Kullanıcının girdiği metni otomatik ASCII'ye çevir
render_ascii_text "$BANNER_TEXT" "$MTX_LOGO"

# Alt başlık (örn. "ETHICAL HACKER") ortalanmış şekilde
if [ -n "$SUBTITLE_TEXT" ]; then
    term_cols=$(tput cols 2>/dev/null || echo 58)
    sub_len=${#SUBTITLE_TEXT}
    sub_pad=$(( (term_cols - sub_len - 4) / 2 ))
    (( sub_pad < 0 )) && sub_pad=0
    printf '%*s' "$sub_pad" ''
    echo -e "${MTX_FRAME}[ ${MTX_VALUE}${BOLD}${SUBTITLE_TEXT}${RESET}${MTX_FRAME} ]${RESET}"
fi

echo ""
draw_line
draw_row "Cihaz"           "$(get_device_model)"
draw_row "Android"         "$(get_android_version)"
draw_row "Mimari"          "$(get_termux_arch)"
draw_row "RAM"             "$(get_ram)"
draw_row "Depolama"        "$(get_storage)"
draw_row "Pil"             "%$(get_battery)"
draw_row "Çalışma Süresi"  "$(get_uptime)"
draw_row "Tarih"           "$(get_date)"
draw_bottom

echo ""
echo -e "${MTX_OK}${BOLD}[✓] Termux ortamı hazır. İyi çalışmalar!${RESET}"
echo ""
