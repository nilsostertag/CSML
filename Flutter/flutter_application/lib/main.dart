import 'package:flutter/material.dart';
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
        useMaterial3: true,
      ),
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
      appBar: AppBar(title: const Text('BLE Scanner')),
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
                              title: Text(data.device.name),
                              subtitle: Text(data.device.id.id),
                              trailing: Text(data.rssi.toString()),
                              onTap: ()=> controller.connectToDevice(data.device),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No devices found'));
                    }
                  }),
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () => controller.scanDevices(), child: Text('Scan')),
              ],
            ),
          );
        },
      ),
    );
  }
}
