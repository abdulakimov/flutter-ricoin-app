import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black,
      padding: const EdgeInsets.all(20),
      content: Text(text),
    ),
  );
}

// upload one image yo cloudinary

// upload one image to cloudinary
Future<String?> uploadImageToCloudinary(File? file) async {
  final cloudinary = CloudinaryPublic("xurshidbey", "g0lhcxxs");

  String? url;
  try {
    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        file!.path,
      ),
    );
    url = response.secureUrl;
  } catch (e) {}
  return url;
}

Future<File?> uploadImage() async {
  File? file;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      ('Fayl tanlanmadi');
    }
  } catch (e) {}
  return file;
}
