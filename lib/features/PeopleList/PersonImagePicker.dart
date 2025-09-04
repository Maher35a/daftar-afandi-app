import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class PersonImagePicker extends StatelessWidget {
  final String? initialImagePath;
  final Function(String? path) onImagePicked;
  final ValueNotifier<String?> imageNotifier;

  PersonImagePicker({
    super.key,
    this.initialImagePath,
    required this.onImagePicked,
  }) : imageNotifier = ValueNotifier<String?>(initialImagePath);

  Future<bool> requestStoragePermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) return true;
    status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> pickImage(BuildContext context) async {
    bool granted = await requestStoragePermission();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم رفض الإذن بالوصول للصور")),
      );
      return;
    }

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageNotifier.value = image.path;
      onImagePicked(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: imageNotifier,
      builder: (context, value, _) {
        return GestureDetector(
          onTap: () => pickImage(context),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.withOpacity(.2),
            backgroundImage: value != null ? FileImage(File(value)) : null,
            child: value == null
                ? const Icon(Icons.add_a_photo, size: 28, color: Colors.teal)
                : null,
          ),
        );
      },
    );
  }
}
