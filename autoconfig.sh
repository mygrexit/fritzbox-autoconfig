#!/usr/bin/env bash

# todo: grep nach dateiname und übergabe an sed als Variable 

submenu() {
echo
read -p "Bitte gib die PPPoE-Kennung ein: " PPPOE
read -s -p "Bitte gib das PPPoE-Passwort ein: " PPPOEPASS
echo
read -s -p "Bitte gib das Fritz!Box-Passwort ein: " FBPASS
echo
sleep 1
echo
#echo PPPoE-User: $PPPOE
#sleep 1
#echo PPPoE-Passwort: $PPPOEPASS
#sleep 1
#echo Fritz!Box-Passwort: $FBPASS
#sleep 1
#echo

# Prüfung ob PHP installiert ist.

echo -e 'Prüfe ob PHP installiert ist...'
sleep 1

if ! [ -x "$(command -v php)" ]; then
  echo -e '\e[41mFehler: PHP is nicht installiert. Bitte eine aktuelle PHP-Version installieren.\e[0m'>&2
  exit 1
  else
  php --version
  echo
  sleep 1
  echo -e '\e[30;48;5;82mPHP wurde gefunden, fahre fort.\e[0m'
  echo
  sleep 1
fi


# Führe das Skript aus

#php fb_tools/fb_tools.php $FBPASS@192.168.178.1 konfig export
#echo

#Suche die aktuelle .export-Datei um diese zu bearbeiten.
#Hinweis: Es ist wohl nicht best practice, mit "ls"-Output zu arbeiten. Wir sollten das auf "find" ändern.

FILENAME=$(ls -t fb_tools/|grep 'FRITZ.Box'|head -n 1)

echo $FILENAME
echo $FILENAME
echo $FILENAME

# PPPoE-Username und Passwort durch Variable ersetzen

sed -E -i '/^[^\n]*targets/{:a;N;/passwd/!ba
        s/^([^\n]*\n){1,10}[^\n]*$/&/;Tb
        s/(username = ).*/\1"'$PPPOE'";/m
        s/(passwd = ).*/\1"'$PPPOEPASS'";/m};:b;P;D' fb_tools/"${FILENAME}"

exit 0

}

mainmenu() {
echo
echo
base64 -d <<<"H4sICASETGEAA3JlbGFpeDIudHh0AI2T0RGAMAhD/zMFEzhT9p9CW882DVTNjwfktRWOiCl2HU3XN1y9wsC0Hy5moAkWb5npwB5QiJJpiFqYHLE4rhgS6zvUZAdgFov2mO4KWBMF9DxiIHkMxow0tpcYE7+Q9Rb+QPzn+YVUHeMbQvVJsEd8+ktcIXaq31ohuUkLNEaZEQX0JPTdshW8t9N7+KRxAniPm3PJAwAA" | gunzip
echo
echo Konfigurationsscript für Fritz!Boxen - Version 0.1
echo
    echo -ne "
1) PPPoE
2) Ethernet
0) Exit
Auswahl: "
    read -r ans
    case $ans in
    1)
        submenu
        mainmenu
        ;;
    2)
        submenu
        mainmenu
        ;;
    0)
        echo "Tschüss, Du Betrüger!"
        exit 0
        ;;
    *)
        echo "Ungültige Auswahl. Das Skript wird beendet."
        exit 1
        ;;
    esac
}

mainmenu

fn_bye() {
    echo "Tschüss, Du Betrüger!"
    exit 0
}

fn_fail() {
    echo "Ungültige Auswahl. Das Skript wird beendet."
    exit 1
}
