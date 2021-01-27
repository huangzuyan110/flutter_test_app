
/*
 * @Descripttion: 开邀请函动画
 * @Author: huangzuyan
 * @Date: 2021-01-04 09:22:59
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class AnimatedInvitationLetterPage extends StatefulWidget {
  AnimatedInvitationLetterPage({Key key}) : super(key: key);

  @override
  _AnimatedInvitationLetterPageState createState() => _AnimatedInvitationLetterPageState();
}

class _AnimatedInvitationLetterPageState extends State<AnimatedInvitationLetterPage> with TickerProviderStateMixin {
  //动画控制器 _leftDoorController: 左门动画 _arrowAnimation:信封箭头
  AnimationController _leftDoorController, _rightDoorController, _letterController, _arrowController;
  Animation _leftDoorAnimation, _rightDoorAnimation, _letterAnimation, _arrowAnimation;
  // 是否点击了打开红包
  bool isClickOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _leftDoorController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
      });

    _rightDoorController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        // 开门动画结束之后开始信封出现动画
        if (status == AnimationStatus.completed) {
          //AnimationStatus.completed 动画在结束时停止的状态
          // _rightDoorController?.reverse();
        }
      });

    _letterController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this)..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
      });

    _arrowController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this)
    ..addStatusListener((status) {
      // 开门动画结束之后开始信封出现动画
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        _arrowController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        _arrowController.forward();
      }
    });

    _leftDoorAnimation = Tween(
      begin: 0.0,
      /// 向里打开
      end: -math.pi/2,
    ).animate(
      _leftDoorController,
    );

    _rightDoorAnimation = Tween(
      begin: 0.0,
      /// 向里打开
      end: math.pi/2,
    ).animate(
      _rightDoorController
    );

    _letterAnimation = Tween(
      begin: 0.0,
      /// 向里打开
      end: -math.pi/2,
    ).animate(
      _letterController,
    );

    _arrowAnimation = Tween(begin: 0.0, end: 10.0).animate(_arrowController)..addListener(() { 
      setState(() {});
    });

    _leftDoorController.forward();
    _rightDoorController.forward();
    _arrowController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _leftDoorController?.dispose();
    _rightDoorController?.dispose();
    _letterController?.dispose();
    _arrowController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/images/invite_inner_bg.png'),
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            _leftDoorWidget(),
            _rightDoorWidget(),

            _letterWidget(),

            // 最外层边框
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage('assets/images/invite_border_bg.png'),
                  fit: BoxFit.fill
                )
              ),
            ),

            //返回按钮
            Positioned(
              left: 12,
              top: MediaQuery.of(context).padding.top,
              child: Container(
                height: 32,
                width: 32,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    'assets/images/back_white.png',
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ),
            )
          ],
        ),
      ),
        
    );
  }

  /// 左门
  Visibility _leftDoorWidget(){
    return Visibility(
      visible: true,
      child: Positioned(
        left: 6,
        bottom: 0,
        child: Transform(
          // 定点从哪个位置打开红包 Alignment.topCenter
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(_leftDoorAnimation.value),
          child: Container(
            width: (MediaQuery.of(context).size.width-12)/2,
            height: ScreenUtil().setHeight(1044),
            child: Image.asset('assets/images/invite_door_left.png', fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }
  /// 右门
  Visibility _rightDoorWidget(){
    return Visibility(
      visible: true,
      child: Positioned(
        right: 6,
        bottom: 0,
        child: Transform(
          // 定点从哪个位置打开红包 Alignment.topCenter
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(_rightDoorAnimation.value),
          child: Container(
            width: (MediaQuery.of(context).size.width-12)/2,
            height: ScreenUtil().setHeight(1044),
            child: Image.asset('assets/images/invite_door_right.png', fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }

  /// 信封部分
  Visibility _letterWidget() => Visibility(
    child: Align(
      alignment: Alignment(0.0,0.2),
      child: Container(
        width: 270,
        height: 186,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/invite_letter_outer.png'),
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            // 红包上层
            Visibility(
              visible: true,
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform(
                  // 定点从哪个位置打开红包 Alignment.topCenter
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(_letterAnimation.value),
                  child: Container(
                    height: 168,
                    child: Image.asset('assets/images/invite_letter_up.png', fit: BoxFit.cover,)
                  ),
                ),
              ),
            ),
            // 指引开信封动画
            Visibility(
              visible: !isClickOpen,
              child: Align(
                alignment: Alignment(0.0, -0.05),
                child: Container(
                  width: 14,
                  height: 10,
                  margin: EdgeInsets.only(top: _arrowAnimation.value),
                  child: Image.asset('assets/images/invite_letter_arrow.png', fit: BoxFit.cover,)
                ),
              ),
            ),
            // 开信封图片
            Visibility(
              visible: !isClickOpen,
              child: Align(
                alignment: Alignment(0.0, 1.0),
                child: Container(
                  width: 89,
                  height: 87,
                  child: Image.asset('assets/images/invite_letter_btn.png', fit: BoxFit.cover,)
                ),
              ),
            ),
          ],
        ),
      ),
    )
  );
}