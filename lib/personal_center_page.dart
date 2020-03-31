import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common/scaffold_page.dart';
import 'pages/animation_page.dart';
import 'pages/bezier_page.dart';
import 'pages/left_scroll_delete_page.dart';

class PersonalCenterPage extends StatefulWidget {
  PersonalCenterPage({Key key}) : super(key: key);

  @override
  _PersonalCenterPageState createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '我的',
      child: Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 50
                ),
                color: Colors.pink,
                child: Text('测试container内容低于最高高度时自适应高度,最高不能超过最大高度'),
              )
            ),
            // 动画按钮
            Container(
              child: MaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AnimationPage()));
                },
                color: Colors.red,
                child: Text('跳转到动画的页面'),
              ),
            ),
            // 贝塞尔曲线
            Container(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BezierGestureWidget()));
                }, 
                color: Colors.yellow,
                child: Text('跳转到绘制贝塞尔曲线页面'),
              ),
            ),
            // 跳转到左滑出现删除
            Container(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LeftScrollDeletePage()));
                }, 
                color: Colors.blue,
                child: Text('跳转到左滑出现删除页面'),
              ),
            )
          ],
        ),
      ),
    );
  }
}