
# Turtlebot3-Inbetriebnahme

Ich hatte die Aufgabe in meinem Praktikum den Turtlebot3 in Betrieb zu nehmen. Diesen Prozess möchte ich hiermit dokumentieren.




## 1. Einrichtung der PC-Umgebung

Der Großteil des Prozesses lässt sich [hier](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/#pc-setup) nachverfolgen.

Zusätzlich habe ich basierend auf diesem Artikel einige Skripte erstellt, die manche Befehle zusammenfassen und somit vereinfachen sollen.

Die Einrichtung ist mir mit "**W**indows **S**ubsystem for **L**inux" gelungen, wenn auch mit einigen Hindernissen, weswegen ich davon abrate und eher empfehle zur Verwendung von **ROS** ein natives Linux zu installieren. Für die Version bietet sich Ubuntu 20.04 an, sowohl als natives System als auch bei WSL.

Außerdem empfiehlt sich die Verwendung eines zusätzlichen Routers zum Kommunizieren mit dem Turtlebot, da man bei diesem statische IP-Adressen vergeben kann und keine Kommunikation zwischen den Geräten blockiert wird. Dieser muss dann mit einem anderen Netzwerk verbunden werden, danach müssen Remote-PC und Turtlebot ins Netzwerk des Routers hinzugefügt werden.

### 1.1 Einrichung mit WSL

#### 1.1.1 Installieren der richtigen Linux-Distribution

Bei WSL lassen sich alle verfügbaren Linux-Versionen mit dem Befehl`wsl --list --online` anzeigen lassen. Wenn bei diesem Befehl eine der Optionen `Ubuntu-20.04` oder ähnliches ist, dann kann man diese mit dem Befehl `wsl --install -d Ubuntu-20.04` installieren. Optional kann man diese Distribution auch als Standard mit dem Befehl `wsl --set-default-version Ubuntu-20.04` auswählen. Jetzt kann diese mit dem Befehl `wsl` (Wenn diese Version als Standard ausgewählt wurde) oder mit dem Befeh `wsl -d Ubuntu-20.04` starten. 
