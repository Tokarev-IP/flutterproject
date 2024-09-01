import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiPhotoScreen(),
    );
  }
}

class MultiPhotoScreen extends StatefulWidget {
  @override
  _MultiPhotoScreenState createState() => _MultiPhotoScreenState();
}

class _MultiPhotoScreenState extends State<MultiPhotoScreen> {
  List<XFile>? _imageFiles;

  Future<void> _getImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _imageFiles = pickedFiles;
      } else {
        print('No images are selected.');
      }
    });
  }

  Future<void> saveSquareToGallery(BuildContext context) async {
    final size = 800;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()), paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size, size);
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/blue_square.png';
    final file = File(imagePath);
    await file.writeAsBytes(buffer);

    await GallerySaver.saveImage(imagePath, albumName: 'Flutter');

    final snackBar = SnackBar(content: Text('Sample JPEG saved to gallery'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _imageFiles == null || _imageFiles!.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No images are selected.'),
            SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                saveSquareToGallery(context);
              },
              child: Text('Save a sample JPEG'),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _imageFiles!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.file(File(_imageFiles![index].path)),
                  SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImages,
        tooltip: 'Pick Multiple Images',
        child: Icon(Icons.photo_library),
      ),
    );
  }
}