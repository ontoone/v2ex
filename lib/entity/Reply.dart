import 'package:json_annotation/json_annotation.dart';

import 'Member.dart';

part 'Reply.g.dart';

@JsonSerializable()
class Reply {
  Member member;
  int created;
  @JsonKey(name: "topic_id")
  int topicId;
  String content;
  @JsonKey(name: "content_rendered")
  String contentRendered;
  @JsonKey(name: "last_modified")
  int lastModified;
  @JsonKey(name: "member_id")
  int memberId;
  int id;

  Reply(
      {this.member,
      this.created,
      this.topicId,
      this.content,
      this.contentRendered,
      this.lastModified,
      this.memberId,
      this.id});

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
