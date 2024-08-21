import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/utils/data_structures.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:number_system/number_system.dart';

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
  final TextEditingController _driveIdController = TextEditingController(text: '1');
  final TextEditingController _uuidController = TextEditingController(text: 'f437137a-0d5b-46f7-b204-8ca4b94177aa');

  @override
  Widget build(BuildContext context) {
    return GetX<DeviceScreenController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown für Characteristics
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

              // Textfeld für Drive-ID mit Default-Wert
              TextField(
                controller: _driveIdController,
                decoration: InputDecoration(
                  labelText: 'Drive-ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Textfeld für UUID mit Default-Wert
              TextField(
                controller: _uuidController,
                decoration: InputDecoration(
                  labelText: 'UUID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Nachrichtenanzeige (scrollbare Liste) mit angepasster Textgröße und Zeilenabstand
              Expanded(
                child: ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        controller.messages[index],
                        style: TextStyle(
                          fontSize: 14, // Angepasste Textgröße
                          height: 0.5, // Angepasster Zeilenabstand
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Textfeld für Nachrichten
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nachricht',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Sende-Button
              ElevatedButton(
                onPressed: () {
                  controller.sendMessage(_textController.text);
                  _textController.clear();
                },
                child: Text('Senden'),
              ),
              const SizedBox(height: 10),

              // Zusätzlicher Button (Funktionalität später hinzufügen)
              ElevatedButton(
                onPressed: () {
                  if (controller._isRecording) {
                    controller.stopRecording();
                  } else {
                    controller.startRecording();
                  }
                },
                child: Text(controller.recordingButtonText),
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
  final RxList<String> recordedResponses = <String>[].obs;
  
  List<DataStructure> dataSetRecord = [];

  bool _isRecording = false;
  bool _isSendingList = false;
  Timer? _timer;
  final int _messageFrequency = 1; // Frequenz in Sekunden

  List<String> _target_PIDs = [
    '010D', //speed
    '0104', //load
    '010C', //rpm
    '015A'  //throttle
  ];

  final RxList<String> _temporaryResponses = <String>[].obs;

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
        final stringifiedResponse = String.fromCharCodes(value);
        messages.add("< ${convertToDec(stringifiedResponse)}");
        if (_isRecording) {
          recordedResponses.add(convertToDec(stringifiedResponse));
        }
        if (_isSendingList) {
          _temporaryResponses.add(convertToDec(stringifiedResponse));
        }
      });
    }
  }

  Future<void> sendMessage(String message) async {
    if (selectedCharacteristic.value != null && message.isNotEmpty) {
      if (selectedCharacteristic.value!.properties.write || selectedCharacteristic.value!.properties.writeWithoutResponse) {
        try {
          await selectedCharacteristic.value!.write(message.codeUnits);
          messages.add("> $message");
        } catch (e) {
          messages.add("Failed to send: $e");
        }
      } else {
        messages.add("Characteristic is not writable");
      }
    }
  }

  void startRecording() {
    _isRecording = true;
    update(); // UI aktualisieren
    _timer = Timer.periodic(Duration(seconds: _messageFrequency), (timer) async {
      if (selectedCharacteristic.value != null) {
        //await sendMessage('Test Message ${DateTime.now()}');
      }
    });
  }

  void stopRecording() {
    _isRecording = false;
    update(); // UI aktualisieren
    _timer?.cancel();
  }

  void startSendingList() {
    _isSendingList = true;
    _temporaryResponses.clear(); // Temporäre Liste zurücksetzen
    sendMessagesFromList();
  }

  void stopSendingList() {
    _isSendingList = false;
    update(); // UI aktualisieren
    _timer?.cancel();
  }



  Future<void> sendMessagesFromList() async {
    int index = 0;
    _timer = Timer.periodic(Duration(seconds: _messageFrequency), (timer) async {
      if (!_isSendingList || selectedCharacteristic.value == null) {
        timer.cancel();
        return;
      }
      for (index = 0; index < _target_PIDs.length; index++) {
        await sendMessage(_target_PIDs[index]);
        print(_temporaryResponses);
      }

      // Datenstruktur erstellen
      DataStructure dataSet = createDataStructure(
        "f437137a-0d5b-46f7-b204-8ca4b94177aa", //uuid
        "2", //driveid
        "48.840550", //lat
        "10.068598", //long
        convertToDec(_temporaryResponses[0]), //vehicle speed
        convertToDec(_temporaryResponses[1]), //engine load
        convertToDec(_temporaryResponses[2]), //engine rpm
        "78", //engine coolant temp
        "13.2", //engine fuel consumption
        convertToDec(_temporaryResponses[3]) //throttle position
      );

      dataSetRecord.add(dataSet);
      messages.add(dataSet.toJson().toString());
    });
  }

  String convertToDec(String hexString) {
    List<String> substrings = hexString.split(' ');
    substrings = substrings..removeAt(1);
    substrings = substrings..removeAt(0);

    String result_hex = substrings.join('');
    String result = result_hex.hexToDEC().toString();

    return result;
  }

  String get recordingButtonText => _isRecording ? "Aufnahme stoppen" : "Aufnahme starten";
}