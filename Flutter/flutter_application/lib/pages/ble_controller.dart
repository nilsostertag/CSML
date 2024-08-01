import 'package:flutter_application/pages/ble_terminal.dart';
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
    await device.connect(timeout: Duration(seconds: 15));
    device.state.listen((isConnected) async {
      if(isConnected == BluetoothDeviceState.connecting) {
        print("Device connecting to: ${device.name} with MAC ${device.id.id}");
      }else if(isConnected == BluetoothDeviceState.connected) {
        print("Device connected: ${device.name} with MAC ${device.id.id}");
        
        // Navigiere zum neuen Screen
        Get.to(() => DeviceScreen(device: device));

        // Erhalte die Characteristics des Geräts
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService service in services) {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            // Nehme an, dass du die erste gefundene Characteristic verwendest
            Get.find<DeviceScreenController>().setCharacteristic(characteristic);
            break;
          }
        }
      }else {
        print("Device disconnected.");
      };
    });
  }

Stream<List<ScanResult>> get scanResults => ble.scanResults;

}