import 'package:json_annotation/json_annotation.dart';

part 'Member.g.dart';

@JsonSerializable()
class Member extends Object {
  String username;
  String website;
  String github;
  String psn;
  @JsonKey(name: "avatar_normal")
  String avatarNormal;
  String bio;
  String url;
  @JsonKey(name: "tagline")
  String tagLine;
  String twitter;
  int created;
  @JsonKey(name: "avatar_large")
  String avatarLarge;
  @JsonKey(name: "avatar_mini")
  String avatarMini;
  String location;
  String btc;
  int id;

  ///本地解析字段
  String joinDes;

  Member({
    this.username,
    this.website,
    this.github,
    this.psn,
    this.avatarNormal,
    this.bio,
    this.url,
    this.tagLine,
    this.twitter,
    this.created,
    this.avatarLarge,
    this.avatarMini,
    this.location,
    this.btc,
    this.id,
    this.joinDes,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
