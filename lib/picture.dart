import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureRoute extends StatelessWidget {
  const PictureRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  getLostData();
                },
                child: const Text('Choose a picture'),
              ),
              ElevatedButton(
                onPressed: () {
                  getLostData();
                },
                child: const Text('Choose a video'),
              ),
              ElevatedButton(
                onPressed: () {
                  getLostData();
                },
                child: const Text('Make a photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
    } else {}
  }
}
