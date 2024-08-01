import 'package:flutter/material.dart';
import 'package:flutter_application/pages/ble_controller.dart';
//import 'package:flutter_application/pages/utils/cards.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override

  //State<HomePage> createState() => _HomePageState();
}
*/
class BLEPage extends StatefulWidget {
  const BLEPage({super.key});

  @override
  State<BLEPage> createState() => _BLEPageState();
}

class _BLEPageState extends State<BLEPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLE Scanner"),
      ),
      body: GetBuilder<BLEController>(
        init: BLEController(),
        builder: (BLEController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults, 
                  builder: ((context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index){
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(data.device.name),
                              subtitle: Text(data.device.id.id),
                              trailing: Text(data.rssi.toString()),
                            ),
                          );
                        });
                    }else {
                      return const Center(child: Text("No Devices Found"),);
                    }
                  })),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: ()=>controller.scanDevices(), child: const Text("Scan")),
              ],
            )
          );
         },),
    );
  }
}

/*
class _HomePageState extends State<HomePage> {
  
  List _menuOptions = [
    ['Mein Fahrzeug', 0xff390099],
    ['Fahrstilanalyse', 0xff9E0059],
    ['Vergangene Fahrten', 0xffFF5400],
    ['Einstellungen', 0xffFFBD00],
    ['Aufzeichnung Starten', 0xffEF233C]
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HOME'),
        backgroundColor: Color(0xff0B090A),
        foregroundColor: Colors.white,
      ),
      //0xff0B090A
      backgroundColor: Color(0xff0B090A),
      body: ListView.builder(
        itemCount: _menuOptions.length,
        itemBuilder: (context, index) {
          return HomeCard(title: _menuOptions[index][0], color: Color(_menuOptions[index][1]));
        }),
    );
  }
}
*/