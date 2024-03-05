import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothRoute extends StatelessWidget {
  const BluetoothRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  BluetoothScreenState createState() => BluetoothScreenState();
}

class BluetoothScreenState extends State<BluetoothScreen> {
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Screen'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Bluetooth'),
            trailing: Switch(
              value: isScanning,
              onChanged: (bool value) {
                setState(() {
                  isScanning = value;
                  if (value) {
                    _startScan();
                  } else {
                    _stopScan();
                  }
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              initialData: [],
              builder: (BuildContext context,
                  AsyncSnapshot<List<ScanResult>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<ScanResult> scanResults = snapshot.data!;

                return ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ScanResult result = scanResults[index];
                    return ListTile(
                      title: Text(result.device.name ?? 'Unknown'),
                      subtitle: Text(result.device.id.toString()),
                      onTap: () {
                        _connectToDevice(result.device);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startScan() {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
  }

  void _stopScan() {
    FlutterBluePlus.stopScan();
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('Connected to ${device.name}');
      // Здесь вы можете выполнить дополнительные действия после успешного подключения
    } catch (e) {
      print('Failed to connect to ${device.name}: $e');
    }
  }
}
