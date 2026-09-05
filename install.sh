#!/data/data/com.termux/files/usr/bin/bash
# Kurulum scripti - banner.sh, ascii_font.sh ve hacker_logo.sh dosyalarını kurar
# Kullanıcıdan banner metnini ve alt başlığı sorar, kaydeder.

set -e

SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="$HOME/.termux_banner_files"
SHELL_RC="$HOME/.bashrc"
CONFIG_FILE="$HOME/.termux_banner.conf"

if [ ! -f "$SRC_DIR/banner.sh" ] || [ ! -f "$SRC_DIR/ascii_font.sh" ]; then
    echo "Hata: banner.sh veya ascii_font.sh bulunamadı!"
    exit 1
fi

mkdir -p "$DEST_DIR"
cp "$SRC_DIR/banner.sh" "$DEST_DIR/banner.sh"
cp "$SRC_DIR/ascii_font.sh" "$DEST_DIR/ascii_font.sh"
chmod +x "$DEST_DIR/banner.sh" "$DEST_DIR/ascii_font.sh"

if [ -f "$SRC_DIR/hacker_logo.sh" ]; then
    cp "$SRC_DIR/hacker_logo.sh" "$DEST_DIR/hacker_logo.sh"
    chmod +x "$DEST_DIR/hacker_logo.sh"
fi

# Banner metnini kullanıcıdan al
echo ""
echo "Banner'da görünmesini istediğin yazıyı gir (örn: isim, takma ad):"
read -r -p "> " USER_TEXT
if [ -z "$USER_TEXT" ]; then
    USER_TEXT="WLTR"
fi

# Alt başlık
echo ""
echo "Alt başlık yazısı gir (boş bırakırsan 'ETHICAL HACKER' kullanılır):"
read -r -p "> " USER_SUBTITLE
if [ -z "$USER_SUBTITLE" ]; then
    USER_SUBTITLE="ETHICAL HACKER"
fi

# Kurukafa logosu gösterilsin mi?
echo ""
echo "Gradyanlı kurukafa logosu gösterilsin mi? (e/h, varsayılan: e)"
read -r -p "> " SHOW_LOGO_INPUT
if [ "$SHOW_LOGO_INPUT" = "h" ] || [ "$SHOW_LOGO_INPUT" = "H" ]; then
    SHOW_LOGO="false"
else
    SHOW_LOGO="true"
fi

# Font stili
echo ""
echo "Font stili seç:"
echo "  1) Kalın/pikselli, iki renkli (HIDDENEYE tarzı)  [varsayılan]"
echo "  2) İnce/klasik, tek renk"
read -r -p "> " FONT_CHOICE
if [ "$FONT_CHOICE" = "2" ]; then
    USER_FONT_STYLE="classic"
else
    USER_FONT_STYLE="big"
fi

cat > "$CONFIG_FILE" << CONF_EOF
# Termux Banner Ayarları
# Bu dosyayı elle düzenleyerek istediğin zaman değiştirebilirsin.
BANNER_TEXT="$USER_TEXT"
SUBTITLE_TEXT="$USER_SUBTITLE"
SHOW_HACKER_LOGO="$SHOW_LOGO"
FONT_STYLE="$USER_FONT_STYLE"
FONT_SCALE="2"
FONT_COLOR1="\033[1;36m"
FONT_COLOR2="\033[1;31m"
CONF_EOF

echo "[✓] Ayarlar kaydedildi."

# .bashrc'ye ekle
if ! grep -q "termux_banner_files/banner.sh" "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# Custom Termux Banner" >> "$SHELL_RC"
    echo "bash \$HOME/.termux_banner_files/banner.sh" >> "$SHELL_RC"
    echo "[✓] Banner .bashrc dosyasına eklendi."
else
    echo "[i] Banner zaten .bashrc içinde mevcut, tekrar eklenmedi."
fi

echo "[✓] Kurulum tamamlandı. Test etmek için:"
echo "    exec bash"
echo ""
echo "Ayarları sonra değiştirmek istersen:"
echo "    nano \$HOME/.termux_banner.conf"
