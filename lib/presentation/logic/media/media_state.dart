part of 'media_bloc.dart';

sealed class MediaState extends Equatable {
  const MediaState({this.fileImage});
  final FileImage? fileImage;

  @override
  List<Object?> get props => [fileImage];
}

final class MediaInitial extends MediaState {}

final class MediaLoading extends MediaState {}

final class MediaFailed extends MediaState {
  const MediaFailed({
    required this.error,
  });
  final String error;

  @override
  List<Object> get props => [error];
}

final class PhotoLoaded extends MediaState {
  const PhotoLoaded({FileImage? fileImage}) : super(fileImage: fileImage);
}

final class VideoLoaded extends MediaState {
  const VideoLoaded({required this.file});
  final File? file;

  @override
  List<Object?> get props => [file];
}
