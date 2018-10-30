import 'package:intl/intl.dart';

class DataUtil {
  static String topicTime(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + '天前';
      } else {
        time = diff.inDays.toString() + '天前';
      }
    }
    return time;
  }
}
