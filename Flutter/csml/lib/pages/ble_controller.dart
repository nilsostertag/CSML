import 'package:csml/pages/ble_terminal_v1.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEController extends GetxController{
  FlutterBlue ble = FlutterBlue.instance;

  Future scanDevices() async{
    if(await Permission.bluetoothScan.request().isGranted) {
      if(await Permission.bluetoothConnect.request().isGranted) {
        ble.startScan(timeout: const Duration(seconds: 10));

        ble.stopScan();
      }
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    //print(device);
    try {
    await device.connect(timeout: Duration(seconds: 15));
    device.state.listen((BluetoothDeviceState state) async {
      if (state == BluetoothDeviceState.connected) {
        print("Device connected: ${device.name} with MAC ${device.id.id}");
        
        // Navigiere zum neuen Screen
        Get.to(() => DeviceScreen(device: device));

        // Erhalte die Characteristics des Geräts
        List<BluetoothService> services = await device.discoverServices();
        List<BluetoothCharacteristic> characteristics = [];
        for (BluetoothService service in services) {
          characteristics.addAll(service.characteristics);
        }
        Get.find<DeviceScreenController>().setCharacteristics(characteristics);
      } else if (state == BluetoothDeviceState.connecting) {
        print("Device connecting to: ${device.name} with MAC ${device.id.id}");
      } else {
        print("Device disconnected.");
      }
    });
  } catch (e) {
    print("Connection error: $e");
  }
  }

Stream<List<ScanResult>> get scanResults => ble.scanResults;

}