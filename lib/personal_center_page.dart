import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/auto_height_stepper_page.dart';
import 'package:flutter_test_app/pages/custom_stepper_new_page.dart';
import 'package:flutter_test_app/pages/input_number_page.dart';
import 'package:flutter_test_app/pages/logistics_information_page.dart';
import 'package:flutter_test_app/pages/stepper_page.dart';
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
            ),
            // 跳转到步骤条页面
            Container(
              child: OutlineButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>StepperPage()));
                },
                child: Text('跳转到重写flutter自带步骤条页面'),
              ),
            ),
            Container(
              child: OutlineButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomStepperNewPage()));
                },
                child: Text('跳转到固定高度自定义步骤条页面'),
              ),
            ),
            Container(
              child: OutlineButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AutoHeightStepperPage()));
                },
                child: Text('跳转到不固定高度自定义步骤条页面'),
              ),
            ),
            // 跳转到输入邀请码交互
            Container(
              child: OutlineButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InputNumberPage()));
                },
                child: Text('跳转到输入邀请码交互页面'),
              ),
            ),
            // 跳转到物流页面
            Container(
              child: OutlineButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LogisticsInformationPage()));
                },
                child: Text('跳转到物流详情页面'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}