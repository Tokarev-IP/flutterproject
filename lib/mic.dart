import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophoneScreen extends StatefulWidget {
  const MicrophoneScreen({super.key});

  @override
  _MicrophoneScreen createState() => _MicrophoneScreen();
}

class _MicrophoneScreen extends State<MicrophoneScreen> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  double _amplitude = 0.0;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder!.openRecorder();
    _recorder!.setSubscriptionDuration(const Duration(milliseconds: 100));
    _recorder!.onProgress!.listen((e) {
      setState(() {
        _amplitude = e.decibels ?? 0.0;
      });
    });
  }

  Future<void> _toggleRecording() async {
    if (_recorder!.isStopped) {
      await _recorder!.startRecorder(toFile: 'audio.mp4');
      setState(() {
        _isRecording = true;
      });
    } else {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _toggleRecording,
              child: Text(_isRecording ? 'Stop' : 'Start'),
            ),
            SizedBox(height: 20),
            Text('Amplitude: $_amplitude dB'),
          ],
        ),
      ),
    );
  }
}