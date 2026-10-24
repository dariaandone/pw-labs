#!/usr/bin/env bash
# Pregatirea containerului pentru Laboratorul 6: Layout si responsive
# Rulare: curl -fsSL https://raw.githubusercontent.com/dariaandone/pw-labs/main/setup/lab6.sh | bash
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
mkdir -p imagini css
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
cat > contact.html <<'SFARSIT_FISIER'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Contact | Boabe</title>
    <link rel="stylesheet" href="css/stil.css">
</head>
<body>
    <header>
        <img src="imagini/logo.svg" alt="Boabe" width="64" height="64">
        <nav>
            <ul>
                <li><a href="index.html">Acasă</a></li>
                <li><a href="meniu.html">Meniu</a></li>
                <li><a href="contact.html" class="activ">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Contact</h1>

        <section id="adresa">
            <h2>Unde ne găsiți</h2>
            <p>Strada Teilor nr. 12</p>
            <p>Telefon: <a href="tel:+40700000000">0700 000 000</a></p>
            <p>E-mail: <a href="mailto:salut@boabe.example">salut@boabe.example</a></p>
        </section>

        <section id="program">
            <h2>Program</h2>
            <ul>
                <li>Luni - Vineri: 7:30 - 20:00</li>
                <li>Sâmbătă - Duminică: 9:00 - 18:00</li>
            </ul>
        </section>
    </main>

    <footer>
        <p>Strada Teilor nr. 12 · Luni - Vineri: 7:30 - 20:00 · Sâmbătă - Duminică: 9:00 - 18:00</p>
    </footer>
</body>
</html>
SFARSIT_FISIER
cat > css/stil.css <<'SFARSIT_FISIER'
/* Stilul site-ului Boabe */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    line-height: 1.6;
    color: #3b2a20;
    background-color: #fdf8f2;
}

h1,
h2 {
    font-family: Georgia, "Times New Roman", serif;
    color: #6b3e26;
}

a {
    color: #a0522d;
}

header,
footer {
    padding: 16px;
    background-color: #3b2a20;
    color: #fdf8f2;
}

nav a {
    color: #fdf8f2;
    font-weight: bold;
    text-decoration: none;
}

nav a.activ {
    text-decoration: underline;
}

main {
    max-width: 800px;
    margin: 0 auto;
    padding: 16px;
}

#oferta li {
    margin-bottom: 8px;
    padding: 12px;
    border: 1px solid #e0d2c3;
    border-radius: 8px;
    background-color: #ffffff;
}

.pret {
    color: #a0522d;
    font-weight: bold;
}

table {
    width: 100%;
    margin-bottom: 24px;
    border-collapse: collapse;
}

caption {
    font-weight: bold;
    text-align: left;
}

th,
td {
    padding: 8px;
    border-bottom: 1px solid #e0d2c3;
    text-align: left;
}

footer p {
    margin: 0;
    text-align: center;
}
SFARSIT_FISIER
cat > index.html <<'SFARSIT_FISIER'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Boabe, cafenea de cartier</title>
    <link rel="stylesheet" href="css/stil.css">
</head>
<body>
    <header>
        <img src="imagini/logo.svg" alt="Boabe" width="64" height="64">
        <nav>
            <ul>
                <li><a href="index.html" class="activ">Acasă</a></li>
                <li><a href="meniu.html">Meniu</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Boabe, cafenea de cartier</h1>
        <p>Deschisă din 2019. Cafea prăjită de noi, deserturi făcute în casă.</p>

        <section id="despre">
            <h2>Despre noi</h2>
            <p>Prăjim cafeaua <strong>în fiecare marți</strong>, în cantități mici, ca să ajungă la voi proaspătă. Deserturile le face Ioana, în bucătăria din spate, după rețetele bunicii ei.</p>
            <p>La noi puteți lucra liniștiți: avem internet rapid, prize la fiecare masă și o terasă deschisă din aprilie până în octombrie.</p>
        </section>

        <section id="oferta">
            <h2>Oferta zilei</h2>
            <ul>
                <li>Espresso dublu <span class="pret">12 lei</span></li>
                <li>Cheesecake cu vișine <span class="pret">18 lei</span></li>
                <li>Limonadă cu mentă <span class="pret">14 lei</span></li>
            </ul>
            <p>Comandați oricare două și primiți <strong>10% reducere</strong>.</p>
        </section>

        <section id="preparare">
            <h2>Cum ne pregătim cafeaua</h2>
            <ol>
                <li>Alegem boabele de la ferme mici.</li>
                <li>Le prăjim marțea.</li>
                <li>Le măcinăm chiar înainte de preparare.</li>
            </ol>
        </section>

        <section id="galerie">
            <h2>Galerie</h2>
            <img src="imagini/cafea.svg" alt="Ceașcă de cappuccino cu o inimă desenată în spumă">
            <img src="imagini/desert.svg" alt="Felie de cheesecake cu vișine">
            <img src="imagini/terasa.svg" alt="Terasa cafenelei, cu mese și umbrele">
        </section>
    </main>

    <footer>
        <p>Strada Teilor nr. 12 · Luni - Vineri: 7:30 - 20:00 · Sâmbătă - Duminică: 9:00 - 18:00</p>
    </footer>
</body>
</html>
SFARSIT_FISIER
cat > meniu.html <<'SFARSIT_FISIER'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Meniu | Boabe</title>
    <link rel="stylesheet" href="css/stil.css">
</head>
<body>
    <header>
        <img src="imagini/logo.svg" alt="Boabe" width="64" height="64">
        <nav>
            <ul>
                <li><a href="index.html">Acasă</a></li>
                <li><a href="meniu.html" class="activ">Meniu</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Meniu</h1>

        <table>
            <caption>Cafea</caption>
            <thead>
                <tr>
                    <th>Produs</th>
                    <th>Mic</th>
                    <th>Mare</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Espresso</td>
                    <td>9 lei</td>
                    <td>12 lei</td>
                </tr>
                <tr>
                    <td>Cappuccino</td>
                    <td>12 lei</td>
                    <td>15 lei</td>
                </tr>
                <tr>
                    <td>Latte</td>
                    <td>13 lei</td>
                    <td>16 lei</td>
                </tr>
                <tr>
                    <td>Flat white</td>
                    <td>14 lei</td>
                    <td>-</td>
                </tr>
            </tbody>
        </table>

        <table>
            <caption>Deserturi</caption>
            <thead>
                <tr>
                    <th>Produs</th>
                    <th>Porție</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Cheesecake cu vișine</td>
                    <td>18 lei</td>
                </tr>
                <tr>
                    <td>Brioșă cu afine</td>
                    <td>11 lei</td>
                </tr>
                <tr>
                    <td>Tartă cu lămâie</td>
                    <td>16 lei</td>
                </tr>
            </tbody>
        </table>

        <p>Prețurile includ TVA.</p>
    </main>

    <footer>
        <p>Strada Teilor nr. 12 · Luni - Vineri: 7:30 - 20:00 · Sâmbătă - Duminică: 9:00 - 18:00</p>
    </footer>
</body>
</html>
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
