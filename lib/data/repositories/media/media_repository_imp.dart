import 'dart:io';
import 'package:flutter/material.dart';

import '../../../domain/repositories/media/media_repository.dart';
import '../../services/media/media_service.dart';

class MediaRepositoryImp implements MediaRepository {
  MediaRepositoryImp(this.mediaService);

  final MediaService mediaService;
  @override
  Future<FileImage?> uploadImageFromCamera() {
    return mediaService.uploadImageFromCamera();
  }

  @override
  Future<FileImage?> uploadPicture() {
    return mediaService.uploadPicture();
  }

  @override
  Future<File?> uploadVideo() {
    return mediaService.uploadVideo();
  }

  @override
  Future<File?> uploadVideoFromCamera() {
    return mediaService.uploadVideoFromCamera();
  }
}
