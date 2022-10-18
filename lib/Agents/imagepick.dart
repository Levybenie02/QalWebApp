import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'glovalVar.dart';

 class PickImages extends StatefulWidget {
  const PickImages({super.key});

  @override
  State<PickImages> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  String imgstring = "";
  
  Future<void> pickImg() async {
    if (!kIsWeb) {
      final ImagePicker picked = ImagePicker();
      XFile? image = await picked.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          imgfile = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picked = ImagePicker();
      XFile? image = await picked.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webimage = f;
          imgfile = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Aucune Image');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
            onTap: () {
              pickImg();
            },
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(228, 82, 6, 1),
              radius: 70,
              child: (imgfile == null)
                  ? CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 231, 227, 225),
                      radius: 68,
                      child: Image.asset(
                        "lib/Images/photo.png",
                        height: 60,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: MemoryImage(webimage),
                      radius: 68,
                      child: null),
            ),
          );
  }
}