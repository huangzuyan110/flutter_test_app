/*
 * @Author: your name
 * @Date: 2020-08-17 09:55:22
 * @LastEditTime: 2020-08-17 10:38:05
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flutter_test_app/lib/pages/thumb_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/pages/tikTok_favorite_animation_page.dart';

class ThumbPage extends StatefulWidget {
  ThumbPage({Key key}) : super(key: key);

  @override
  _ThumbPageState createState() => _ThumbPageState();
}

class _ThumbPageState extends State<ThumbPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '点赞动画', 
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orange,
        alignment: Alignment.center,
        child: TikTokVideoGesture(
          child: Container(
            width: 100,
            height: 300,
            color: Colors.yellow,
            alignment: Alignment.bottomRight,
            child: Text('dddd'),
          )
        ),
      )
    );
  }
}