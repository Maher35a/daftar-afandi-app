import 'dart:io';
import 'package:flutter/material.dart';
import '../../Models/personClass.dart';
import '../updateperson/UpdatePersonPage.dart';
class PersonTile extends StatelessWidget {
  const PersonTile({super.key, required this.person, required this.index});
  final Person person;
  final int index; // ← أضف هذا


  @override
  Widget build(BuildContext context) {
    final firstLetter = (person.name.isNotEmpty)
        ? person.name.characters.first.toUpperCase()
        : "?";

    const primary = Colors.teal;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _AvatarOrLetter(
          imageUrl: person.imagePath,
          letter: firstLetter,
          color: primary,
        ),
        title: Text(
          person.name,
          textDirection: TextDirection.rtl,
          style:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "المبلغ: ${person.amount} ج.م",
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        trailing: Chip(
          label: Text(
            person.amount.toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpdatePersonPage(
                person: person,
                index: index, // ← مهم جداً تمرره
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AvatarOrLetter extends StatelessWidget {
  const _AvatarOrLetter({
    required this.imageUrl,
    required this.letter,
    required this.color,
  });

  final String? imageUrl;
  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final path = imageUrl?.trim();
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (file.existsSync()) {
        return CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(file), // ✅ محلي
          backgroundColor: color.withOpacity(.1),
        );
      }
    }
    return CircleAvatar(
      radius: 26,
      backgroundColor: color.withOpacity(.2),
      child: Text(
        letter,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}