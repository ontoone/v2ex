// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return Reply(
      member: json['member'] == null
          ? null
          : Member.fromJson(json['member'] as Map<String, dynamic>),
      created: json['created'] as int,
      topicId: json['topic_id'] as int,
      content: json['content'] as String,
      contentRendered: json['content_rendered'] as String,
      lastModified: json['last_modified'] as int,
      memberId: json['member_id'] as int,
      id: json['id'] as int);
}

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'member': instance.member,
      'created': instance.created,
      'topic_id': instance.topicId,
      'content': instance.content,
      'content_rendered': instance.contentRendered,
      'last_modified': instance.lastModified,
      'member_id': instance.memberId,
      'id': instance.id
    };
