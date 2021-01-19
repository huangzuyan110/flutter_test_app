/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2021-01-19 11:49:22
 */
import 'package:flutter/material.dart';
class NavigatorUtils {
  //回到顶部页面
  static popToRoot(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  /// 返回
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static Future<dynamic> pushNext(BuildContext context, Widget nextPage) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextPage));
  }
}
