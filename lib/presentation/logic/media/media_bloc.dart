import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/repositories/media/media_repository.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc(this._mediaService) : super(MediaInitial()) {
    on<UploadPictureFromCameraEvent>(_mapOnUploadPictureFromCameraEventToState);
    on<UploadPictureFromGalleryEvent>(
        _mapOnUploadPictureFromGalleryEventToState);
    on<UploadVideoFromCameraEvent>(_mapOnUploadVideoFromCameraEventToState);
    on<UploadVideoFromGalleryEvent>(_mapOnUploadVideoFromGalleryEventToState);
  }

  final MediaRepository _mediaService;

  FutureOr<void> _mapOnUploadPictureFromCameraEventToState(
      UploadPictureFromCameraEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final fileImage = await _mediaService.uploadImageFromCamera();
      emit(PhotoLoaded(fileImage: fileImage));
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }

  FutureOr<void> _mapOnUploadPictureFromGalleryEventToState(
      UploadPictureFromGalleryEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final fileImage = await _mediaService.uploadPicture();
      emit(PhotoLoaded(fileImage: fileImage));
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }

  FutureOr<void> _mapOnUploadVideoFromCameraEventToState(
      UploadVideoFromCameraEvent event, Emitter<MediaState> emit) {}

  FutureOr<void> _mapOnUploadVideoFromGalleryEventToState(
      UploadVideoFromGalleryEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final file = await _mediaService.uploadVideo();
      emit(VideoLoaded(file: file));
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }
}
