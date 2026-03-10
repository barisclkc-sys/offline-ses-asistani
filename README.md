# 🎙️ Offline Voice Assistant (Çevrimdışı Ses Asistanı)

[🇹🇷 Türkçe](#türkçe) | [🇬🇧 English](#english)

---

## 🇹🇷 Türkçe

Bu proje, tamamen çevrimdışı (offline) çalışarak ses kaydı alan, bu kaydı Whisper.cpp ile metne döken ve Python (Sumy) & Llama.cpp altyapıları ile özetini çıkaran bir araçtır. Özellikle Raspberry Pi gibi kaynakları sınırlı Linux sistemlerinde (veya Ubuntu sanal makinelerinde) çalışmak üzere tasarlanmıştır.

### 🚀 Kurulum Adımları

Sistemin çalışması için terminalinizi açın ve sırasıyla aşağıdaki komutları çalıştırın.

#### 1. Temel Gereksinimleri Yükleyin
```bash
sudo apt update
sudo apt install git make g++ python3-venv python3-pip wget -y




Gemini said
Anladım, hiç uzatmıyorum. Doğrudan README dosyasının içine yapıştıracağın metin tam olarak aşağıda. Sağ üstteki kopyala butonuna basıp direkt dosyaya yapıştırabilirsin:

Markdown
# 🎙️ Offline Voice Assistant (Çevrimdışı Ses Asistanı)

[🇹🇷 Türkçe](#türkçe) | [🇬🇧 English](#english)

---

## 🇹🇷 Türkçe

Bu proje, tamamen çevrimdışı (offline) çalışarak ses kaydı alan, bu kaydı Whisper.cpp ile metne döken ve Python (Sumy) & Llama.cpp altyapıları ile özetini çıkaran bir araçtır. Özellikle Raspberry Pi gibi kaynakları sınırlı Linux sistemlerinde (veya Ubuntu sanal makinelerinde) çalışmak üzere tasarlanmıştır.

### 🚀 Kurulum Adımları

Sistemin çalışması için terminalinizi açın ve sırasıyla aşağıdaki komutları çalıştırın.

#### 1. Temel Gereksinimleri Yükleyin
```bash
sudo apt update
sudo apt install git make g++ python3-venv python3-pip wget -y



2. Whisper.cpp'yi Kurun ve Modeli İndirin
cd ~
git clone [https://github.com/ggerganov/whisper.cpp.git](https://github.com/ggerganov/whisper.cpp.git)
cd whisper.cpp
make
bash ./models/download-ggml-model.sh small

3. Llama.cpp'yi Kurun (Opsiyonel/Gelişmiş Özetleme İçin)


cd ~
git clone [https://github.com/ggerganov/llama.cpp.git](https://github.com/ggerganov/llama.cpp.git)
cd llama.cpp
make

4. Projeyi İndirin ve Sanal Ortamı Kurun

cd ~
git clone [https://github.com/barisclkc-sys/offline-ses-asistani.git](https://github.com/barisclkc-sys/offline-ses-asistani.git)
cd offline-ses-asistani
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt


5. Çalıştırma

chmod +x asistan.sh
./asistan.sh








1. Install Basic Prerequisites
Bash
sudo apt update
sudo apt install git make g++ python3-venv python3-pip wget -y
2. Install Whisper.cpp and Download the Model
Bash
cd ~
git clone [https://github.com/ggerganov/whisper.cpp.git](https://github.com/ggerganov/whisper.cpp.git)
cd whisper.cpp
make
bash ./models/download-ggml-model.sh small
3. Install Llama.cpp (For Optional/Advanced Summarization)
Bash
cd ~
git clone [https://github.com/ggerganov/llama.cpp.git](https://github.com/ggerganov/llama.cpp.git)
cd llama.cpp
make
4. Clone the Project and Set Up Environment
Bash
cd ~
git clone [https://github.com/barisclkc-sys/offline-ses-asistani.git](https://github.com/barisclkc-sys/offline-ses-asistani.git)
cd offline-ses-asistani
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
5. Running the Assistant
Bash
chmod +x asistan.sh
./asistan.sh
