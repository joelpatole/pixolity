import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixolity/utils/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  }
  print('No image selected');
}

showSnackBar(BuildContext context, content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        selectionColor: Colors.black,
      ),
      elevation: 60,
      backgroundColor: Colors.green,
    ),
  );
}
