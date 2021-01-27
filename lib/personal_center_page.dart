import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/animated/animated_background_page.dart';
import 'package:flutter_test_app/pages/animated/animated_card_flip_page.dart';
import 'package:flutter_test_app/pages/animated/animated_invitation_letter_page.dart';
import 'package:flutter_test_app/pages/animated/red_envelope_page.dart';
import 'package:flutter_test_app/pages/auto_height_stepper_page.dart';
import 'package:flutter_test_app/pages/auto_width_stepper_page.dart';
import 'package:flutter_test_app/pages/bubble/bubble_demo_page.dart';
import 'package:flutter_test_app/pages/custom_stepper_page.dart';
import 'package:flutter_test_app/pages/custom_left_show_delete_page.dart';
import 'package:flutter_test_app/pages/custom_stepper_new_page.dart';
import 'package:flutter_test_app/pages/frosted_page.dart';
import 'package:flutter_test_app/pages/input_expand_page.dart';
import 'package:flutter_test_app/pages/input_number_page.dart';
import 'package:flutter_test_app/pages/logistics_information_page.dart';
import 'package:flutter_test_app/pages/multiple_click_page.dart';
import 'package:flutter_test_app/pages/paint/paint_page.dart';
import 'package:flutter_test_app/pages/reorderable_list_page.dart';
import 'package:flutter_test_app/pages/reorderable_wrap_page.dart';
import 'package:flutter_test_app/pages/thumb_page.dart';
import 'common/scaffold_page.dart';
import 'pages/animated/animation_page.dart';
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
        child: SingleChildScrollView(
          child: Column(
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
              Container(
                child: OutlineButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AutoWidthStepperPage()));
                  },
                  child: Text('跳转到均分宽度自定义步骤条页面'),
                ),
              ),
              Container(
                child: OutlineButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomStepperPage()));
                  },
                  child: Text('跳转到重写的自定义水平步骤条页面'),
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
              // 跳转到输入框页面
              Container(
                child: OutlineButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InputExpandPage()));
                  },
                  child: Text('跳转到输入框expand为true属性页面'),
                ),
              ),
              // 跳转到画路径页面
              Container(
                child: OutlineButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PaintPage()));
                  },
                  child: Text('跳转到画路径paint页面'),
                ),
              ),
              // 跳转到多次点击出现弹窗页面
              Container(
                child: OutlineButton(
                  onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>MultipleClickPage())),
                  child: Text('跳转到多次点击触发事件页面'),
                ),
              ),
              // 跳转到左滑出现删除的页面
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomLeftShowDeletePage())),
                  child: Text('跳转到自定义的左滑出现删除的页面'),
                ),
              ),
              // 跳转到仿抖音点赞动画页面
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ThumbPage())),
                  child: Text('跳转到仿抖音点赞动画页面'),
                ),
              ),
              // 跳转到气泡弹窗页面
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BubbleDemoPage())),
                  child: Text('跳转到气泡弹窗页面'),
                ),
              ),
              // 跳转到背景动画页面
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AnibatedBackgroundPage())),
                  child: Text('跳转到背景动画页面'),
                ),
              ),
              // 跳转到毛玻璃效果页面
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FrostedPage())),
                  child: Text('跳转到毛玻璃效果页面'),
                ),
              ),
              // 跳转到翻转卡片数字动画
              Container(
                child: MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CurvePage()));
                  },
                  color: Colors.red,
                  child: Text('跳转到翻转(从上到下)卡片数字动画'),
                ),
              ),
              // 跳转到开红包动画
              Container(
                child: MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RedEnvelopePage()));
                  },
                  color: Colors.red,
                  child: Text('跳转到开红包动画'),
                ),
              ), 
              // 跳转拖拽列表重新排序
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ReorderableListPage())),
                  child: Text('跳转拖拽列表重新排序'),
                ),
              ),
              // 跳转拖拽网格图移动
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ReorderableWrapPage())),
                  child: Text('跳转拖拽网格图移动'),
                ),
              ),
              // 跳转到邀请函动画
              Container(
                child: OutlineButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimatedInvitationLetterPage())),
                  child: Text('跳转到邀请函动画'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}