import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class DeviceScreen extends StatelessWidget {
  final BluetoothDevice device;

  DeviceScreen({required this.device});

  @override
  Widget build(BuildContext context) {
    // Initialisiere den DeviceScreenController
    Get.put(DeviceScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Device: ${device.name}'),
      ),
      body: DeviceScreenContent(device: device),
    );
  }
}

class DeviceScreenContent extends StatelessWidget {
  final BluetoothDevice device;
  final TextEditingController _textController = TextEditingController();

  DeviceScreenContent({required this.device});

  @override
  Widget build(BuildContext context) {
    return GetX<DeviceScreenController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.messages[index]),
                    );
                  },
                ),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.sendMessage(_textController.text);
                  _textController.clear();
                },
                child: Text('Send'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeviceScreenController extends GetxController {
  BluetoothCharacteristic? _characteristic;
  final RxList<String> messages = <String>[].obs;

  void setCharacteristic(BluetoothCharacteristic characteristic) {
    _characteristic = characteristic;
    _characteristic!.setNotifyValue(true);
    _characteristic!.value.listen((value) {
      messages.add("<-${String.fromCharCodes(value)}");
    });
  }

  Future<void> sendMessage(String message) async {
    if (_characteristic != null && message.isNotEmpty) {
      await _characteristic!.write(message.codeUnits);
      messages.add("->$message");
    }
  }
}