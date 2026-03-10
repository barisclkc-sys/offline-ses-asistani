import sys
import os
import nltk
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.lsa import LsaSummarizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words

# NLTK paketini kontrol et, yoksa indir (sadece ilk seferde çalışır, sonra tamamen offline)
try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    nltk.download('punkt', quiet=True)

def metni_ozetle(dosya_yolu):
    if not os.path.exists(dosya_yolu):
        print(f"Hata: {dosya_yolu} bulunamadı.")
        return

    with open(dosya_yolu, "r", encoding="utf-8") as f:
        metin = f.read()

    if not metin.strip():
        print("Metin boş, özetlenecek bir şey yok.")
        return

    dil = "turkish"
    parser = PlaintextParser.from_string(metin, Tokenizer(dil))
    stemmer = Stemmer(dil)
    summarizer = LsaSummarizer(stemmer)
    summarizer.stop_words = get_stop_words(dil)

    # Özet uzunluğu (Şu an en önemli 3 cümleyi seçiyor)
    ozet_cumleleri = summarizer(parser.document, 3)

    # Dosya adını ayarla (Örn: ses1.wav.txt -> ses1_ozet.txt)
    dizin, dosya_adi = os.path.split(dosya_yolu)
    temel_ad = dosya_adi.replace(".wav.txt", "").replace(".txt", "")
    yeni_dosya_adi = f"{temel_ad}_ozet.txt"
    yeni_dosya_yolu = os.path.join(dizin, yeni_dosya_adi)

    with open(yeni_dosya_yolu, "w", encoding="utf-8") as f:
        for cumle in ozet_cumleleri:
            f.write(str(cumle) + "\n")
    
    print(f"Özet başarıyla oluşturuldu: {yeni_dosya_yolu}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Kullanım eksik. Lütfen dosya yolu verin.")
    else:
        metni_ozetle(sys.argv[1])
