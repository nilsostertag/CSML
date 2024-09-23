import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class DeviceScreen extends StatelessWidget {
  final BluetoothDevice device;

  const DeviceScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    // Initialisiere den DeviceScreenController
    Get.put(DeviceScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Text(device.id.id),
      ),
      body: DeviceScreenContent(),
    );
  }
}

class DeviceScreenContent extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetX<DeviceScreenController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.findCharacteristicWithELMResponse();
                },
                child: Text('Find ELM Characteristic'),
              ),
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
  final RxList<BluetoothCharacteristic> characteristics = <BluetoothCharacteristic>[].obs;
  BluetoothCharacteristic? _characteristic;
  final RxList<String> messages = <String>[].obs;

  // Methode, um die richtige Characteristic zu finden
  Future<void> findCharacteristicWithELMResponse() async {
    for (var characteristic in characteristics) {
      if (characteristic.properties.write || characteristic.properties.writeWithoutResponse) {
        try {
          await characteristic.write("atz".codeUnits);
          await Future.delayed(Duration(milliseconds: 500));  // Warte auf Antwort
          List<int> response = await characteristic.read();
          String responseString = String.fromCharCodes(response);
          messages.add(characteristic.uuid.toString());
          messages.add(responseString);
          
          if (responseString.contains("ELM")) {
            setCharacteristic(characteristic);
            messages.add("Characteristic found: ${characteristic.uuid}");
            return;
          }
        } catch (e) {
          messages.add("Failed to write to characteristic: ${characteristic.uuid}");
        }
      }
    }
    messages.add("No suitable characteristic found");
  }

  void setCharacteristics(List<BluetoothCharacteristic> chars) {
    characteristics.value = chars;
    if (chars.isNotEmpty) {
      setCharacteristic(chars.first);
    }
  }

  void setCharacteristic(BluetoothCharacteristic characteristic) {
    _characteristic = characteristic;
    print("Selected Characteristic properties: ${_characteristic!.properties}");
    if (_characteristic!.properties.notify || _characteristic!.properties.indicate) {
      _characteristic!.setNotifyValue(true);
      _characteristic!.value.listen((value) {
        messages.add("Received: ${String.fromCharCodes(value)}");
      });
    }
  }

  Future<void> sendMessage(String message) async {
    if (_characteristic != null && message.isNotEmpty) {
      if (_characteristic!.properties.write || _characteristic!.properties.writeWithoutResponse) {
        try {
          await _characteristic!.write(message.codeUnits);
          messages.add("Sent: $message");
        } catch (e) {
          messages.add("Failed to send: $e");
        }
      } else {
        messages.add("Characteristic is not writable");
      }
    }
  }
}