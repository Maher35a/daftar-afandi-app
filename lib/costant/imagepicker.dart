import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerAvatar extends StatefulWidget {
  final String? imagePath;
  final double radius;
  final ValueChanged<String> onImageSelected;

  const ImagePickerAvatar({
    super.key,
    this.imagePath,
    this.radius = 30,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerAvatar> createState() => _ImagePickerAvatarState();
}

class _ImagePickerAvatarState extends State<ImagePickerAvatar> {
  String? currentPath;

  @override
  void initState() {
    super.initState();
    currentPath = widget.imagePath;
  }

  Future<void> _pickImage(ImageSource source) async {
    // طلب الإذن
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم رفض الإذن بالوصول للصور")),
        );
        return;
      }
    }

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() => currentPath = image.path);
      widget.onImageSelected(image.path);
    }
  }

  void _showPickOptionsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("اختيار من المعرض"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("التقاط صورة بالكاميرا"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPickOptionsDialog,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: Colors.teal.withOpacity(.2),
        backgroundImage:
        currentPath != null ? FileImage(File(currentPath!)) : null,
        child: currentPath == null
            ? const Icon(Icons.add_a_photo, size: 28, color: Colors.teal)
            : null,
      ),
    );
  }
}
