# Termux Banner

Termux için özel, dış pakete ihtiyaç duymayan (figlet/neofetch gerekmez) banner scripti. Yazacağın metni otomatik olarak ASCII bloklara çevirir.

## Özellikler

- **Kendi metnini yaz, otomatik ASCII'ye çevrilsin** — kod içine sabit yazı gömülü değil, kurulumda soruyor
- A-Z, 0-9 ve temel semboller için kendi yazdığım blok font
- Cihaz modeli, Android sürümü, mimari bilgisi
- RAM ve depolama kullanımı
- Pil yüzdesi (opsiyonel, `termux-api` gerektirir)
- IP adresi ve tarih/saat
- Kutu çizimiyle düzenli görünüm
- Tamamen `bash` ile yazılmıştır, harici bağımlılık yoktur

## Dosyalar

- `banner.sh` — Ana banner scripti (sistem bilgisi + ASCII render)
- `ascii_font.sh` — Metni ASCII'ye çeviren font kütüphanesi
- `install.sh` — Kurulum scripti (senden yazıyı sorar)

## Kurulum

```bash
git clone https://github.com/KULLANICI_ADIN/termux-banner.git
cd termux-banner
chmod +x install.sh
./install.sh
```


## Fontu Genişletme

`ascii_font.sh` içinde her karakter `FONT[X]="satır1;satır2;satır3;satır4;satır5"` şeklinde tanımlı. Yeni bir sembol eklemek istersen aynı formatta bir satır eklemen yeterli.

## Renkleri Değiştirme

`banner.sh` başındaki renk değişkenlerini (`BR_CYAN`, `GREEN`, vb.) düzenleyerek renk şemasını değiştirebilirsin.

## Pil Bilgisi İçin (Opsiyonel)

```bash
pkg install termux-api
```

## Lisans by t.me/OtizmliCoder
