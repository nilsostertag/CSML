import 'package:csml/pages/ble_controller.dart';
import 'package:csml/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
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