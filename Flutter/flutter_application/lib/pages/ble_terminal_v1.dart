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

  DeviceScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DeviceScreenController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<BluetoothCharacteristic>(
                isExpanded: true,
                value: controller.characteristics.isNotEmpty ? controller.characteristics.first : null,
                onChanged: (BluetoothCharacteristic? newValue) {
                  if (newValue != null) {
                    controller.setCharacteristic(newValue);
                  }
                },
                items: controller.characteristics.map((BluetoothCharacteristic characteristic) {
                  return DropdownMenuItem<BluetoothCharacteristic>(
                    value: characteristic,
                    child: Text(characteristic.uuid.toString()),
                  );
                }).toList(),
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
                decoration: const InputDecoration(
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
                child: const Text('Send'),
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
        print("INCOMING: $value");
        print("INCOMING: ${String.fromCharCodes(value)}");
        messages.add("<-${String.fromCharCodes(value)}");
      });
    }
  }

  Future<void> sendMessage(String message) async {
    if (_characteristic != null && message.isNotEmpty) {
      if (_characteristic!.properties.write || _characteristic!.properties.writeWithoutResponse) {
        try {
          await _characteristic!.write(message.codeUnits);
          print("OUTGOING: $message");
          messages.add("->$message");
        } catch (e) {
          messages.add("Failed to send: $e");
        }
      } else {
        messages.add("Characteristic is not writable");
      }
    }
  }
}