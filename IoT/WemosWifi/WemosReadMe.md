*Device van Farley Guldenaar*

![Icon](https://github.com/RondjeWelzijn/SensorStuff/blob/master/5042pc183Til/picca.png)

# Omschrijving
De code in deze repository is ontwikkeld voor mijn proof of concept. Als WiFi is verbonden blijft de gele LED branden zodra er geen WiFi is zal deze niet meer branden zo weet men of de Wemos een internet connectie heeft. Bij het detecteren van beweging brand het de groene LED en stuurt het een "WakeyWakey" bericht naar de API van Rondje Welzijn. Iedere minuut wordt er een "Alive" signaal verstuurd naar de API zodat er gezien kan worden dat het aparaat actief is.

Met behulp van de onderstaande link kan er gecontroleerd worden welk device een "WakeyWakey" signaal stuurt en welk device een "Alive" melding stuurt.

`https://rondjewelzijnapi.azurewebsites.net/meldingen`

## Benodigdheden

### Software
- Arduino IDE
 
### Hardware
- Wemos D1 mini Wifi
- Groen LED (x1)
- Geel LED (x1)
- PIR Motion Sensor
- 10 Ohm weerstand (x2)

## Software info

### IDE instellen:
Voor Windows en Mac/Apple moeten er drivers worden gedownload. Op GNU/Linux systemen is dit niet nodig.
Als eerst dient een link worden toegevoegd zodat meerdere boards worden toegevoegd. Open de Arduino IDE en voeg deze link toe `https://arduino.esp8266.com/stable/package_esp8266com_index.json` onder `File` in `Preferences` daar staat een veld genaamd additional boards manager URLS:, plak daar de link.

### Libraries toevoegen:
In de menubalk open `Tools` en dan `Manage Libraries`. In de Library Manager voeg de library toe genaamd `esp8266 microgear`.
Open nogmaals `Tools`, selecteer `Board:` en open de `Board Manager`. Zoek op `esp8266` om de board package te installeren, hierdoor kunnen er meerdere boards worden geselecteerd. Nadat die is toegevoegd, zoek onder `Tools` naar `Board:`. Kies vervolgens voor de board `LOLIN WEMOS D1 mini Lite`.    


## Hardware info

### Board info:

![Icon](https://github.com/RondjeWelzijn/SensorStuff/blob/master/5042pc183Til/ESP8266-WeMos-D1-Mini-pinout-gpio-pin.png)


### Tekening

Voor het aansluiten van de Wemos kan men de onderstaande tekening overnemen voor de aansluitingen.

| Modules | GPIO | ESP8266 |
| ------ | --- | ----- |
| Groene LED      | 14   | D5     |
| Gele LED      | 13   | D7     |
| PIR Motion      | 2   | D4     |


![Icon](https://github.com/RondjeWelzijn/SensorStuff/blob/master/5042pc183Til/WemosDraw_bb21.png)




