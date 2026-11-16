# ULan – Anleitung für LAN-Partys

ULan ist eine kleine Web-App für eine LAN-Party. Sie läuft auf einem Windows-PC (dem **Host**); die Mitspieler öffnen
sie auf diesem oder einem anderen Gerät im selben Netzwerk im Browser. Es gibt eine Rangliste mit Runden, einen
anpassbaren Zähler, einen Zeitplan, gemeinsame Infos, Spielerkonten mit Steam-Links und Sound-/Namensansagen, die
am Host-PC abgespielt werden. Zusätzlich kann eine separate, schreibgeschützte Rangliste ohne Anmeldung geteilt
werden. Die ausführliche englische Anleitung steht in `README.md`.

## Schnellstart

1. **Projektordner vorbereiten:** Den gesamten Projektinhalt in einen Ordner kopieren, zum Beispiel `C:\ULan`. Dazu
   gehören `server.py`, `start.bat`, `set_console_icon.ps1`, `test_audio.py` und die Ordner `static`, `sounds` und `private_data`. Lege die mitgelieferte Datei `icon.ico` neben `start.bat`, damit sie im klassischen Eingabeaufforderungsfenster erscheint. Ohne diese Datei startet ULan wie gewohnt.
2. **Python 3 installieren:** Python von python.org installieren und dabei „Add python.exe to PATH“ aktivieren.
   Es werden keine zusätzlichen Python-Pakete benötigt.
3. **Audio testen (optional):** Im Projektordner `python test_audio.py` ausführen. Der Test spielt einen Sound
   (oder einen Test-Piepton, falls noch kein Sound hochgeladen wurde), eine Namensansage, eine Führungs-Ansage
   und eine englische Ansage ab. Unter Windows zeigt er außerdem die installierten Sprachstimmen.
4. **Server starten:** `start.bat` doppelklicken und die UAC-Abfrage für Administratorrechte bestätigen. Windows
   zeigt bei Batch-Dateien in der UAC-Abfrage „Windows Command Processor“ an; nach der Bestätigung heißt das
   einzelne Serverfenster `ULan (Administrator)`. Das zuerst geöffnete Fenster wird beim Anfordern der Rechte geschlossen. Beim ersten Start kann die Windows-Firewall fragen, ob Python im privaten Netzwerk kommunizieren
   darf. Das Fenster zeigt die Adressen, zum Beispiel `http://localhost:8080` und
   `http://192.168.x.x:8080`.
5. **Im Browser öffnen:** Auf dem Host `localhost` verwenden; Mitspieler öffnen die angezeigte LAN-Adresse.
   Den ersten Account registrieren – er wird automatisch Admin. Im Reiter „Punkte“ können Admins Spieler und
   Runden anlegen. Unter „Admin“ lässt sich ein Konto bei Bedarf mit „Als Spieler“ in die Rangliste übernehmen.
6. **Sounds einrichten:** Im Reiter „Einstellungen“ eine Sounddatei hochladen, den Ansage-Modus und Sound wählen,
   speichern und mit „Testen (am Host-PC)“ prüfen. Admins können dort auch eine Führungs-Ansage testen.

Lass das Serverfenster geöffnet, solange ULan verwendet wird. Zum Beenden im Fenster `Strg+C` drücken.

## Funktionen und Hinweise

- **Zähler, Darstellung und Zeitplan:** Der Zähler heißt standardmäßig „Hotdogs“. Hell-/Dunkelmodus kann in den
  Einstellungen umgeschaltet werden; die öffentliche Rangliste hat einen eigenen Schalter. Zeitplan-Einträge im
  Format `HH:MM` werden als täglich wiederkehrend behandelt. Der Zeitplan-Banner nutzt die lokale Uhr des jeweiligen
  Geräts; Einträge in anderen Formaten erscheinen nicht im Banner.
- **Punkte:** Eingaben erscheinen sofort in der Rundentabelle. Summen, Rangliste und Führungs-Ansage werden erst
  zwei Minuten nach der letzten Punkteänderung neu berechnet. Diese Wartezeit bleibt auch nach einem Neustart
  erhalten.
- **Sprachen:** Auf der Login-Seite gibt es den Umschalter **DE | EN**; nach dem Login ändert man die Sprache unter
  „Einstellungen“. Die Auswahl wird pro Konto gespeichert und steuert auch die Ankunfts- und Führungs-Ansagen.
  Windows verwendet für englische Ansagen eine englische Stimme, falls installiert; andernfalls die Standardstimme.
  `python test_audio.py` zeigt die installierten Stimmen.
- **Anwesenheit:** Jeder kann oben „Ich bin weg“ beziehungsweise „Ich bin zurück“ wählen. Beim Weggehen wird
  standardmäßig ein zufälliger Leave-Satz in der Kontosprache am Host-PC gesprochen; Zurückkommen ist still.
  Admins können Sätze unter „Admin“ → „Leave-Sätze“ bearbeiten: eine Zeile pro Satz, höchstens 20 pro Sprache.
  `{name}` wird durch den Namen ersetzt; leere Listen verwenden die Standardsätze. Admins können im Bereich
  „Anwesenheit“ auch den Status jedes Spielers ändern. Abwesende behalten ihre Punkte und bleiben in der Rangliste,
  werden aber als abwesend markiert.
- **Rollen:** Der erste registrierte Account wird Admin. Admins können Spieler, Runden, Zeitplan, Infotext, Sounds,
  Leave-Sätze und Anwesenheit verwalten sowie Konten zu Admins machen oder löschen. Sie können außerdem
  Führungs-Ansagen testen. Alle Nutzer können Punkte und Zähler ändern, ihr eigenes Profil und ihre Ansage
  einstellen, Sounds hochladen, die eigene Ankunfts-Ansage testen und den eigenen Anwesenheitsstatus ändern.
  Rollenrechte werden auf dem Server geprüft.

## Nur-Rangliste-Link

ULan öffnet standardmäßig einen zweiten Port (**8081**), auf dem nur Namen, Punktesummen und die eindeutige Führung
(★) angezeigt werden. Die Seite ist ohne Anmeldung erreichbar und schreibgeschützt, zum Beispiel für Fernseher
oder Beamer. Die Adresse wird im Serverfenster und im Reiter „Punkte“ angezeigt, etwa
`http://192.168.x.x:8081`. Andere App-Inhalte sind über diesen Port nicht verfügbar. Mit `LEADERBOARD_PORT = 0`
in `server.py` lässt sich der Ranglisten-Port ausschalten.

ULan verwendet unverschlüsseltes HTTP und ist für ein vertrauenswürdiges lokales Netzwerk gedacht. Wer den
Ranglisten-Port von außerhalb erreichbar macht, veröffentlicht die Rangliste für alle, die die Adresse kennen.
Leite niemals den Haupt-Port `PORT` (standardmäßig 8080) ins Internet weiter.

## Ansagen

- Die Ankunfts-Ansage läuft bei einer neuen Registrierung und – wenn `ANNOUNCE_ON_LOGIN = True` – auch beim Login.
  Neuladen der Seite und Abmelden lösen keine Ansage aus.
- Eine Führungs-Ansage kommt, wenn ein anderer Spieler allein die höchste Summe über 0 erreicht. Bei Gleichstand
  wird niemand hervorgehoben. Der bereits bekannte Führende wird beim Serverstart still gemerkt. Zwischen zwei
  Führungs-Ansagen liegen mindestens zehn Sekunden. Mit `ANNOUNCE_LEADER = False` kann man sie abschalten.
- Wenn ein Konto mit dem Namen des Führenden existiert und dessen Modus „Sound“ oder „Erst Sound, dann Name“ ist,
  wird dessen Sounddatei vor der Führungs-Phrase abgespielt. Der Name ist bereits in der Phrase enthalten.
- Sounddateien und Sprachausgabe werden unter Windows über PowerShell abgespielt. Eine Warteschlange verhindert,
  dass ULan mehrere Ansagen gleichzeitig startet.

## Einstellungen in `server.py`

Die folgenden Werte stehen am Anfang der Datei und können dort angepasst werden:

| Einstellung | Bedeutung | Standard |
|---|---|---|
| `PORT` | Port der Haupt-App | `8080` |
| `COUNTER_ITEM` | Beschriftung des Party-Zählers | `"Hotdogs"` |
| `SCORE_GRACE_SECONDS` | Wartezeit nach Punkteänderungen in Sekunden | `120` |
| `MAX_SOUND_SIZE` | Maximale Upload-Größe | `10 MB` |
| `ANNOUNCE_ON_LOGIN` | Ankunfts-Ansage auch beim Login | `True` |
| `ANNOUNCE_LEADER` | Ansage bei einem neuen Führenden | `True` |
| `ARRIVAL_PHRASE`, `ARRIVAL_PHRASE_EN` | Ankunfts-Sätze; `{name}` wird ersetzt | – |
| `LEADER_PHRASE`, `LEADER_PHRASE_EN` | Führungs-Sätze; `{name}` wird ersetzt | – |
| `DEFAULT_LANG` | Standardsprache (`"de"` oder `"en"`) | `"de"` |
| `ANNOUNCE_LEAVE` | Leave-Ansage beim Weggehen | `True` |
| `LEADERBOARD_PORT` | Nur-Rangliste; `0` schaltet sie aus | `8081` |

## Daten und Sicherheit

- Konten, Sitzungen und App-Zustand werden in `private_data/` als `users.json`, `sessions.json` und `state.json`
  gespeichert. Dieser Ordner wird nicht über HTTP ausgeliefert. Fehlen die Dateien, legt der Server sie bei Bedarf
  an; dann gibt es zunächst noch keine Konten, Sitzungen, Zeitplan-Einträge, Punkte oder Infos.
- **Wichtig beim Weitergeben oder Veröffentlichen des Projekts:** Im Projekt gibt es keine `.gitignore`, die diese
  Laufzeitdateien ausschließt. Prüfe vor einem Git-Commit, dass keine privaten Dateien aus `private_data/`
  mit aufgenommen werden.
- Passwörter werden mit scrypt und Salt gehasht. Sitzungen verwenden zufällige Tokens in einem HttpOnly- und
  SameSite=Strict-Cookie und bleiben nach einem Serverneustart erhalten. Es gibt eine Begrenzung für wiederholte
  fehlgeschlagene Anmeldeversuche.
- Uploads akzeptieren nur `.wav`, `.mp3` und `.mp4` bis 10 MB. Dateiendung und Dateiinhalt werden geprüft; die
  gespeicherten Dateien erhalten einen zufälligen Namenszusatz.
- Zum Zurücksetzen ULan beenden und die Dateien in `private_data/` löschen. Danach wird der nächste registrierte
  Account wieder Admin.

## Wenn etwas nicht klappt

- **Andere Geräte erreichen die App nicht:** Prüfe, ob alle Geräte im selben Netzwerk sind und ob die Windows-Firewall
  Python im privaten Netzwerk erlaubt. Mitspieler müssen die im Serverfenster angezeigte LAN-Adresse öffnen,
  nicht `localhost`.
- **Port bereits belegt:** ULan läuft möglicherweise schon in einem anderen Fenster. Beende die andere Instanz oder
  ändere `PORT` am Anfang von `server.py`.
- **Am Host ist nichts zu hören:** Führe `python test_audio.py` aus und prüfe Windows-Lautstärke sowie das
  Standard-Ausgabegerät.
- **Sound-Upload abgelehnt:** Erlaubt sind `.wav`, `.mp3` und `.mp4` bis 10 MB; der Dateiinhalt muss zur Endung
  passen.
- Für Hilfe sende die Ausgabe von `python test_audio.py` und die passenden Terminalzeilen, insbesondere solche mit
  **`[Host-Audio] Fehler`**, **`[Upload abgelehnt]`**, **`[404]`**, **`[FEHLER]`** oder **`[Führung]`**. Die Meldungen
  sind teilweise auf Deutsch.
