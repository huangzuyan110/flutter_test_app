/*
 * @Descripttion: 翻转数字卡片动画(从上到下翻转)
 * @Author: huangzuyan
 * @Date: 2020-12-31 16:18:26
 */
import 'dart:math';

import 'package:flutter/material.dart';

class CurvePage extends StatefulWidget {
  CurvePage({Key key}) : super(key: key);

  @override
  _CurvePageState createState() => _CurvePageState();
}

class _CurvePageState extends State<CurvePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('翻转卡片'),
      ),
      body: Container(
        child: FlipWidget(),
      ),
    );
  }
}

// 数字卡片
class Pannel extends StatelessWidget {
  final String title;
  Pannel(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.black,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 170.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// 翻转部件
class FlipWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlipWidgetState();
  }
}

class _FlipWidgetState extends State<FlipWidget>
    with SingleTickerProviderStateMixin {
  // 动画总控制器
  AnimationController _controller;
  // 上数字 动画
  Animation<double> _upAnimation;
  // 下数字 动画
  Animation<double> _downAnimation;
  // 是否正序
  bool _isPositiveSequence = false;
  // 当前数值
  int _currentIndex = 9;
  // 下一个数值
  int _nextIndex = 8;

  @override
  void initState() {
    super.initState();
    // 5 秒动画，利用 reset、forward 重复执行
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    // 上数字动画
    // controller总动画比例为 0~1，Interval 参数为该比例。
    // 控制在 0.0~0.5。(即延时0秒执行，并且在动画时长*0.5结束动画)
    _upAnimation = Tween(
      begin: 0.0,
      end: pi / 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5),
      ),
    );
    // 下数字动画
    // controller总动画比例为 0~1，Interval 参数为该比例。
    // 控制在 0.51~1。(即延时0.51*动画时长秒执行)
    _downAnimation = Tween(
      begin: 0.0,
      end: pi / 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.51, 1),
      ),
    );
    // 手动进行 setState，否则动画不执行。
    // 你可以使用 AnimatedContainer 等部件替代
    _controller.addListener(() {
      setState(() {});
    });

    // 动画完成时，添加数字检测，实现动画
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _currentIndex = _nextIndex;
        // 正序则累加，倒序则累减；进行边际控制。
        if (_isPositiveSequence) {
          _nextIndex = _currentIndex + 1;
          if (_nextIndex > 9) {
            _isPositiveSequence = !_isPositiveSequence;
            _currentIndex = 9;
            _nextIndex = 8;
          }
        } else {
          _nextIndex = _nextIndex - 1;
          if (_nextIndex < 0) {
            _isPositiveSequence = !_isPositiveSequence;
            _currentIndex = 0;
            _nextIndex = 1;
          }
        }
        // 重置动画
        _controller.reset();
        // 重新开启动画
        _controller.forward();
        setState(() {});
      }
    });
    // 默认开启动画，也使用 press 效果触发。
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ClipRect 做比例切割，形成图片效果
  Widget _makeUpper(int number) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: Pannel(number.toString()),
      ),
    );
  }

  Widget _makeLower(int number) {
    return ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.5,
        child: Pannel(number.toString()),
      ),
    );
  }

  // 默认隐藏
  Widget uppeer1() {
    return _makeUpper(_nextIndex);
  }

  // 默认展示
  Widget upper2() {
    return Transform(
      alignment: Alignment.bottomCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(_upAnimation.value),
      child: _makeUpper(_currentIndex),
    );
  }

  // 默认展示
  Widget lower1() {
    return _makeLower(_currentIndex);
  }

  // 默认隐藏，角度是垂直于屏幕的，实现下翻效果。
  Widget lower2() {
    return Transform(
      alignment: Alignment.topCenter,
      // // identity：恢复初始状态，也就是4*4的单位矩阵
      // transform: Matrix4.identity()
      transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1) 
        // 设置景深 3D视角
        ..setEntry(3, 2, 0.002) 
        ..rotateX(pi / 2 * 3)
        ..rotateX(_downAnimation.value),
      child: _makeLower(_nextIndex),
    );
  }

  // Stack 堆栈效果
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            uppeer1(),
            upper2(),
          ],
        ),
        Container(
          width: 400.0,
          height: 2.0,
          color: Colors.white,
        ),
        Stack(
          children: <Widget>[
            lower1(),
            lower2(),
          ],
        ),
      ],
    );
  }
}