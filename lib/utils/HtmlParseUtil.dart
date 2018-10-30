import 'package:html/dom.dart' as MyDom;
import 'package:html/parser.dart' as MyParse;

import 'package:v2ex/entity/UserInfo.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/entity/Member.dart';
import 'package:v2ex/entity/Node.dart';

class HtmlParseUtil {
  ///解析用户页面
  parseUserInfo(String data, {UserInfo userInfo}) {
    if (userInfo == null) {
      userInfo = UserInfo();
    }
    var document = MyParse.parse(data);
    var nodes = document.body.nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["id"];
        if (attribute == "Wrapper") {
          _parseWrapper(userInfo, node);
          break;
        }
      }
    }
    return userInfo;
  }

  void _parseWrapper(UserInfo userInfo, MyDom.Element node) {
    print("parseWrapper");
    var nodes = node.nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute == "content") {
          _parseContent(userInfo, node);
          break;
        }
      }
    }
  }

  void _parseContent(UserInfo userInfo, MyDom.Element node) {
    print("parseContent");
    var nodes = node.nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["id"];
        if (attribute == "Main") {
          _parseMain(userInfo, node);
          break;
        }
      }
    }
  }

  void _parseMain(UserInfo userInfo, MyDom.Element node) {
    print("_parseMain");

    var nodes = node.nodes;

    ///解析用户加入时间
    _parseJoinDes(userInfo, nodes[3]);

    ///解析用户主题
    _parseTopics(userInfo, nodes[7]);

    ///解析回复
    _parseReplys(userInfo, nodes[11]);
  }

  void _parseJoinDes(UserInfo userInfo, MyDom.Element node) {
    print("_parseJoinDes");
    var nodes = node.nodes;
    bool isFind = false;
    for (int i = 0; i < nodes.length; i++) {
      if (isFind) break;
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute == "cell") {
          var nodes = node.nodes[1].nodes[1].nodes[0].nodes[5].nodes;
          for (int i = 0; i < nodes.length; i++) {
            var node = nodes[i];
            if (node is MyDom.Element) {
              var attribute = node.attributes["class"];
              if (attribute == "gray") {
                userInfo.member.joinDes = node.nodes[0].text;
                isFind = true;
                break;
              }
            }
          }
        }
      }
    }
  }

  void _parseTopics(UserInfo userInfo, MyDom.Element node) {
    print("_parseTopics");
    var nodes = node.nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute == "cell item") {
          _parseTopicItem(userInfo, node.nodes[1].nodes[1].nodes[0]);
        }
      }
    }
  }

  void _parseTopicItem(UserInfo userInfo, MyDom.Element node) {
    print("_parseTopicItem");

    Topic topic = Topic();
    topic.isTopic = true;
    var nodes = node.nodes;
    for (var tempNode in nodes[1].nodes) {
      if (tempNode is MyDom.Element) {
        var attribute = tempNode.attributes["class"];
        if (attribute == "item_title") {
          topic.title = tempNode.nodes[0].nodes[0].text;
        } else if (attribute == "topic_info") {
          String replyTime = "";
          String replyName = "";
          //长度大于5才有最后回复
          if (tempNode.nodes.length >= 5) {
            replyTime = tempNode.nodes[4].text.replaceFirst("  •  ", "");
            replyName = tempNode.nodes[5].nodes[0].nodes[0].text;
          }
          topic.lastReplyTimeName = replyTime + replyName;
        }
      }
    }
    try {
      topic.replies = int.parse(nodes[3].nodes[1].nodes[0].text);
    } catch (e) {
      topic.replies = 0;
    }
    userInfo.topics.add(topic);
  }

  void _parseReplys(UserInfo userInfo, MyDom.Element node) {
    print("_parseReplys");

    var nodes = node.nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute == "dock_area") {
          _parseReplyItem(
            userInfo,
            node.nodes[1].nodes[1].nodes[0].nodes[1],
            nodes[i + 2].nodes[1],
          );
        }
      }
    }
  }

  void _parseReplyItem(
      UserInfo userInfo, MyDom.Element node, MyDom.Element replyContentNode) {
    print("_parseReplyItem");

    Topic topic = Topic();
    topic.isTopic = false;
    var replyToName = node.nodes[1].nodes[1].nodes[0].text;
    var replyToTopicTitle = node.nodes[1].nodes[9].nodes[0].text;
    topic.replyTime = node.nodes[0].nodes[0].nodes[0].text;

    var replyContent = "";
    for (var tempNode in replyContentNode.nodes) {
      if (tempNode is MyDom.Text) {
        replyContent = replyContent + tempNode.text;
      } else if (tempNode is MyDom.Element) {
        var tempText;
        if (tempNode.nodes.length == 0) {
          //换行
          tempText = "\n";
        } else {
          ///todo @人了点击跳转
          tempText = tempNode.nodes[0].text;
        }
        replyContent = replyContent + tempText;
      }
    }
    topic.replyContent = replyContent;
    topic.replyTitle =
        "回复了$replyToName创建的主题›$replyToTopicTitle".replaceAll(" ", "");
    userInfo.topics.add(topic);
  }

  ///分割线------------------------------------------------------------------------
  ///解析tab主题列表
  parseTabTopics(String data, {List<Topic> topics}) {
    print("parseTabTopics");
    if (topics == null) {
      topics = List();
    }
    var document = MyParse.parse(data);
    var nodes = document.body.nodes[3].nodes[1].nodes[5].nodes[3].nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute == "cell item") {
          _parseTopic(topics, node.nodes[1].nodes[1].nodes[0]);
        }
      }
    }
    return topics;
  }

  void _parseTopic(List<Topic> topics, MyDom.Element node) {
    print("_parseTopic");
    Topic topic = Topic();
    _parseMember(topic, node.nodes[1].nodes[0]);
    _parseNode(topic, node.nodes[5].nodes[4]);

    String topicUrl = node.nodes[5].nodes[0].nodes[0].attributes["href"];
    topic.title = node.nodes[5].nodes[0].nodes[0].nodes[0].text;
    try {
      topic.replyTime = node.nodes[5].nodes[4].nodes[4].text
          .replaceAll(" ", "")
          .replaceAll("最后回复来自", "")
          .replaceAll("•", "");
    } catch (e) {
      topic.replyTime = "";
    }

    try {
      topic.replies = int.parse(node.nodes[7].nodes[1].nodes[0].text);
    } catch (e) {
      topic.replies = 0;
    }

    topics.add(topic);
  }

  void _parseMember(Topic topic, MyDom.Node node) {
    print("_parseMember");
    Member member = Member();
    member.username = node.attributes["href"].replaceAll("/member/", "");
    member.avatarNormal = node.nodes[0].attributes["src"];
    member.avatarLarge = member.avatarNormal;
    member.avatarMini = member.avatarNormal;
    topic.member = member;
  }

  void _parseNode(Topic topic, MyDom.Node nod) {
    print("_parseNode");
    Node node = Node();
    node.title = nod.nodes[1].nodes[0].text;
    node.name = nod.nodes[1].attributes["href"].replaceAll("/go/", "");
    topic.node = node;
  }

  ///分割线------------------------------------------------------------------------
  ///解析node对应节点主题列表
  parseNodeTopics(String data, {List<Topic> topics}) {
    print("parseNodeTopics");
    if (topics == null) {
      topics = List();
    }
    var document = MyParse.parse(data);
    var nodes =
        document.body.nodes[3].nodes[1].nodes[5].nodes[3].nodes[5].nodes;
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is MyDom.Element) {
        var attribute = node.attributes["class"];
        if (attribute != null && attribute.contains("cell from")) {
          _parseNodeTopic(topics, node);
        }
      }
    }
    return topics;
  }

  void _parseNodeTopic(List<Topic> topics, MyDom.Element node) {
    print("_parseNodeTopic");
    Topic topic = Topic();
    MyDom.Element topicNode = node.nodes[1].nodes[1].nodes[0];

    MyDom.Element memberNode =
        node.nodes[1].nodes[1].nodes[0].nodes[1].nodes[0];
    Member member = Member();
    member.username = memberNode.attributes["href"].replaceAll("/member/", "");
    member.avatarNormal = memberNode.nodes[0].attributes["src"];
    member.avatarMini = member.avatarNormal;
    member.avatarLarge = member.avatarNormal;
    topic.member = member;

    topic.title = topicNode.nodes[5].nodes[0].nodes[0].nodes[0].text;
    try {
      topic.replies = int.parse(topicNode.nodes[7].nodes[1].nodes[0].text);
    } catch (e) {}
    topics.add(topic);
  }
}
