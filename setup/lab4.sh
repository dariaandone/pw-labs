#!/usr/bin/env bash
# Pregatirea containerului pentru Laboratorul 4: HTML: structura paginii
# Rulare: curl -fsSL https://raw.githubusercontent.com/dariaandone/pw-labs/main/setup/lab4.sh | bash
set -e

SITE="$HOME/site"

echo "==> 1/4 Instalez Nginx (dureaza un minut)"
sudo apt-get update -qq
sudo apt-get install -y -qq nginx curl > /dev/null

echo "==> 2/4 Pregatesc folderul site-ului: $SITE"
if [ -d "$SITE" ]; then
    VECHI="$SITE-vechi-$(date +%H%M%S)"
    mv "$SITE" "$VECHI"
    echo "    Exista deja un site. L-am mutat in $VECHI"
fi
mkdir -p "$SITE"
cd "$SITE"
mkdir -p imagini
cat > imagini/cafea.svg <<'SFARSIT_FISIER'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" width="400" height="300">
  <rect width="400" height="300" fill="#e8d5c0"/>
  <ellipse cx="200" cy="225" rx="130" ry="30" fill="#fdf8f2"/>
  <path d="M110 120 h180 v60 a90 70 0 0 1 -180 0 z" fill="#fdf8f2"/>
  <path d="M290 135 a30 30 0 0 1 0 50" fill="none" stroke="#fdf8f2" stroke-width="12"/>
  <ellipse cx="200" cy="120" rx="90" ry="18" fill="#a0522d"/>
  <path d="M200 108 q-25 6 0 22 q25 -16 0 -22" fill="#fdf8f2"/>
</svg>
SFARSIT_FISIER
cat > imagini/desert.svg <<'SFARSIT_FISIER'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" width="400" height="300">
  <rect width="400" height="300" fill="#f3e3e6"/>
  <ellipse cx="200" cy="230" rx="150" ry="28" fill="#ffffff"/>
  <path d="M90 210 L300 210 L300 150 L90 120 z" fill="#f5e6c8"/>
  <path d="M90 120 L300 150 L300 135 L90 105 z" fill="#8b1e3f"/>
  <path d="M90 210 L300 210 L300 196 L90 196 z" fill="#c49a6c"/>
  <circle cx="150" cy="112" r="10" fill="#8b1e3f"/>
  <circle cx="200" cy="120" r="10" fill="#8b1e3f"/>
  <circle cx="250" cy="128" r="10" fill="#8b1e3f"/>
</svg>
SFARSIT_FISIER
cat > imagini/logo.svg <<'SFARSIT_FISIER'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100">
  <circle cx="50" cy="50" r="48" fill="#6b3e26"/>
  <path d="M28 44 h38 v14 a19 19 0 0 1 -38 0 z" fill="#fdf8f2"/>
  <path d="M66 48 a8 8 0 0 1 0 14" fill="none" stroke="#fdf8f2" stroke-width="4"/>
  <path d="M38 36 q-4 -6 0 -12 M48 36 q-4 -6 0 -12 M58 36 q-4 -6 0 -12" fill="none" stroke="#fdf8f2" stroke-width="3" stroke-linecap="round"/>
</svg>
SFARSIT_FISIER
cat > imagini/terasa.svg <<'SFARSIT_FISIER'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" width="400" height="300">
  <rect width="400" height="300" fill="#cfe3ec"/>
  <rect y="220" width="400" height="80" fill="#c49a6c"/>
  <path d="M60 110 q60 -50 120 0 z" fill="#6b3e26"/>
  <rect x="117" y="110" width="6" height="110" fill="#3b2a20"/>
  <path d="M220 110 q60 -50 120 0 z" fill="#a0522d"/>
  <rect x="277" y="110" width="6" height="110" fill="#3b2a20"/>
  <rect x="85" y="200" width="70" height="8" fill="#3b2a20"/>
  <rect x="245" y="200" width="70" height="8" fill="#3b2a20"/>
</svg>
SFARSIT_FISIER
cat > continut.txt <<'SFARSIT_FISIER'
Boabe, cafenea de cartier

Deschisă din 2019. Cafea prăjită de noi, deserturi făcute în casă.

Despre noi

Prăjim cafeaua în fiecare marți, în cantități mici, ca să ajungă la voi proaspătă. Deserturile le face Ioana, în bucătăria din spate, după rețetele bunicii ei.

La noi puteți lucra liniștiți: avem internet rapid, prize la fiecare masă și o terasă deschisă din aprilie până în octombrie.

Oferta zilei

Espresso dublu, 12 lei
Cheesecake cu vișine, 18 lei
Limonadă cu mentă, 14 lei

Comandați oricare două și primiți 10% reducere.

Cum ne pregătim cafeaua

Alegem boabele de la ferme mici.
Le prăjim marțea.
Le măcinăm chiar înainte de preparare.

Program

Luni - Vineri: 7:30 - 20:00
Sâmbătă - Duminică: 9:00 - 18:00

Strada Teilor nr. 12. Telefon: 0700 000 000. E-mail: salut@boabe.example
SFARSIT_FISIER
cat > index.html <<'SFARSIT_FISIER'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>În lucru</title>
</head>
<body>
    <p>Aici va fi site-ul cafenelei Boabe.</p>
</body>
</html>
SFARSIT_FISIER
cat > meniu.txt <<'SFARSIT_FISIER'
Meniu

Cafea
Produs        | Mic    | Mare
Espresso      | 9 lei  | 12 lei
Cappuccino    | 12 lei | 15 lei
Latte         | 13 lei | 16 lei
Flat white    | 14 lei | nu există

Deserturi
Produs                 | Porție
Cheesecake cu vișine   | 18 lei
Brioșă cu afine        | 11 lei
Tartă cu lămâie        | 16 lei

Prețurile includ TVA.
SFARSIT_FISIER

echo "==> 3/4 Configurez Nginx sa serveasca $SITE"
chmod o+x "$HOME"
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root $SITE;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
sudo nginx -t
sudo service nginx restart > /dev/null

echo "==> 4/4 Verific"
COD=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/)
if [ "$COD" = "200" ]; then
    echo "Gata! Serverul raspunde cu $COD."
    echo "Deschideti in browser: http://IP:PORT_SITE"
    echo "Fisierele site-ului sunt in: $SITE"
else
    echo "Serverul a raspuns cu $COD in loc de 200. Chemati profesorul."
    exit 1
fi
