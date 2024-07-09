import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'media_service.dart';

class MediaServiceImp implements MediaService {
  ImagePicker get picker => ImagePicker();

  @override
  Future<FileImage?> uploadImageFromCamera() async {
    final xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      return FileImage(File(xFile.path));
    }
    return null;
  }

  @override
  Future<FileImage?> uploadPicture() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return FileImage(File(xFile.path));
    }
    return null;
  }

  @override
  Future<File?> uploadVideo() async {
    final xFile = await picker.pickVideo(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  }

  @override
  Future<File?> uploadVideoFromCamera() async {
    final xFile = await picker.pickVideo(source: ImageSource.camera);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  }
}
