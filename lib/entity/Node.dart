import 'package:json_annotation/json_annotation.dart';

part 'Node.g.dart';

@JsonSerializable()
class Node extends Object {
  @JsonKey(name: "avatar_large")
  String avatarLarge;
  String name;
  @JsonKey(name: "avatar_normal")
  String avatarNormal;
  String title;
  String url;
  int topics;
  String footer;
  String header;
  @JsonKey(name: "title_alternative")
  String titleAlternative;
  @JsonKey(name: "avatar_mini")
  String avatarMini;
  int stars;
  bool root;
  int id;
  @JsonKey(name: "parent_node_name")
  String parentNodeName;

  Node(
      {this.avatarLarge,
      this.name,
      this.avatarNormal,
      this.title,
      this.url,
      this.topics,
      this.footer,
      this.header,
      this.titleAlternative,
      this.avatarMini,
      this.stars,
      this.root,
      this.id,
      this.parentNodeName});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);
}
