import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadReceiptScreen extends StatefulWidget {
  @override
  State<UploadReceiptScreen> createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
  File? image;

  final picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });

      print("📸 IMAGE SELECTED: ${picked.path}");
    }
  }

  Future uploadToServer() async {
    if (image == null) return;

    print(" UPLOADING RECEIPT TO BACKEND...");
    print("FILE PATH: ${image!.path}");

    // Later: Multipart upload via Dio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Receipt")),

      body: Column(
        children: [
          SizedBox(height: 20),

          image != null
              ? Image.file(image!, height: 200)
              : Text("No Image Selected"),

          SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () => pickImage(ImageSource.camera),
            icon: Icon(Icons.camera),
            label: Text("Camera"),
          ),

          ElevatedButton.icon(
            onPressed: () => pickImage(ImageSource.gallery),
            icon: Icon(Icons.image),
            label: Text("Gallery"),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: uploadToServer,
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
