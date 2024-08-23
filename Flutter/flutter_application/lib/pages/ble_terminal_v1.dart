import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/utils/data_structures.dart';
import 'package:flutter_application/pages/utils/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator_platform_interface/src/models/position.dart' as geo;
import 'package:get/get.dart';
import 'dart:async';
import 'package:number_system/number_system.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  final TextEditingController textController = TextEditingController();
  final TextEditingController driveIdController = TextEditingController(text: '1');
  final TextEditingController uuidController = TextEditingController(text: 'f437137a-0d5b-46f7-b204-8ca4b94177aa');

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
                controller: driveIdController,
                decoration: InputDecoration(
                  labelText: 'Drive-ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Textfeld für UUID mit Default-Wert
              TextField(
                controller: uuidController,
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
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Nachricht',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Sende-Button
              ElevatedButton(
                onPressed: () {
                  controller.sendMessage(textController.text);
                  textController.clear();
                },
                child: Text('Senden'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.gatherData();
                },
                child: const Text("Get Data!"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller._connectWebSocket();
                },
                child: const Text("Connect WS!"),
              ),
              ValueListenableBuilder<bool>(
              valueListenable: controller._isConnected,
              builder: (context, isConnected, child) {
                return Container(
                  width: 100,
                  height: 100,
                  color: isConnected ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(
                      'WS',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              },
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

  static const int _messageFrequency = 1; // Requestfrequenz in Sekunden
  final List<String> target_PIDs = ['010D', '0104', '010C', '0105', '0111', '0145'];
  static const _messageDelay = _messageFrequency * 1000;

  final RxList<String> _temporaryResponses = <String>[].obs;

  WebSocketChannel? _channel;
  final ValueNotifier<bool> _isConnected = ValueNotifier<bool>(false);

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
        messages.add("< $stringifiedResponse");

        if(stringifiedResponse.contains('41')) {
          print("VALID response: $stringifiedResponse");
          _temporaryResponses.add(stringifiedResponse);
          for(int i = 0; i < _temporaryResponses.length; i++) {
            print("$i: ${_temporaryResponses[i]}");
          }
        }

        //print(recordedResponses.length);
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
  
  String extractHexResponse(String hexString) {
    if(hexString != 'None') {
      String result = '';
      print("orig hex ${hexString}");
      print(hexString.length.toString());
      String result_hex = hexString.replaceAll(' ', '').substring(4).trim();
      print("1st hex '${result_hex}'");
      print(result_hex.length.toString());
      print(result);      

      return result_hex;
    }
    return 'None';
  }
  
  Future<void> gatherData() async {
    _temporaryResponses.clear();
    print("clearing temp response collector: size ${_temporaryResponses.length}");
    print("Sending messages");

    await send_messages(target_PIDs);

    String jsonPayload = await extractData(_temporaryResponses);
    
    //Hier stehen geblieben
    //Websocket connection verwenden

    _sendWebsocketMessage(jsonPayload);
    print('message sent wo websocket!!');
  }

  Future<String> extractData(List<String> receivedData) async {
    String jsonString;
    final Map<String, String> dataNodeMap = {
      'speed': 'None',
      'load': 'None',
      'rpm': 'None',
      'cool_temp': 'None',
      'abs_throt_pos': 'None',
      'rel_throt_pos': 'None'
    };
    for(int i = 0; i < receivedData.length; i++) {
      print(i.toString());
      String _buffer_response = receivedData[i];

      if(_buffer_response.contains('41 0D')) {
        print("found speed!");
        dataNodeMap['speed'] = _buffer_response;
      }
      if(_buffer_response.contains('41 04')) {
        dataNodeMap['load'] = _buffer_response;
        print("found load!");
      }
      if(_buffer_response.contains('41 0C')) {
        print("found rpm!");
        dataNodeMap['rpm'] = _buffer_response;
      }
      if(_buffer_response.contains('41 05')) {
        print("found cool_temp!");
        dataNodeMap['cool_temp'] = _buffer_response;
      }
      if(_buffer_response.contains('41 11')) {
        print("found abs_throt_pos!");
        dataNodeMap['abs_throt_pos'] = _buffer_response;
      }
      if(_buffer_response.contains('41 45')) {
        print("found rel_throt_pos!");
        dataNodeMap['rel_throt_pos'] = _buffer_response;
      }
    }

    geo.Position currentPosition = await getLocation();
    print("lat: ${currentPosition.latitude}, long: ${currentPosition.longitude}");

    // Datenstruktur erstellen
    DataStructure dataSet = createDataStructure(
      "f437137a-0d5b-46f7-b204-8ca4b94177aa", //uuid
      "004", //driveid
      currentPosition.latitude.toString(), //lat
      currentPosition.longitude.toString(), //long
      extractHexResponse(dataNodeMap['speed'].toString()), //vehicle speed
      extractHexResponse(dataNodeMap['load'].toString()), //engine load
      extractHexResponse(dataNodeMap['rpm'].toString()), //engine rpm
      extractHexResponse(dataNodeMap['cool_temp'].toString()), //engine coolant temp
      "13.2", //engine fuel consumption
      extractHexResponse(dataNodeMap['abs_throt_pos'].toString()) //throttle position
    );

    jsonString = jsonEncode(dataSet.toJson());
    //print(jsonString);
    return jsonString;
  }

  Future<void> send_messages(List<String> PIDs) async {
    for(int i = 0; i < PIDs.length; i++) {
      await sendMessage(PIDs[i]);
      print("sending ${PIDs[i]}");
      Future.delayed(const Duration(milliseconds: _messageDelay));
    }
  }

  void _connectWebSocket() {
    // Stelle die WebSocket-Verbindung her
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.178.75:1880/data/store_dev'),
    );

    // Setze den Verbindungsstatus auf "verbunden"
    _isConnected.value = true;

    // Schließe die Verbindung bei Fehlern oder wenn der WebSocket geschlossen wird
    _channel?.stream.listen(
      (message) {
        print('Received: $message');
      },
      onDone: () {
        _isConnected.value = false;
      },
      onError: (error) {
        _isConnected.value = false;
        print('Error: $error');
      },
    );
  }

  void _sendWebsocketMessage(String message) {
    if (_channel != null && _isConnected.value) {
      _channel?.sink.add(message);
      print('Sent: $message');
    } else {
      print('Cannot send message. Not connected.');
    }
  }

  //String get recordingButtonText => _isRecording ? "Aufnahme stoppen" : "Aufnahme starten";
}