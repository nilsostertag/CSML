import 'package:flutter/material.dart';
import 'package:flutter_application/pages/utils/colors.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:flutter_application/pages/ble_controller.dart'; // Stelle sicher, dass der Pfad korrekt ist

void main() {
  // Initialisiere WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisiere den BLEController
  Get.put(BLEController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Verwende GetMaterialApp, um GetX Funktionalitäten zu nutzen
      title: 'CarSenseML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: mycolorBackground, // Hintergrundfarbe der Seite
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Schriftfarbe für den Text
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
          child: Text('BLE Scanner',
          style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: mycolorBackground,
      ),
      body: GetBuilder<BLEController>(
        builder: (BLEController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder<List<ScanResult>>(stream: controller.scanResults, builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length, // itemCount hinzufügen
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(data.device.name, style: const TextStyle(color: Colors.white)),
                              subtitle: Text(data.device.id.id, style: const TextStyle(color: Colors.white)),
                              trailing: Text(data.rssi.toString(), style: const TextStyle(color: Colors.white)),
                              onTap: ()=> controller.connectToDevice(data.device),
                            ),
                            color: mycolorGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No devices found'));
                    }
                  }),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.scanDevices(),
                    child: const Text('Scannen', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mycolorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )
                      ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
