import 'dart:io';

import 'package:flutter/material.dart';

abstract class MediaService {
  Future<FileImage?> uploadPicture();
  Future<FileImage?> uploadImageFromCamera();
  Future<File?> uploadVideo();
  Future<File?> uploadVideoFromCamera();
}
