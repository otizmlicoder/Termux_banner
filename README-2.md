# Termux Banner

Termux için özel, dış pakete ihtiyaç duymayan (figlet/neofetch gerekmez) banner scripti. Yazacağın metni otomatik olarak ASCII bloklara çevirir.

## Özellikler

- **Kendi metnini yaz, otomatik ASCII'ye çevrilsin** — kod içine sabit yazı gömülü değil, kurulumda soruyor
- **Orijinal gradyanlı kurukafa logosu** (mor → kırmızı, 256 renk) — açılıp kapatılabilir
- Özelleştirilebilir alt başlık (örn. "ETHICAL HACKER")
- A-Z, 0-9 ve temel semboller için kendi yazdığım blok font
- Cihaz modeli, Android sürümü, mimari bilgisi
- RAM ve depolama kullanımı
- Pil yüzdesi (opsiyonel, `termux-api` gerektirir)
- Tarih/saat
- Kutu çizimiyle düzenli görünüm, koyu yeşil "matrix" temalı renklendirme
- Tamamen `bash` ile yazılmıştır, harici bağımlılık yoktur

## Dosyalar

- `banner.sh` — Ana banner scripti (logo + ASCII render + sistem bilgisi)
- `ascii_font.sh` — Metni ASCII'ye çeviren font kütüphanesi
- `hacker_logo.sh` — Gradyanlı kurukafa ASCII logosu
- `install.sh` — Kurulum scripti (senden yazı, alt başlık ve logo tercihini sorar)

## Kurulum

```bash
git clone https://github.com/KULLANICI_ADIN/termux-banner.git
cd termux-banner
chmod +x install.sh
./install.sh
```

Kurulum sırasında script sana şunu soracak:

```
Banner'da görünmesini istediğin yazıyı gir (örn: isim, takma ad):
>
```

Ne yazarsan onu otomatik ASCII blok harflere çevirip banner'a koyar. Yeni bir terminal açtığında (veya `exec bash` yazınca) görünür.

## Yazıyı Sonradan Değiştirme

Tekrar kurulum yapmana gerek yok, direkt config dosyasını düzenle:

```bash
nano ~/.termux_banner.conf
```

İçinde şu satırı bulup değiştir:

```bash
BANNER_TEXT="YAZMAK_ISTEDIGIN"
SUBTITLE_TEXT="ALT_BASLIK"
SHOW_HACKER_LOGO="true"   # false yaparsan kurukafa logosu gizlenir
```

## Manuel Kurulum

1. `banner.sh` ve `ascii_font.sh` dosyalarını `~/.termux_banner_files/` klasörüne kopyala.
2. Çalıştırılabilir yap: `chmod +x ~/.termux_banner_files/*.sh`
3. `~/.termux_banner.conf` dosyası oluştur, içine `BANNER_TEXT="YAZIN"` yaz.
4. `.bashrc` dosyanın sonuna ekle:
   ```bash
   bash ~/.termux_banner_files/banner.sh
   ```

## Fontu Genişletme

`ascii_font.sh` içinde her karakter `FONT[X]="satır1;satır2;satır3;satır4;satır5"` şeklinde tanımlı. Yeni bir sembol eklemek istersen aynı formatta bir satır eklemen yeterli.

## Renkleri Değiştirme

`banner.sh` başındaki renk değişkenlerini (`BR_CYAN`, `GREEN`, vb.) düzenleyerek renk şemasını değiştirebilirsin.

## Pil Bilgisi İçin (Opsiyonel)

```bash
pkg install termux-api
```

## Lisans

Özgürce kullan, değiştir ve dağıt.
