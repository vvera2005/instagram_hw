import 'dart:io';

import 'package:flutter/material.dart';

abstract class MediaRepository {
  Future<FileImage?> uploadPicture();
  Future<FileImage?> uploadImageFromCamera();
  Future<File?> uploadVideo();
  Future<File?> uploadVideoFromCamera();
}
