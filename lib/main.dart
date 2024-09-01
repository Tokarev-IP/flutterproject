import 'package:flutter/material.dart';
import 'package:setuproject/bluetooth.dart';
import 'package:setuproject/camera.dart';
import 'package:setuproject/location.dart';
import 'package:setuproject/media.dart';

import 'file.dart';
import 'mic.dart';

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  goToRoute(context, const MediaScreen());
                },
                child: const Text('Media'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRouteState(context, const CameraScreen());
                },
                child: const Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRouteState(context, const FileScreen());
                },
                child: const Text('File'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRouteState(context, const MicrophoneScreen());
                },
                child: const Text('Microphone'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRouteState(context, const BluetoothScreen());
                },
                child: const Text('Bluetooth'),
              ),
              ElevatedButton(
                onPressed: () {
                  goToRouteState(context, const LocationScreen());
                },
                child: const Text('Location'),
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
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  void goToRouteState(
    BuildContext context,
    StatefulWidget route,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }
}