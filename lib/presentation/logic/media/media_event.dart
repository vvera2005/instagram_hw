part of 'media_bloc.dart';

sealed class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class UploadPictureFromGalleryEvent extends MediaEvent {}

class UploadPictureFromCameraEvent extends MediaEvent {}

class UploadVideoFromGalleryEvent extends MediaEvent {}

class UploadVideoFromCameraEvent extends MediaEvent {}
