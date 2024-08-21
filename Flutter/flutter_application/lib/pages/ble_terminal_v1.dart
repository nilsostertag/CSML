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
              Obx(() => DropdownButton<BluetoothCharacteristic>(
                isExpanded: true,
                value: controller.selectedCharacteristic.value,
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
              )),
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
  final Rx<BluetoothCharacteristic?> selectedCharacteristic = Rx<BluetoothCharacteristic?>(null);
  final RxList<String> messages = <String>[].obs;

  void setCharacteristics(List<BluetoothCharacteristic> chars) {
    characteristics.value = chars;
    if (chars.isNotEmpty) {
      setCharacteristic(chars.first);
    }
  }

  void setCharacteristic(BluetoothCharacteristic characteristic) {
    selectedCharacteristic.value = characteristic;
    print("Selected Characteristic properties: ${characteristic.properties}");
    if (characteristic.properties.notify || characteristic.properties.indicate) {
      characteristic.setNotifyValue(true);
      characteristic.value.listen((value) {
        messages.add("Received: ${String.fromCharCodes(value)}");
      });
    }
  }

  Future<void> sendMessage(String message) async {
    if (selectedCharacteristic.value != null && message.isNotEmpty) {
      if (selectedCharacteristic.value!.properties.write || selectedCharacteristic.value!.properties.writeWithoutResponse) {
        try {
          await selectedCharacteristic.value!.write(message.codeUnits);
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
