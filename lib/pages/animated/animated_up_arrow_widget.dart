/*
 * @Author: your name
 * @Date: 2020-08-18 14:26:25
 * @LastEditTime: 2021-01-04 14:08:57
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flutter_test_app/lib/pages/animated/animated_up_arrow_widget.dart
 */
import 'package:flutter/material.dart';

class AnimatedUpArrowWidget extends StatefulWidget {
  @override
  _AnimatedUpArrowWidgetState createState() => _AnimatedUpArrowWidgetState();
}

class _AnimatedUpArrowWidgetState extends State<AnimatedUpArrowWidget> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1400));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          _animationController.reset();
        });
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedUpArrow(
      animation: _animation,
    );
  }
}

class AnimatedUpArrow extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0);
  final Tween<double> _marginTween = Tween(begin: 0, end: 50);

  AnimatedUpArrow({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);


  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return SafeArea(
      child: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: EdgeInsets.only(bottom: _marginTween.evaluate(animation)),
            child: Image.asset("assets/images/default_tx.png", width: 40, height: 40,),
          ),
        ),
      ),
    );
  }
}