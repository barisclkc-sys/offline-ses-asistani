#!/bin/bash

# 1. TEMEL AYARLAR VE KLASÖRLER
KAYIT_DIZINI="$HOME/toplanti_kayitlari"
WHISPER_CMD="$HOME/whisper.cpp/build/bin/whisper-cli"
WHISPER_MODEL="$HOME/whisper.cpp/models/ggml-small.bin"
LLAMA_CMD="$HOME/llama.cpp/build/bin/llama-cli"
LLAMA_MODEL="$HOME/llama.cpp/ozet_modeli.gguf"

mkdir -p "$KAYIT_DIZINI"

# 2. OTOMATİK İSİMLENDİRME (ses1, ses2, ses3...)
SAYAC=1
while [ -f "$KAYIT_DIZINI/ses${SAYAC}.wav" ]; do
    ((SAYAC++))
done
DOSYA_ADI="ses${SAYAC}"
WAV_YOLU="$KAYIT_DIZINI/${DOSYA_ADI}.wav"
TXT_YOLU="$KAYIT_DIZINI/${DOSYA_ADI}.wav.txt"
OZET_YOLU="$KAYIT_DIZINI/${DOSYA_ADI}_ozet.txt"

# 3. KULLANICIYA SEÇENEK SUNMA
echo "========================================"
echo "🎤 OFFLINE TOPLANTI ASİSTANI"
echo "========================================"
echo "Ne yapmak istersiniz?"
echo "1) Yeni ses kaydı al"
echo "2) Var olan bir .wav dosyasını işle"
read -p "> Seçiminiz (1 veya 2): " SECIM

echo "----------------------------------------"

if [ "$SECIM" == "1" ]; then
    echo "Kayıt süresini saniye cinsinden girin (Süresiz için 0):"
    read -p "> Süre: " SURE

    if [ "$SURE" -eq 0 ]; then
        echo "🔴 Kayıt Başladı. Bitirmek için ENTER tuşuna basın."
        arecord -f S16_LE -c 1 -r 16000 "$WAV_YOLU" > /dev/null 2>&1 &
        RECORD_PID=$!
        read -r
        kill -INT $RECORD_PID
        echo "⏹️ Kayıt durduruldu."
    else
        echo "🔴 $SURE saniyelik kayıt yapılıyor..."
        arecord -f S16_LE -c 1 -r 16000 -d "$SURE" "$WAV_YOLU" > /dev/null 2>&1
        echo "⏹️ Kayıt tamamlandı."
    fi
elif [ "$SECIM" == "2" ]; then
    echo "İşlenecek .wav dosyasının tam yolunu girin:"
    read -p "> Dosya Yolu: " DIS_DOSYA_YOLU
    DIS_DOSYA_YOLU="${DIS_DOSYA_YOLU/#\~/$HOME}"
    if [ ! -f "$DIS_DOSYA_YOLU" ]; then
        echo "❌ Hata: Dosya bulunamadı!"
        exit 1
    fi
    cp "$DIS_DOSYA_YOLU" "$WAV_YOLU"
    echo "✅ Dosya başarıyla sisteme aktarıldı."
else
    echo "❌ Geçersiz seçim."
    exit 1
fi

# 4. YAZIYA DÖKME (WHISPER)
echo "----------------------------------------"
echo "📝 Transkript Çıkarılıyor..."
$WHISPER_CMD -m "$WHISPER_MODEL" -f "$WAV_YOLU" -l tr -otxt > /dev/null 2>&1
# Whisper işlemi bittikten sonra sanal ortamdaki python ile özetleyiciyi çalıştır
"$HOME/offline_asistan/env/bin/python" "$HOME/offline_asistan/ozetleyici.py" "$TXT_YOLU"
# 5. ÖZETLEME (LLAMA)
echo "----------------------------------------"
echo "🧠 Yapay Zeka Özeti Hazırlanıyor (Bu işlem biraz sürebilir)..."

# Promptu değişkene alıyoruz
PROMPT_METNI="Aşağıdaki toplantı metnini kısaca özetle ve önemli kararları listele: $(cat "$TXT_YOLU")"

# SADECE çıktıyı dosyaya yaz ( > ), sistem loglarını çöpe at ( 2>/dev/null )
# -c 4096 ile uzun metinleri anlama kapasitesini artırıyoruz
$LLAMA_CMD -m "$LLAMA_MODEL" -p "$PROMPT_METNI" -c 4096 -n 512 > "$OZET_YOLU" 2>/dev/null

# 6. BİTİŞ
echo "========================================"
echo "✅ İŞLEM TAMAMLANDI!"
echo "📂 Dosyalarınız: $KAYIT_DIZINI"
echo "========================================"
