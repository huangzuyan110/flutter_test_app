import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color hexToColor(String s) {
  // 如果传入的十六进制颜色值不符合要求，返回默认值
  if (s == null ||
      s.length != 7 ||
      int.tryParse(s.substring(1, 7), radix: 16) == null) {
    s = '#999999';
  }

  return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}

void Tologin(BuildContext context) {
  Navigator.pushNamed(context, '/login');
}


Future<bool> showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.red,
      );
    },
  );
}

//弹出联系客服的弹框
void showTipsDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          msg,
          style: TextStyle(
            fontSize: 14,
            color: hexToColor('#333333'),
          ),
        ),
        content: Container(
            margin: EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
            child: Text(
              "请联系电话客服 4008233088",
              style: TextStyle(fontSize: 14, color: hexToColor('#999999')),
            )),
        actions: <Widget>[
          CupertinoButton(
            child: Text("确定"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void ToBangCode(BuildContext context) {
  showCustomDialog(context);
}



/* 处理时间.0 */
String rDate(date) {
  if (date == null) {
    return '-';
  }
  return date.replaceAll('.0', '');
}

/* 字数限制 */
String subStr(str) {
  try {
    dynamic newRunes = str.runes.toList();
    if (newRunes.length > 10) {
      return String.fromCharCodes(newRunes.sublist(0, 10)) + '...';
    } else {
      return str;
    }
  } on Exception catch (e) {
//    LogUtil.v("网络异常，请检查网络连接！");
    return str;
//    NotifyManager.showInfo(context, "网络异常，请检查网络连接！");
  }
}

/* 处理商品规格 */
String joinFormat(str) {
  if (str != null) {
    var v = jsonDecode(str).join(" | ");
    return v;
  } else {
    return "";
  }
}

/* 将时间转换为 00~09 */
String formatTime(int timeNum) {
  return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
}

/* 时间格式化，根据总秒数转换为对应的 hh:mm:ss 格式 */
String constructTime(int seconds) {
  int hour = seconds ~/ 3600;
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;
  return formatTime(minute) + ":" + formatTime(second);
}

/*
    比较两个版本号的大小

    @param ServerNewVersion  服务器指定的版本
    @param  localVersion  本地的版本号
    @return 版本号相等,返回0; 本地版本比服务器版本小 需要更新返回  1 ，如果本地版本比服务器版本大 不需要更新返回 2
 */
int compareVersion(String servernewversion, String localversion) {
  if (servernewversion.isEmpty || servernewversion == null) {
    return 0;
  }
  if (servernewversion == localversion) {
    return 0;
  }
  try {
    int servernewversionInt = int.parse(servernewversion.replaceAll(".", ""));
    int localversionInt = int.parse(localversion.replaceAll(".", ""));
    debugPrint("servernewversionInt" +
        servernewversionInt.toString() +
        "localversionInt" +
        localversionInt.toString());
    if (servernewversionInt > localversionInt) {
      return 1;
    } else {
      return 2;
    }
  } catch (err) {}
  return 0;
}


bool stringIsNotEmpty(var string) {
  if (string != null &&
      string.toString() != null &&
      string.toString().isNotEmpty &&
      string.toString() != "null") {
    return true;
  } else {
    return false;
  }
}

// Future<Void> showLoadingDialog(BuildContext context, Function function) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) {
//       return NetLoadingDialog(
//         dismissDialog: function,
//         loadingText: '加载中...',
//         outsideDismiss: true,
//       );
//     },
//   );
//   return null;
// }

void showCustomDoubleDialog(
    BuildContext context, String content, Function fun) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          "",
          style: TextStyle(fontSize: 14),
        ),
        content: Text(
          content,
          style: TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          CupertinoButton(
            child: Text("确认"),
            onPressed: () {
              if (fun != null) {
                fun();
              }
            },
          ),
        ],
      );
    },
  );
}


String couponNumFormatter(double num){
  if(num % 1 == 0) {
    return num.toInt().toString();
  } else {
    return num.toString();
  }
  // if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
  //   return num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
  //   //小数点后有几位小数
  //   // print( num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
  // }else{
  //   return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
  //   // print( num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
  // }
}