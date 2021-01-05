/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2021-01-04 18:05:33
 */
/*
 * @Descripttion: 巴拉树-领取红包页面
 * @Author: huangzuyan
 * @Date: 2021-01-04 09:22:59
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:flutter_test_app/util/widget_utils.dart';

class RedEnvelopePage extends StatefulWidget {
  RedEnvelopePage({Key key}) : super(key: key);

  @override
  _RedEnvelopePageState createState() => _RedEnvelopePageState();
}

class _RedEnvelopePageState extends State<RedEnvelopePage> with TickerProviderStateMixin {
  //动画控制器 scaleController：缩放动画 slideController：平移动画 lineController: 白线动画 flipController: 开红包动画
  AnimationController scaleController, slideController, lineController, flipController;
  Animation scaleAnimation, slideAnimation, lineAnimation, flipAnimation;
  // 是否点击了打开红包
  bool isClickOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AnimationController controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    scaleController = slideController = controller;
    lineController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    flipController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    scaleController.addStatusListener((status) {
      // debugPrint('当前动画状态status===$status');
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        scaleController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态=
        scaleController.forward();
      }
    });
    
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    lineController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        lineController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        lineController.forward();
      }
    });
    slideController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        slideController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        slideController.forward();
      }
    });
    
    flipAnimation = Tween(
      begin: 0.0,
      end: math.pi / 2,
    ).animate(
      // 即延时0.51*动画时长(3000)秒执行
      CurvedAnimation(
        parent: flipController,
        curve: Interval(0.0, 0.5),
      ),
    );
    scaleAnimation = Tween(begin:141.0, end:160.0).animate(scaleController)..addListener(() {
      setState(() {});
    });
    lineAnimation = Tween(begin: Offset(-0.2, 0.2), end: Offset(0.4, 3.2)).animate(lineController);
    //begin: Offset.zero, end: Offset(1, 1) 以左下角为参考点，相对于左下角坐标 x轴方向向右 平移执行动画的view 的1倍 宽度，y轴方向 向下 平衡执行动画view 的1倍的高度，也就是向右下角平移了
    slideAnimation = Tween(begin: Offset(-0.2, -0.2), end: Offset(0.1, 0.1)).animate(slideController);

    //开始执行动画
    scaleController.forward();
    lineController.forward();
    slideController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scaleController.dispose();
    lineController.dispose();
    slideController.dispose();
    flipController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF7E3),
      body: Stack(
        children: [
          // 背景图
          Container(
            height: ScreenUtil().setWidth(832),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/hb_beijing.png"),
                fit: BoxFit.cover
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight((44 + MediaQuery.of(context).padding.top)*2), 0, 0),
              child: Column(
                children: [
                  // 红包
                  _redPackgeWidget(),
                  // 活动说明
                  _activityTipsWidget()
                ],
              ),
            ),
          ),
          // 导航
          _navibarWidget(context),
        ],
      ),
    );
  }

  // 红包部分
  Container _redPackgeWidget() {
    return Container(
      // width: 333,
      // height: 368,
      width: ScreenUtil().setWidth(666),
      height: ScreenUtil().setWidth(736),
      margin: EdgeInsets.only(top: 18),
      decoration: BoxDecoration(
        // 红包底层
        image: DecorationImage(
          image: AssetImage("assets/images/hb_diceng.png"),
          fit: BoxFit.cover
        )
      ),
      child: GestureDetector(
        onTap: (){
          if(isClickOpen) return;
          flipController.forward();
          setState(() {
            isClickOpen = true;
          });
        },
        child: Stack(
          children: [
            // 红包上层
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(24)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform(
                    // 定点从哪个位置打开红包 Alignment.topCenter
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateX(flipAnimation.value),
                    child: Container(
                      // width: 305,
                      // height: 230,
                      width: ScreenUtil().setWidth(610),
                      height: ScreenUtil().setWidth(460),
                      child: Image.asset('assets/images/hb_shangceng.png', fit: BoxFit.cover,)
                    ),
                  ),
                ),
              ),
            ),
            // 开红包图片
            Visibility(
              visible: !isClickOpen,
              child: Align(
                alignment: Alignment(0, 0.3),
                child: Container(
                  // width: 141,
                  // height: 150,
                  width: scaleAnimation.value,
                  height: scaleAnimation.value,
                  child: Image.asset('assets/images/hb_button_kai.png', fit: BoxFit.cover,)
                ),
              ),
            ),
            // 开按钮面的白色动画
            Visibility(
              visible: !isClickOpen,
              child: Align(
                alignment: Alignment(-0.1, 0.0),
                child: SlideTransition(
                  position: lineAnimation,
                  child: Transform.rotate(
                    angle: -math.pi/5,
                    child: Container(
                      width: 120,
                      height: 24,
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            height: 8,
                            color: Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          SizedBox(height: 4),
                          Container(
                            width: 90,
                            height: 8,
                            color: Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 开红包手指图片
            Visibility(
              visible: !isClickOpen,
              child: Align(
                alignment: FractionalOffset(0.9, 0.9),
                child: SlideTransition(
                  position: slideAnimation,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/hb_shouzhi.png', fit: BoxFit.cover,)
                  ),
                ),
              ),
            ),
            // 红包中奖后样式
            _winningWidget(),
            // 红包未中奖样式
            _notWinningWidget(),
          ],
        ),
      ),
    );
  }

   // 中奖后文案样式
  Visibility _winningWidget() {
    return Visibility(
      visible: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenUtil().setWidth(60), 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 1,
                          color: Color(0xFFCD8862),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: getTextWidget(16, '恭喜您获得现金红包', textColor: Color(0xFFCD8862)),
                        ),
                        Container(
                          width: 20,
                          height: 1,
                          color: Color(0xFFCD8862),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setWidth(124),
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(110)),
                    child: getPriceWidget(60, 100.58, Color(0xFFF43333), dollarFontSize: 34)
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(24)),
                    child: getTextWidget(12, '红包现金已发放至', textColor: Color(0xFFFFFFFF)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(48)),
                    child:getTextWidget(16, '奖励中心>我的收益', textColor: Color(0xFFFCF295)),
                  ),
                  Container(
                    height: ScreenUtil().setWidth(88),
                    width: ScreenUtil().setWidth(490) ,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFCE787),
                          Color(0xFFFFC33C),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(22)
                    ),
                    child: getTextWidget(16, '去查看', textColor: Color(0xFFF43333), fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(40)),
              child: getTextWidget(12, '*本周抽奖资格已使用，请下周继续', textColor: Color.fromRGBO(255, 255, 255, 0.7)),
            )
          ],
        ),
      ),
    );
  }

  // 未中奖后文案样式
  Visibility _notWinningWidget() {
    return Visibility(
      visible: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(80)),
                child: getTextWidget(20, '你长得太好看，红包害羞躲起来了，下周再来哦~', textColor: Color(0xFFF43333), textAlign: TextAlign.center),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(40)),
              child: getTextWidget(12, '*本周抽奖资格已使用，请下周继续',textColor: Color.fromRGBO(255, 255, 255, 0.7)),
            )
          ],
        ),
      ),
    );
  }

  // 活动说明
  Container _activityTipsWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 14, 0.0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/hb_zs_zuo.png', width: 14, height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Text(
                    '活动说明',
                    style: TextStyle(
                      fontSize: 16,
                      color:  Color(0xFF713510)
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: -math.pi,
                  child: Image.asset('assets/images/hb_zs_zuo.png', width: 14, height: 10,),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '1.用户每自然周可参与一次随机现金红包抽奖；\n2.抽取后本自然周内不可再次参与，下一自然周可继续参与；\n3.抽中现金红包后，按抽中金额直接发放至"我的收益"，用户可进行提现；\n4.所有利用平台漏洞的恶意抽奖行为所得将被取消资格，并将承担法律责任；',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF713510),
                height: 1.5
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
            alignment: Alignment.center,
            child: Text(
              '最终解释权归平台所有',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(113, 53, 16, 0.3)
              ),
            )
          )
        ],
      ),
    );
  }

  // 导航栏
  Container _navibarWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: 44 + MediaQuery.of(context).padding.top,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              '用户红包抽奖活动',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          // 返回按钮
          Container(
            height: 44,
            width: 36,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Container(
                width: 24,
                height: 24,
                child: Image.asset("assets/images/back_white.png", fit: BoxFit.cover),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ),
        ],
      ),
    );
  }
}