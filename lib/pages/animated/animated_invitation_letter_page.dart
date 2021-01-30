
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
  //动画控制器 _doorController: 开门动画 _arrowAnimation:信封箭头
  AnimationController _doorController, _letterController, _openLetterController, _arrowController;
  Animation _doorAnimation, _letterAnimation, _openLetterAnimation, _arrowAnimation;
  // isClickOpenLetter:是否点击了打开信封  _isShowLetterUpLayer:是否显示信封上层
  bool isClickOpenLetter = false, _isShowLetterUpLayer = true;

  // 开门动画时长，信封停留时长
  int _doorAnimationTime = 1000, _letterStopTime = 3000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _doorController = AnimationController(duration: Duration(milliseconds: _doorAnimationTime), vsync: this)..addListener(() {
      setState(() {});
    })..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        // 开门动画结束，开始出现信封动画
        _letterController?.forward();
      }
    });

    _letterController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this)..addListener(() {
        // print(_letterAnimation.value.dx);
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画从 controller.forward() 正向执行 结束时会回调此方法
          //出现动画结束，开始执行箭头动画
          _arrowController?.forward();
          // 信封停留_letterStopTime秒后重新开始所有的动画
          Future.delayed(Duration(milliseconds: _letterStopTime), (){
            // 注意，当页面设置了延时去执行动画时，那么要先判断当前页面是否已挂载，如果页面已卸载，不再执行动画
            if(mounted && !isClickOpenLetter){
              _doorController?.reset();
              _letterController?.reset();
              _arrowController?.reset();
            }

            Future.delayed(Duration(milliseconds: 500), (){
              if(mounted && !isClickOpenLetter) _doorController?.forward();
            });
          });
        }
      });

    _openLetterController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this)..addListener(() {
      setState(() {});
    })..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          _isShowLetterUpLayer = false;
        });
      }
    });

    _arrowController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法]
        //将动画重置到开始前的状态
        _arrowController?.reset();
        //开始执行
        _arrowController?.forward();
      } else if (status == AnimationStatus.dismissed) {
       //动画从 controller.reverse() 反向执行 结束时会回调此方法
        // print("status is dismissed");
        //controller.forward();
      } else if (status == AnimationStatus.forward) {
        // print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        // print("status is reverse");
      }
    });

    _doorAnimation = Tween(
      begin: Offset(0.0, 0.0),
      /// 向里打开 (左门， 右门)
      end: Offset(-math.pi/2, math.pi/2),
    ).animate(
      _doorController
    );

    _letterAnimation = Tween(
      begin: Offset(0.0, 0.0),
      end: Offset(271.0, 186.0),
    ).animate(
      _letterController,
    );
    
    _openLetterAnimation = Tween(
      begin: Offset(0.0, 0.0),
      /// 向里打开
      end: Offset(-math.pi/1.2, 280.8),
    ).animate(
      // 动画先快后慢
      CurvedAnimation(parent: _openLetterController, curve: Curves.bounceInOut),
    );

    _arrowAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.0)).animate(_arrowController)..addListener(() {
      setState(() {});
    });

    _doorController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _doorController?.dispose();
    _letterController?.dispose();
    _arrowController?.dispose();
    _openLetterController?.dispose();
    super.dispose();
  }

  /* 触发开信封 */
  void _handleOpenLetter(){
    setState(() {
      isClickOpenLetter = true;
    });
    _openLetterController.forward();
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
            
            // 里面的信纸
            Visibility(
              visible: isClickOpenLetter,
              child: Align(
                alignment: Alignment(0.0, 0.0),
                child: Container(
                  width: 241,
                  height: _openLetterAnimation.value.dy,
                  child: Image.asset('assets/images/invite_letter_inner.png', fit: BoxFit.cover,)
                ),
              ),
            ),

            _letterWidget(),

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
            ..rotateY(_doorAnimation.value.dx),
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
            ..rotateY(_doorAnimation.value.dy),
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
  Align _letterWidget() => Align(
    alignment: Alignment(0.0,0.2),
    child: Container(
      width: _letterAnimation.value.dx,
      height: _letterAnimation.value.dy,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/invite_letter_outer.png'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: [
          // 信封上层
          Visibility(
            visible: _isShowLetterUpLayer,
            child: Align(
              alignment: Alignment.topCenter,
              child: Transform(
                // 定点从哪个位置打开红包 Alignment.topCenter
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateX(_openLetterAnimation.value.dx),
                child: Container(
                  height: 168,
                  child: Image.asset('assets/images/invite_letter_up.png', fit: BoxFit.cover,)
                ),
              ),
            ),
          ),
          // 指引开信封动画
          Visibility(
            visible: !isClickOpenLetter,
            child: Align(
              alignment: Alignment(0.0, -0.05),
              child: SlideTransition(
                position: _arrowAnimation,
                child: Container(
                  width: 14,
                  height: 10,
                  child: Image.asset('assets/images/invite_letter_arrow.png', fit: BoxFit.cover,)
                )
              ),
            ),
          ),
          // 开信封图片
          Visibility(
            visible: !isClickOpenLetter,
            child: GestureDetector(
              onTap: _handleOpenLetter,
              child: Align(
                alignment: Alignment(0.0, 1.0),
                child:Container(
                  width: 89,
                  height: 87,
                  child: Image.asset('assets/images/invite_letter_btn.png', fit: BoxFit.cover,)
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}