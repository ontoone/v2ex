// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
      node: json['node'] == null
          ? null
          : Node.fromJson(json['node'] as Map<String, dynamic>),
      member: json['member'] == null
          ? null
          : Member.fromJson(json['member'] as Map<String, dynamic>),
      lastReplyBy: json['last_reply_by'] as String,
      lastTouched: json['last_touched'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      created: json['created'] as int,
      content: json['content'] as String,
      contentRendered: json['content_rendered'] as String,
      lastModified: json['last_modified'] as int,
      replies: json['replies'] as int,
      id: json['id'] as int);
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'node': instance.node,
      'member': instance.member,
      'last_reply_by': instance.lastReplyBy,
      'last_touched': instance.lastTouched,
      'title': instance.title,
      'url': instance.url,
      'created': instance.created,
      'content': instance.content,
      'content_rendered': instance.contentRendered,
      'last_modified': instance.lastModified,
      'replies': instance.replies,
      'id': instance.id
    };
