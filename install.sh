#!/data/data/com.termux/files/usr/bin/bash
# Kurulum scripti - banner.sh ve ascii_font.sh dosyalarını Termux ortamına kurar
# Kullanıcıdan banner metnini sorar ve kaydeder.

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

# Banner metnini kullanıcıdan al
echo ""
echo "Banner'da görünmesini istediğin yazıyı gir (örn: isim, takma ad):"
read -r -p "> " USER_TEXT
if [ -z "$USER_TEXT" ]; then
    USER_TEXT="WLTR"
fi

cat > "$CONFIG_FILE" << CONF_EOF
# Termux Banner Ayarları
# Bu dosyayı elle düzenleyerek yazıyı istediğin zaman değiştirebilirsin.
BANNER_TEXT="$USER_TEXT"
CONF_EOF

echo "[✓] Banner metni kaydedildi: $USER_TEXT"

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
echo "Yazıyı sonra değiştirmek istersen:"
echo "    nano \$HOME/.termux_banner.conf"
