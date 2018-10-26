// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node(
      avatarLarge: json['avatar_large'] as String,
      name: json['name'] as String,
      avatarNormal: json['avatar_normal'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      topics: json['topics'] as int,
      footer: json['footer'] as String,
      header: json['header'] as String,
      titleAlternative: json['title_alternative'] as String,
      avatarMini: json['avatar_mini'] as String,
      stars: json['stars'] as int,
      root: json['root'] as bool,
      id: json['id'] as int,
      parentNodeName: json['parent_node_name'] as String);
}

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'avatar_large': instance.avatarLarge,
      'name': instance.name,
      'avatar_normal': instance.avatarNormal,
      'title': instance.title,
      'url': instance.url,
      'topics': instance.topics,
      'footer': instance.footer,
      'header': instance.header,
      'title_alternative': instance.titleAlternative,
      'avatar_mini': instance.avatarMini,
      'stars': instance.stars,
      'root': instance.root,
      'id': instance.id,
      'parent_node_name': instance.parentNodeName
    };
