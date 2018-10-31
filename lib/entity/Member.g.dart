// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
      username: json['username'] as String,
      website: json['website'] as String,
      github: json['github'] as String,
      psn: json['psn'] as String,
      avatarNormal: json['avatar_normal'] as String,
      bio: json['bio'] as String,
      url: json['url'] as String,
      tagLine: json['tagline'] as String,
      twitter: json['twitter'] as String,
      created: json['created'] as int,
      avatarLarge: json['avatar_large'] as String,
      avatarMini: json['avatar_mini'] as String,
      location: json['location'] as String,
      btc: json['btc'] as String,
      id: json['id'] as int,
      joinDes: json['joinDes'] as String);
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'username': instance.username,
      'website': instance.website,
      'github': instance.github,
      'psn': instance.psn,
      'avatar_normal': instance.avatarNormal,
      'bio': instance.bio,
      'url': instance.url,
      'tagline': instance.tagLine,
      'twitter': instance.twitter,
      'created': instance.created,
      'avatar_large': instance.avatarLarge,
      'avatar_mini': instance.avatarMini,
      'location': instance.location,
      'btc': instance.btc,
      'id': instance.id,
      'joinDes': instance.joinDes
    };
