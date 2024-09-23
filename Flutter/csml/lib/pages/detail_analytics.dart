import 'package:csml/utils/colors.dart';
import 'package:csml/utils/graph_container.dart';
import 'package:csml/utils/text_builder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Detail_Analytics_Safety extends StatelessWidget {
  const Detail_Analytics_Safety({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Fahrsicherheit          ',
            style: TextStyle(color: Colors.white), // Schriftfarbe des Titels
          ),
        ),
          backgroundColor: mycolorBackground, // Hintergrundfarbe der AppBar
          iconTheme: const IconThemeData(color: const Color.fromRGBO(239, 35, 60, 1)), // Farbe des Zurück-Pfeils
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Container(
              height: MediaQuery.of(context).size.height / 3, // Höhe auf ein Drittel der Seite beschränken
              child: GraphContainer(
                dataPoints: [
                  FlSpot(0, 782),
                  FlSpot(1, 723),
                  FlSpot(2, 776),
                  FlSpot(3, 817),
                  FlSpot(4, 790),
                  FlSpot(5, 783),
                  FlSpot(6, 821),
                  FlSpot(7, 803),
                ],
                color: mycolorPurple,
                route: '', // Falls der Button aktuell keine Route benötigt
                context: context,
                title: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextContainer(
                    titleColor: mycolorPurple,
                    title: 'Das Wichtigste im Überblick',
                    text: ' - Konstante Geschwindigkeit\n - Vorausschauendes Fahren\n - Angepasste Beschleunigung\n - Abstand zum Vordermann',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPurple,
                    title: 'Konstante Geschwindigkeit',
                    text: 'Das Halten einer konstanten Geschwindigkeit ist eine der effektivsten Methoden, um die Fahrsicherheit zu verbessern. Durch eine gleichmäßige Fahrt vermeidest du unnötige Beschleunigungs- und Bremsmanöver, die das Unfallrisiko erhöhen können. Insbesondere auf Autobahnen oder Landstraßen ist es wichtig, gleichmäßig zu fahren, um plötzliche Reaktionen anderer Verkehrsteilnehmer zu vermeiden. Außerdem trägt eine konstante Geschwindigkeit zur besseren Kontrolle des Fahrzeugs bei, da das Auto stabiler bleibt und die Reifen gleichmäßig abgenutzt werden. Hohe Geschwindigkeiten erhöhen das Unfallrisiko erheblich, da die Reaktionszeit kürzer und die Aufprallenergie bei einem Unfall deutlich höher ist. Zudem wird die Fahrzeugkontrolle erschwert, besonders bei Kurvenfahrten oder schlechten Witterungsbedingungen. Studien zeigen, dass die Wahrscheinlichkeit eines Unfalls exponentiell mit der Geschwindigkeit zunimmt. Eine moderate Geschwindigkeit ermöglicht dir, rechtzeitig auf unerwartete Situationen zu reagieren und gibt dir mehr Kontrolle über das Fahrzeug, was die Sicherheit sowohl für dich als auch für andere Verkehrsteilnehmer erhöht.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPurple,
                    title: 'Vorausschauendes Fahren',
                    text: 'Vorausschauendes Fahren ist entscheidend, um potenzielle Gefahren frühzeitig zu erkennen und rechtzeitig darauf zu reagieren. Dies bedeutet, dass du nicht nur auf das Fahrzeug direkt vor dir achtest, sondern auch auf die Verkehrssituation weiter vorne und in deiner Umgebung. So kannst du Hindernisse, plötzliche Bremsmanöver anderer Fahrzeuge oder gefährliche Situationen, wie zum Beispiel ein Kind am Straßenrand, frühzeitig wahrnehmen und entsprechend handeln. Zudem ermöglicht dir vorausschauendes Fahren, deinen Fahrstil entsprechend anzupassen und so unnötige Risiken zu vermeiden.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPurple,
                    title: 'Angepasste Beschleunigung',
                    text: 'Eine kontrollierte und sanfte Beschleunigung sorgt dafür, dass das Fahrzeug stabil bleibt und du die Kontrolle behältst. Aggressives Beschleunigen führt zu einem instabilen Fahrzeugverhalten, insbesondere auf nasser oder glatter Fahrbahn. Durch eine gleichmäßige Beschleunigung minimierst du das Risiko des Durchdrehens der Räder und der daraus resultierenden Instabilität des Fahrzeugs. Zudem trägt eine ruhige Beschleunigung dazu bei, den Verschleiß an Reifen und Antriebsstrang zu reduzieren, was wiederum die Sicherheit des Fahrzeugs erhöht.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPurple,
                    title: 'Richtiger Abstand zum Vordermann',
                    text: 'Der richtige Abstand zum Vordermann ist ein entscheidender Faktor, um Auffahrunfälle zu vermeiden. Ein ausreichender Sicherheitsabstand gibt dir genügend Zeit, auf plötzliche Bremsmanöver oder andere unerwartete Ereignisse zu reagieren. Die Faustregel lautet: Der Sicherheitsabstand sollte bei normalem Wetter mindestens die Hälfte der gefahrenen Geschwindigkeit in Metern betragen (z.B. bei 100 km/h mindestens 50 Meter Abstand). Bei schlechten Witterungsbedingungen oder schlechter Sicht sollte der Abstand entsprechend vergrößert werden. Ein angemessener Abstand erhöht die Reaktionszeit und damit die Sicherheit im Straßenverkehr.',
                    containerColor: mycolorBackground
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Detail_Analytics_Eco extends StatelessWidget {
  const Detail_Analytics_Eco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Umweltbewusstsein       ',
            style: TextStyle(color: Colors.white), // Schriftfarbe des Titels
          ),
        ),
        backgroundColor: mycolorBackground, // Hintergrundfarbe der AppBar
        iconTheme: const IconThemeData(color: Color.fromRGBO(239, 35, 60, 1)), // Farbe des Zurück-Pfeils
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3, // Höhe auf ein Drittel der Seite beschränken
              child: GraphContainer(
                dataPoints: [
                  FlSpot(0, 679),
                  FlSpot(1, 651),
                  FlSpot(2, 665),
                  FlSpot(3, 688),
                  FlSpot(4, 709),
                  FlSpot(5, 721),
                  FlSpot(6, 729),
                  FlSpot(7, 743),
                ],
                color: mycolorPink,
                route: '', // Falls der Button aktuell keine Route benötigt
                context: context,
                title: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Das Wichtigste im Überblick',
                    text: ' - Sanftes Beschleunigen und Bremsen\n - Drehzahlbereich beachten\n - Konstante Geschwindigkeit\n - Hohe Geschwindigkeiten vermeiden\n - Vermeidung von Leerlaufzeiten',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Sanftes Beschleunigen und Bremsen',
                    text: 'Sanftes Beschleunigen und gleichmäßiges Bremsen sind zentrale Aspekte eines umweltbewussten Fahrstils. Durch das Vermeiden von abrupten Beschleunigungs- und Bremsvorgängen können Sie den Kraftstoffverbrauch um bis zu 20 % senken. Plötzliche Beschleunigungsvorgänge zwingen den Motor, mehr Kraftstoff zu verbrennen, was den CO₂-Ausstoß erhöht. Genauso führt starkes Abbremsen oft dazu, dass die durch die Beschleunigung gewonnene Energie ungenutzt verloren geht. Indem Sie vorausplanen und eine gleichmäßige Geschwindigkeit beibehalten, sparen Sie nicht nur Sprit, sondern auch Bremsenverschleiß.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Drehzahlbereich beachten',
                    text: 'Das Fahren im optimalen Drehzahlbereich ist ein weiterer wichtiger Punkt, um den Kraftstoffverbrauch zu minimieren. Moderne Fahrzeuge sind darauf ausgelegt, in einem bestimmten Drehzahlbereich am effizientesten zu arbeiten – meist zwischen 1.500 und 2.500 Umdrehungen pro Minute (U/min) bei Dieselmotoren und zwischen 2.000 und 3.000 U/min bei Benzinmotoren. Wenn Sie den Motor in einem höheren Drehzahlbereich betreiben, verbraucht er unverhältnismäßig viel Kraftstoff. Daher sollten Sie frühzeitig in den nächsthöheren Gang schalten und das Gaspedal maßvoll betätigen, um den Motor im optimalen Bereich zu halten.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Konstante Geschwindigkeit',
                    text: 'Eine konstante Geschwindigkeit zu halten, ist eine der einfachsten Methoden, um den Kraftstoffverbrauch zu reduzieren. Häufige Beschleunigungs- und Abbremsvorgänge erfordern zusätzliche Energie, während eine gleichmäßige Fahrweise den Motor effizient arbeiten lässt. Tempomaten können in vielen Fällen helfen, die Geschwindigkeit konstant zu halten, insbesondere auf Autobahnen oder Landstraßen. Studien zeigen, dass das Fahren mit konstanter Geschwindigkeit den Verbrauch um bis zu 10 % senken kann. Auch das sogenannte "Segeln" – also das Fahren ohne Gasgeben, wenn das Fahrzeug bergab rollt – trägt dazu bei, den Energieverbrauch zu reduzieren.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Hohe Geschwindigkeiten vermeiden',
                    text: 'Hohe Geschwindigkeiten sind einer der größten Energieverbraucher im Straßenverkehr. Ab etwa 100 km/h steigt der Luftwiderstand exponentiell an, was bedeutet, dass das Fahrzeug erheblich mehr Energie benötigt, um schneller zu fahren. Der Kraftstoffverbrauch kann sich bei einer Geschwindigkeit von 130 km/h im Vergleich zu 100 km/h um bis zu 30 % erhöhen. Eine reduzierte Geschwindigkeit von 90-100 km/h auf der Autobahn ist daher nicht nur sicherer, sondern auch deutlich umweltfreundlicher. Durch das Fahren im gemäßigten Tempo können Sie erheblich Sprit sparen und gleichzeitig den CO₂-Ausstoß verringern.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorPink,
                    title: 'Vermeidung von Leerlaufzeiten',
                    text: 'Das Laufenlassen des Motors im Leerlauf ist ein unnötiger Energieverbraucher, der sich leicht vermeiden lässt. Bereits nach 30 Sekunden Leerlauf verbraucht der Motor mehr Kraftstoff, als ein Neustart benötigen würde. Es ist daher sinnvoll, den Motor auszuschalten, wenn Sie absehen können, dass Sie länger stehen, zum Beispiel bei längeren Ampelphasen oder im Stau. Moderne Start-Stopp-Systeme übernehmen diese Funktion automatisch, aber auch bei älteren Fahrzeugen lohnt es sich, den Motor manuell auszuschalten, um den Kraftstoffverbrauch und damit die Umweltbelastung zu reduzieren.',
                    containerColor: mycolorBackground
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Detail_Analytics_Wear extends StatelessWidget {
  const Detail_Analytics_Wear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Verschleißprävention         ',
            style: TextStyle(color: Colors.white), // Schriftfarbe des Titels
          ),
        ),
          backgroundColor: mycolorBackground, // Hintergrundfarbe der AppBar
          iconTheme: const IconThemeData(color: const Color.fromRGBO(239, 35, 60, 1)), // Farbe des Zurück-Pfeils
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3, // Höhe auf ein Drittel der Seite beschränken
              child: GraphContainer(
                dataPoints: [
                  FlSpot(0, 701),
                  FlSpot(1, 685),
                  FlSpot(2, 698),
                  FlSpot(3, 711),
                  FlSpot(4, 718),
                  FlSpot(5, 702),
                  FlSpot(6, 723),
                  FlSpot(7, 764),
                ],
                color: mycolorOrange,
                route: '', // Falls der Button aktuell keine Route benötigt
                context: context,
                title: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Das Wichtigste im Überblick',
                    text: ' - Sanftes Beschleunigen\n - Niedriger Drehzahlbereich\n - Vorausschauendes Fahren\n - Angepasste Kurvenfahrten\n - Vermeidung von Kurzstrecken',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Sanftes Beschleunigen',
                    text: 'Rasches und abruptes Beschleunigen verursacht eine erhöhte Belastung auf den Motor und den Antriebsstrang, was den Verschleiß dieser Komponenten deutlich steigert. Durch sanftes Beschleunigen wird nicht nur der Verschleiß reduziert, sondern auch der Kraftstoffverbrauch optimiert. Ein sanfter Druck auf das Gaspedal sorgt dafür, dass der Motor gleichmäßig Leistung aufbaut und so weniger stark beansprucht wird. Besonders bei kaltem Motor sollte auf schonendes Beschleunigen geachtet werden, da in dieser Phase der Schmierfilm im Motor noch nicht vollständig aufgebaut ist.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Niedriger Drehzahlbereich',
                    text: 'Der Betrieb des Motors im optimalen Drehzahlbereich ist entscheidend für die Verschleißprävention. Ein zu hoher Drehzahlbereich führt zu übermäßiger Reibung und Wärmeentwicklung, was den Verschleiß von Kolben, Zylinder und anderen beweglichen Teilen beschleunigt. Optimal ist es, den Motor im Bereich zwischen 1.500 und 2.500 U/min zu halten, da hier die beste Balance zwischen Leistung und Effizienz erreicht wird. Moderne Fahrzeuge verfügen oft über eine Schaltanzeige, die den idealen Zeitpunkt zum Schalten anzeigt, um den Motor zu schonen.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Vorausschauendes Fahren',
                    text: 'Vorausschauendes Fahren ist eine der effektivsten Methoden, um den Verschleiß des Fahrzeugs zu minimieren. Indem man den Verkehr aufmerksam beobachtet und frühzeitig auf mögliche Hindernisse oder Veränderungen reagiert, lassen sich abrupte Brems- und Lenkmanöver vermeiden. Das schont nicht nur die Bremsen und das Fahrwerk, sondern trägt auch zur allgemeinen Sicherheit im Straßenverkehr bei. Ein gleichmäßiger und fließender Fahrstil sorgt dafür, dass das Fahrzeug weniger stark belastet wird und die Komponenten länger halten.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Angepasste Kurvenfahrten',
                    text: 'Zu schnelles und aggressives Fahren in Kurven erhöht den Verschleiß an Reifen und Fahrwerk erheblich. Die Reifen werden bei hohen Querkräften stark beansprucht, was zu ungleichmäßigem Abrieb und vorzeitigem Verschleiß führen kann. Zudem werden die Stoßdämpfer und die Radaufhängung stark belastet, was die Lebensdauer dieser Bauteile verkürzt. Durch langsames und kontrolliertes Fahren in Kurven kann dieser Verschleiß deutlich reduziert werden. Besonders in engen Kurven oder bei Nässe sollte die Geschwindigkeit angepasst werden, um die Belastung auf das Fahrzeug zu minimieren.',
                    containerColor: mycolorBackground
                  ),
                  buildTextContainer(
                    titleColor: mycolorOrange,
                    title: 'Vermeidung von Kurzstrecken',
                    text: 'Kurzstreckenfahrten sind besonders schädlich für den Motor, da dieser oft nicht die Betriebstemperatur erreicht, die für eine optimale Schmierung notwendig ist. Dies führt zu erhöhtem Verschleiß im Motor und im Abgassystem, da Kondenswasser nicht vollständig verdampft und sich Ablagerungen bilden können. Zudem leidet die Batterie, da sie bei Kurzstreckenfahrten nicht ausreichend aufgeladen wird. Um diesen Verschleiß zu minimieren, sollte man möglichst mehrere kurze Fahrten zu einer längeren zusammenfassen oder, wenn möglich, alternative Transportmittel nutzen.',
                    containerColor: mycolorBackground
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}