
# Turtlebot3-Inbetriebnahme

Ich hatte die Aufgabe in meinem Praktikum den Turtlebot3 in Betrieb zu nehmen. Diesen Prozess möchte ich hiermit dokumentieren.




## 1. Einrichtung

Der Großteil des Prozesses lässt sich [hier](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/#pc-setup) nachverfolgen.

Zusätzlich habe ich basierend auf diesem Artikel einige Skripte erstellt, die manche Befehle zusammenfassen und somit vereinfachen sollen.

Die Einrichtung ist mir mit "**W**indows **S**ubsystem for **L**inux" gelungen, wenn auch mit einigen Hindernissen, weswegen ich davon abrate und eher empfehle zur Verwendung von **ROS** ein natives Linux zu installieren. Für die Version bietet sich Ubuntu 20.04 an, sowohl als natives System als auch bei WSL.

Außerdem empfiehlt sich die Verwendung eines zusätzlichen Routers zum Kommunizieren mit dem Turtlebot, da man bei diesem statische IP-Adressen vergeben kann und keine Kommunikation zwischen den Geräten blockiert wird. Dieser muss dann mit einem anderen Netzwerk verbunden werden, danach müssen Remote-PC und Turtlebot ins Netzwerk des Routers hinzugefügt werden.

### 1.1 Vorbereitung von WSL

#### 1.1.1 Installieren der richtigen Linux-Distribution

Bei WSL lassen sich alle verfügbaren Linux-Versionen mit dem Befehl`wsl --list --online` anzeigen lassen. Wenn bei diesem Befehl eine der Optionen `Ubuntu-20.04` oder ähnliches ist, dann kann man diese mit dem Befehl `wsl --install -d Ubuntu-20.04` installieren. Optional kann man diese Distribution auch als Standard mit dem Befehl `wsl --set-default-version Ubuntu-20.04` auswählen. Jetzt kann diese mit dem Befehl `wsl` (Wenn diese Version als Standard ausgewählt wurde) oder mit dem Befeh `wsl -d Ubuntu-20.04` starten. 

#### 1.1.2 Schwierigkeiten mit WSL

WSL hat keinen direkten zugriff auf den physischen Netzwerkadapter des verwendeten PC's. Windows erstellt einen virtuellen Ethernet-Adapter, den WSL verwendet. Für diesen kann außerdem für WSL keine statische IP-Adresse vergeben werden und diese wechselt mit jedem Neustart des PC's, lässt sich aber mit dem Befehl `wsl hostname -I` ermittelt werden. Da WSL keinen direkten Zugriff auf den physischen Netzwerkadapter des PC's hat, kann es nicht ohne weiteres mit dem Turtlebot kommunizieren. Es müssen also bestimmte Regeln der Firewall aktiviert werden. Mit den Befehlen 

    PS: New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow;
    PS: New-NetFirewallRule -DisplayName "WSL" -Direction Outbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow

lassen sich diese Regeln hinzufügen. Außerdem müssen einige Ports weitergeleitet werden. Dies kann mit [diesem Skript](https://github.com/franzrichter-dev/Turtlebot3-Inbetriebnahme/blob/master/util/port_forwarding.ps1) weitergeleitet werden. Es muss nach jedem Neustart neu ausgeführt werden, da sich dann immer die IP-Adresse von WSL für den virtuellen Netzwerkadapter ändert.

### 1.2 Vorberetung einer nativen Linux-Installation (empfohlen)

#### 1.2.1 Installation von Linux

Auch für eine native Linux-Installation empfiehlt sich die Distribution Ubuntu-20.04. Dafür muss das [System-image](https://releases.ubuntu.com/20.04.6/ubuntu-20.04.6-desktop-amd64.iso) heruntergeladen werden und mit einem Programm wie [Rufus](https://github.com/pbatard/rufus/releases/download/v4.6/rufus-4.6.exe) auf einen USB-Stick geflasht werden. Dann muss der Computer mit einem erweiterten Neustart neu gestartet werden. Dazu muss beim Klicken auf den Knopf "Neu Starten" zusätzlich die "Shift"-Taste gedrückt gehalten werden. 

![Restart button](https://static1.howtogeekimages.com/wordpress/wp-content/uploads/2021/09/win11_start_menu_restart.jpg "Beim Klicken auf Neustart muss Shift gedrückt gehalten werden.")

Wenn der Computer danach neustartet, öffnet sich ein Menü, bei dem die Option "Ein Gerät verwenden" ausgewählt werden muss. In dem sich dann öffnenden Menü muss dann der USB-Stick ausgewählt werden. Wenn der Computer dann den Bootloader "Grub" startet, muss die erste Option `Try Ubuntu` ausgewählt und den Anweisungen des Installers gefolgt werden. Für mehr hilfe kann [diese Website](https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview) benutzt werden.
### 1.3 Festlegen einer statischen IP-Adresse

Wenn der Computer mit dem zusätzlichen Router verbunden ist, dann muss eine statische IP-Adresse vergeben werden.

#### 1.3.0 Format der IP-Adresse herausfinden

- Windows:
  - Öffnen Sie ein Terminal
  - Geben Sie den Befehl `ipconfig` ein
  - unter dem WLAN-Adapter sehen Sie die IP-Adresse und die des DNS-Servers/Routers.

- Linux:
  - Öffnen Sie ein Terminal
  - Geben Sie den Befehl `ifconfig` ein
  - unter dem WLAN-Interface steht die IP-Adresse hinter `inet`.

Die IP-Adresse des Routers besteht in den meisten Fällen aus den ersten drei von Punkten getrennten Zahlen und am Ende eine 1:
`xxx.xxx.xxx.1`.

Diese IP-Adresse müssen Sie bei der Option "DNS", "Standardgateway" oder "Router" eingeben.

Die IP-Adresse des jeweiligen Gerätes sollte auch aus den ersten drei von Punkten getrennten Zahlen bestehen und am Ende eine Zahl zwischen 2 und 255 haben. Die IP-Adressen des PC's und des Turtlebots dürfen nicht gleich sein.

Bei der Option "Subnetzmaske" müssen Sie `255.255.255.0` eingeben

Bei Windows müssen Sie bei der verbleibenden Option, Bevorzugter DNS, `8.8.8.8` eingeben.

#### 1.3.1 Windows & WSL

- Einstellungen > Netzwerk & Internet > WLAN > Hardwareeigenschaften > IP-Zuweisung > Ändern > Im Dropdown Manuell auswählen > IPv4 Schalter einschalten > Angefordertes eingeben

#### 1.3.2 Natives Ubuntu

- Einstellungen > WLAN > Zahnrad neben dem zusätzlichen Router > IPv4 > Manuell > Angefordertes eingeben

#### 1.3.3 Turtlebot3

- Bildschirm mit HDMI-Kabel, USB-Maus und USB-Tastatur mit dem Raspberry-PI des Turtlebots verbinden
- Bei Bedarf Turtlebot3 neustarten
- Terminal öffnen mit `STRG+ALT+T`
- Verbindung mit dem Router herstellen
    - `sudo raspi-config` ausführen
    - im Menü `2  Network options` und danach `N2  Wi-Fi` auswählen
    - danach Netzwerknamen (SSID) eingeben > `<Ok>`
    - Passwort eingeben > `<Ok>`
- `sudo nano /etc/dhcpcd.conf`
- an das Ende der Datei schreiben:
```
interface wlan0 
static ip_address=<IP-Adresse>/24
static routers=<IP-Adresse des Routers>
static domain_name_servers=<IP-Adresse des Routers>
```
- `STRG+X > y > Enter`
- `Raspberry PI` neustarten mit `sudo reboot`

Wenn der `Raspberry PI` neu gestartet ist, dann kann auf ihn mit SSH zugegriffen werden. Dazu muss man mit dem Router verbunden sein und kann in einem Terminal bei Linux `(STRG+ALT+T)` oder in einem Terminal bei Windows `(Windows+R > cmd > Enter)` `ssh pi@<IP-Adresse des Raspberry PI's>`, unter umständen danach `yes` und dann das Passwort eingeben werden. Falls es nicht geändert wurde, ist dies einfach `raspberry`. Auf diesen Weg kann auch in Zukunft auf den Raspberry-PI zugegriffen werden. 
### 1.4 Installation und Einrichtung von **ROS**

Zum Installieren von ROS kann [dieser Link](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/#pc-setup) weiter helfen.

Führen Sie den Befehl `sudo nano /etc/apt/sources.list` aus und fügen Sie die folgende Zeile am Ende der Datei hinzu:

```
deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main
```

Verlassen Sie dann den Editor mit `STRG+X > y > ENTER`.

Im Ordner `util` in diesem Repository gibt es ein Skript, was automatisch ROS und alle benötigten Pakete installiert. Dazu kann man es einfach auf dem Linux-System Klonen und das Skript ausführen.

```bash
  cd ~
  git clone https://github.com/franzrichter-dev/Turtlebot3-Inbetriebnahme.git Turtlebot3-Inbetriebnahme
  cd Turtlebot3-Inbetriebnahme
  sudo chmod 755 util/install_ros.sh
  bash util/install_ros.sh
```

Der Installationsprozess dauert eine Weile und manchmal muss etwas mit dem Drücken der "y"-Taste bestätigt werden.

Danach muss in einem Linux-Terminal oder bei WSL etwas konfiguriert werden: geben Sie `sudo nano ~/.bashrc` ein und scrollen Sie bis zum Ende der Datei. Falls noch nicht vorhanden, fügen Sie folgendes hinzu:
```
export TURTLEBOT3_MODEL=waffle_pi
source /opt/ros/noetic/setup.bash

export ROS_MASTER_URI=http://master:11311
export ROS_HOSTNAME=master
```

Verlassen Sie den Texteditor wieder mit `STRG+X > y > Enter`.

Führen Sie danach den Befehl `source ~/.bashrc` aus.

Geben Sie dann `sudo nano /etc/hosts` ein.

Fügen Sie dann unter dem ersten Absatz folgendes ein: 
```
127.0.1.1       master
```

Verlassen Sie den Texteditor wieder mit `STRG+X > y > Enter`.

Öffnen Sie dann mit SSH ein Terminal zum Turtlebot.

Führen Sie den Befehl `sudo nano ~/.bashrc` aus.

Fügen Sie am Ende der Datei folgendes hinzu:
```
export ROS_MASTER_URI=http://master:11311
export ROS_HOSTNAME=<IP-Adresse des Raspberry PI's>
```

Verlassen Sie den Texteditor mit `STRG+X > y > Enter`

Geben Sie dann den Befehl `source ~/.bashrc` ein.

Öffnen Sie auch hier die `hosts`-Datei mit `sudo nano /etc/hosts`

Fügen Sie unter dem ersten Abschnitt
```
<IP-Adresse des Host PC's>      master
```
ein.
## 2. Starten von **ROS**

Auf dem Host-PC, geben Sie in einem Linux oder WSL Terminal den Befehl `roscore` ein. Wenn dies keine Fehlermeldung ausgibt und sehr schnell startet, dann hat alles funktioniert. Andernfalls gibt es möglicherweise einen Konfigurationsfehler. Sie können veruchen, noch einmal den Befehl `source ~/.bashrc` auszuführen. Eventuell müssen Sie noch die fehlenden Packete für ROS installieren, die in der Fehlermeldung erwähnt wurden. Die entsprechenden Befehle müssten mit einer Google-Suche zu finden sein.

Kopieren Sie [diese Datei](https://github.com/franzrichter-dev/Turtlebot3-Inbetriebnahme/blob/master/util_turtlebot.tar) auf den Turtlebot. Dies können Sie mit diesem Befehl machen (bei Windows und Linux):
```
scp <Pfad der util_turtlebot.tar Datei> pi@<IP-Adresse des Turtlebots>:~/util_turtlebot.tar
```

Danach müssen Sie wieder das Passwort des Turtlebots eingeben (`raspberry`).

Starten Sie eine SSH-Session mit dem Turtlebot und führen Sie folgende Befehle auf ihm aus:
```
cd ~
tar -xvzf util_turtlebot.tar util
sudo chmod 755 ~/util/launch_bringup.sh
sudo chmod 755 ~/util/restart_network.sh
```

Nun haben Sie einige weitere unterstützende Skripte im Ordner `~/util`.

Wenn Sie den Befehl `roscore` auf dem Host-PC erfolgreich ausgeführt haben, dann können Sie das Skript `~/util/launch_bringup.sh` mit dem Befehl `bash ~/util/launch_bringup.sh` ausführen. Das andere Skript im Ordner `~/util` startet das Internet des Turtlebots neu, was beim Konfigurieren der IP-Adressen nützlich sein kann. Um es auszuführen, geben Sie bei Bedarf `bash ~/util/restart_network.sh` ein.

Wenn `roscore` und `launch_bringup.sh` auf dem Host-PC und dem Turtlebot gleichzeitig ohne Fehler läuft, dann können Sie den rc100-Controller einschalten und müssten damit den Turtlebot steuern können.
## 3. Videos aufnehmen und ansehen

Mit den Befehlen `bash ~/Desktop/start_experiment.sh` und `bash ~/Desktop/stop_experiment.sh` auf dem Turtlebot können Sie eine Videoaufnahme starten und stoppen. Die Ergebnisse werden in einem Unterordner mit der Systemzeit in Millisekunden im Ordner `~/Desktop` gespeichert. Sie können den Inhalt des Desktop-Ordners mit dem Befehl `ls -a ~/Desktop` ansehen. Navigieren Sie in diesen Ordner mit dem Befehl `cd ~/Desktop/<Ordnername>`. Kopieren Sie die Datei mit der Endung `.h264` in den Home-Ordner:
```
ls -a
<Ergebnis:> xxxxxxxxx.h264  start_experiment.sh
<Fangen Sie an die erste Zahl der .h264-Datei zu schreiben und drücken Sie dann die TAB-Taste, wenn Sie diesen Dateinamen schreiben möchten.>
cp xxxxxxxxx.h264 ~/video.h264
```

Vom Host-PC aus können Sie wieder mit `scp` das Video kopieren:
```
scp pi@<IP-Adresse des Turtlebots>:~/video.h264 <Pfad, zu dem das Video kopiert werden soll>/video.h264
```

Geben Sie wieder das Passwort für den Turtlebot ein.

Um das Video jetzt auf dem Host-PC anzusehen, benötigen Sie den zugriff auf eine grafische Oberfläche, wenn Sie also WSL verwenden, dann sollten Sie die folgenden Schritten nicht auf WSL, sondern direkt bei Windows ausführen.

Installieren Sie [FFmpeg](https://www.ffmpeg.org/).

Führen Sie dann den Befehl `ffplay -f <Pfad zum Video auf dem Host-PC>/video.h264` aus und es sollte ein Fenster erscheinen, in dem Sie das Video anschauen können.
## 4. SLAM

Mit [SLAM](https://emanual.robotis.com/docs/en/platform/turtlebot3/slam/#run-slam-node) können Sie die Lidardaten des Turtlebots live ansehen. Führen Sie dazu `roscore` auf dem Host-PC und `bash ~/util/launch_bringup.sh` auf dem Turtlebot aus. Öffnen Sie dann ein zweites Terminal auf dem Host-PC und führen Sie die Befehle 
```
sudo apt install ros-noetic-slam-karto
roslaunch turtlebot3_slam turtlebot3_slam.launch slam_methods:=karto
```
aus. Es öffnet sich ein Fenster, in dem Sie die Lidardaten des Turtlebots sehen können. Es müssten auch die Wände und andere Hindernisse angezeigt werden.
