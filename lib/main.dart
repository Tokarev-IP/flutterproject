import 'package:flutter/material.dart';
import 'package:setuproject/bluetooth.dart';
import 'package:setuproject/picture.dart';

import 'file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Main'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  goToRoute(context, const PictureRoute());
                },
                child: const Text('Picture route'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRoute(context, const FileRoute());
                },
                child: const Text('File route'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRoute(context, const BluetoothRoute());
                },
                child: const Text('Bluetooth'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToRoute(
      BuildContext context,
      StatelessWidget route,
      ){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
  }

  void goToRouteState(
      BuildContext context,
      StatefulWidget route,
      ){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }
}

