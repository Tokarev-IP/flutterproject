import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  FileScreenState createState() => FileScreenState();
}

class FileScreenState extends State<FileScreen> {
  final TextEditingController textController = TextEditingController();
  String textField = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Write a text here',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String? path = await selectFile();
                  if (path != null) {
                    await readFile(path);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Text was read from the file'),
                      ),
                    );
                  }
                },
                child: const Text('Read a file'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String? path = await selectFileLocation();
                  if (path != null && path.isNotEmpty) {
                    await saveFile(textController.text, '$path/textfile.txt');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Text was saved in a new file'),
                      ),
                    );
                  }
                },
                child: const Text('Save in a new file'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveFile(String text, String filePath) async {
    try {
      final File file = File(filePath);
      await file.writeAsString(text);
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  Future<String?> selectFileLocation() async {
    try {
      String? result = await FilePicker.platform.getDirectoryPath();
      return result;
    } catch (e) {
      print('Error selecting file location: $e');
      return null;
    }
  }

  Future<void> readFile(String path) async {
    try {
      File file = File(path);
      String contents = await file.readAsString();
      setState(() {
        textController.text = contents;
      });
    } catch (e) {
      print('Error reading file: $e');
    }
  }

  Future<String?> selectFile() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if (result != null) {
        return result.files.single.path;
      } else {
        return null;
      }
    } catch (e) {
      print('Error selecting file: $e');
      return null;
    }
  }
}