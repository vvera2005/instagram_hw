import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/message_entity.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity {
  MessageModel({
    super.content,
    super.senderId,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
