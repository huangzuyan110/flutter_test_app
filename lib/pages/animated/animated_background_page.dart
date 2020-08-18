/*
 * @Author: your name
 * @Date: 2020-08-18 10:43:39
 * @LastEditTime: 2020-08-18 15:10:29
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /flutter_test_app/lib/pages/animated/animated_background_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/pages/animated/animated_background.dart';
import 'package:flutter_test_app/pages/particle/particle_widget.dart';

class AnibatedBackgroundPage extends StatefulWidget {
  AnibatedBackgroundPage({Key key}) : super(key: key);

  @override
  _AnibatedBackgroundPageState createState() => _AnibatedBackgroundPageState();
}

class _AnibatedBackgroundPageState extends State<AnibatedBackgroundPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '背景离子动画',
      child:  new Container(
        color: Theme.of(context).primaryColor,
        child: Stack(children: <Widget>[
          Positioned.fill(child: AnimatedBackground()),
          Positioned.fill(child: ParticlesWidget(30)),
          new Center(
            ///防止overFlow的现象
            child: SafeArea(
              ///同时弹出键盘不遮挡
              child: SingleChildScrollView(
                child: new Card(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('测试背景离子动画')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}