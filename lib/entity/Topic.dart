import 'package:json_annotation/json_annotation.dart';
import 'Node.dart';
import 'Member.dart';

part 'Topic.g.dart';

@JsonSerializable()
class Topic extends Object {
  Node node;
  Member member;
  @JsonKey(name: "last_reply_by")
  String lastReplyBy;
  @JsonKey(name: "last_touched")
  int lastTouched;
  String title;
  String url;
  int created;
  String content;
  @JsonKey(name: "content_rendered")
  String contentRendered;
  @JsonKey(name: "last_modified")
  int lastModified;
  int replies;
  int id;

  ///html解析
  bool isTopic; //是主题还是最近的回复
  String lastReplyTimeName; //最后回复的日期和事件
  String replyTitle; //回复的标题
  String replyContent; //回复的内容
  String replyTime;
  String replyMemberId;

  Topic({
    this.node,
    this.member,
    this.lastReplyBy,
    this.lastTouched,
    this.title,
    this.url,
    this.created,
    this.content,
    this.contentRendered,
    this.lastModified,
    this.replies,
    this.id,
    this.isTopic,
    this.lastReplyTimeName,
    this.replyTitle,
    this.replyContent,
    this.replyTime,
    this.replyMemberId,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
