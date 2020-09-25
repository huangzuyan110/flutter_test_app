/* 毛玻璃效果 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class FrostedPage extends StatefulWidget {
  FrostedPage({Key key}) : super(key: key);

  @override
  _FrostedPageState createState() => _FrostedPageState();
}

class _FrostedPageState extends State<FrostedPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '毛玻璃', 
      child: Stack(   //重叠的Stack Widget，实现重贴
        children: <Widget>[
          ConstrainedBox( //约束盒子组件，添加额外的限制条件到 child上。
            constraints: const BoxConstraints.expand(), //限制条件，可扩展的。
            child:Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545738629147&di=22e12a65bbc6c4123ae5596e24dbc5d3&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140309%2F0034034413812339_b.jpg')
          ),
          Center(
            child: ClipRect(  //裁切长方形
              child: BackdropFilter(   //背景滤镜器
                filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0), //图片模糊过滤，横向竖向都设置5.0
                child: Opacity( //透明控件
                  opacity: 0.5,
                  child: Container(// 容器组件
                    width: 500.0,
                    height: 500.0,
                    decoration: BoxDecoration(color:Colors.grey.shade200), //盒子装饰器，进行装饰，设置颜色为灰色
                    child: Center(
                      child: Text(
                        'JSPang',
                        style: Theme.of(context).textTheme.bodyText2, //设置比较酷炫的字体
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )    
        ],
      )
    );
  }
}