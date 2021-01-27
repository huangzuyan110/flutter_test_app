import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/pages/animated/animated_up_arrow_widget.dart';
import 'package:flutter_test_app/pages/animated/custom_gift_widget.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:weather_widget/WeatherWidget.dart';

class AnimationPage extends StatefulWidget {
  AnimationPage({Key key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

// SingleTickerProviderStateMixin
class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {
  Animation<double> _animation;
  Animation<Offset> _transitionAnimation;
  AnimationController _controller;
  AnimationController _numAnimationController;
   // 上下移动动画、左右移动动画
  AnimationController _fallController, _waveController;
  Animation _fallAnimation, _waveAnimation;
  double _randomGiftX, _randomGiftWave, _fallStart, _fallEnd;
  int _randomGiftFallDuration, _randomGiftWaveDuration;
  Curve _waveCurve;
  double _x = 50, _y = 200;
  bool _selected = false;
  double _sum = 100;
  double _amountD = 10;
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    _setRandomData();
    _controller = new AnimationController(duration: const Duration(milliseconds: 2000),vsync: this);
    _numAnimationController = new AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _waveCurve = Curves.easeInOutSine;
    _fallStart = 20;
    _fallEnd = 60 ;
    _fallController = AnimationController(
        vsync: this, duration: Duration(seconds: _randomGiftFallDuration));
    _waveController = AnimationController(
        vsync: this, duration: Duration(seconds: _randomGiftWaveDuration));
    _fallAnimation = Tween(begin: _fallStart, end: _fallEnd)
        .animate(CurvedAnimation(parent: _fallController, curve: Curves.linear));
    _waveAnimation = Tween(
            begin: _randomGiftWaveDuration.isEven
                ? _randomGiftX
                : _randomGiftX + _randomGiftWave,
            end: _randomGiftWaveDuration.isEven
                ? _randomGiftX + _randomGiftWave
                : _randomGiftX)
        .animate(CurvedAnimation(parent: _waveController, curve: _waveCurve));

    _animation = new Tween(begin:50.0, end:100.0).animate(_controller)..addListener((){
      setState(() {});
    });
    // 1.35 = (屏幕宽(375)-小部件宽)/2/小部件宽
    _transitionAnimation = Tween(begin: Offset(-1.35, 0), end: Offset(1.35, 0.0)).animate(_controller);
    _controller.addStatusListener((status) {
      // debugPrint('当前动画状态status===$status');
      switch (status) {
        case AnimationStatus.dismissed:
          _controller.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          // _controller?.reset(); // 重置动画到初始状态
          // _controller?.forward(); // 反向开始执行动画
          _controller?.reverse();
          break;
      }
    });
    _fallAnimation.addListener(() {
      setState(() {
        _y = _fallAnimation.value;
      });
    });
    _waveAnimation.addListener(() {
      setState(() {
        _x = _waveAnimation.value;
      });
    });
    _fallAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _setRandomData();
        _fallController.duration = Duration(seconds: _randomGiftFallDuration);
        _fallAnimation = Tween(begin: 0.0, end: 100.0).animate(
            CurvedAnimation(parent: _fallController, curve: Curves.bounceInOut));

        _waveController.duration = Duration(seconds: _randomGiftFallDuration);
        _waveAnimation = Tween(
            begin: _randomGiftWaveDuration.isEven
              ? _randomGiftX
              : _randomGiftX + _randomGiftWave,
            end: _randomGiftWaveDuration.isEven
              ? _randomGiftX + _randomGiftWave
              : _randomGiftX)
            .animate(CurvedAnimation(parent: _waveController, curve: Curves.easeInOutSine));

        _fallController.reset();
        _fallController.forward();
        _waveController.reset();
        _waveController.repeat(reverse: true);
      }
    });
    _controller.forward(); // 正向开始执行动画
    // // _controller.repeat(); // 重复执行动画
    _numAnimationController.forward();
    _fallController.forward();
    _waveController.repeat(reverse: true);
  }
  @override
  void dispose() {
    _controller.dispose();
    _numAnimationController.dispose();
    _fallController.dispose();
    _waveController.dispose();
    super.dispose();

  }
  // 设置随机数
  _setRandomData() {
    _randomGiftX = _randomGift(poolStart: 30, poolEnd: 220).toDouble();
    _randomGiftWave = _randomGift(poolStart: 20, poolEnd: 110).toDouble();
    _randomGiftFallDuration = _randomGift(poolStart: 10, poolEnd: 60);
    _randomGiftWaveDuration = _randomGift(poolStart: 5, poolEnd: 20);
  }

  int _randomGift({int poolStart, int poolEnd}) {
    Random random = Random();
    return random.nextInt(poolEnd - poolStart + 1) + poolStart;
  }

  void _numProgressAnimation(){
    _amountD = 10;
    _sum += _amountD;
    _numAnimationController.value = 0;
    _numAnimationController.forward();
    setState(() {
      _visible = true;
    });
    Future.delayed(Duration(milliseconds: 1500),(){
      setState(() {
        _visible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '盒子放大动画',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              width: double.infinity,
              color: Colors.green,
              child: Column(
                children: <Widget>[
                  Text('缩放动画：'),
                  Container(
                    height: 180,
                    child:Row(
                      children: <Widget>[
                        Container(
                          width: _animation.value,
                          height:_animation.value,
                          child: FlutterLogo(),
                        ),
                        // ScaleTransition 用于执行缩放动画
                        ScaleTransition(
                          scale:_controller,
                          child: Container(
                            width: 100,
                            height: 50,
                            color: Colors.red,
                          )
                        ),
                      ],
                    )
                  ),
                  
                  Container(
                    child: FadeTransition(
                      opacity: _controller,
                      //将要执行动画的子view
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.pink
                      ),
                    ),
                  ),
                  // SlideTransition 用于执行平移动画
                  SlideTransition(
                    position: _transitionAnimation,
                    child: Container(
                      width: 100,
                      height: 50,
                      color: Colors.red,
                    )
                  )
                ],
              ),
            ),
            Divider(color: Colors.purple,),
            Container(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('点击变换动画'),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _selected = !_selected;
                      });
                    },
                    child: AnimatedContainer(
                      width: _selected ? 120.0 : 100.0,
                      height: _selected ? 100.0 : 120.0,
                      color: _selected ? Colors.red : Colors.blue,
                      alignment: _selected ? Alignment.center : AlignmentDirectional.topCenter,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: FlutterLogo(size: 50),
                    ),
                  )
                ],
              ),
            ),
            Divider(color: Colors.purple,),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed:(){
                      _numProgressAnimation();
                    },
                    child: Text('点击数字变换'),
                  ),
                  Container(
                    width: 190,
                    height: 58,
                    color: Colors.amber,
                    child: AnimatedBuilder(
                      animation: _controller,
                      child: Container(width: 200.0, height: 200.0, color: Colors.green),
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          '${((_sum-_amountD) +  _numAnimationController.value * _amountD).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        );
                      },
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _visible ? 1.0 :0.0,
                    duration: Duration(milliseconds: 1500),
                    child: Text('+$_amountD',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffFF7A00))),
                  )
                ],
              ),
            ),
            Divider(color: Colors.purple,),
            Container(
              color: Colors.green,
              width: double.infinity,
              child:Column(children: <Widget>[
                Text('martix'),
                Container(
                  width:100,
                  height: 60,
                  color: Colors.red,
                  transform: Matrix4.translationValues(100, 0, 0),
                ),
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.blue,
                  transform: Matrix4.rotationZ(math.pi / 6),
                )
              ],)
            ),
            Divider(),
            
            // 插件飘雪花
            Container(
              width: double.infinity,
              height: 400,
              child: Transform.rotate(
                angle: -math.pi,
                child: WeatherWidget(
                  size:Size.infinite,
                  weather:'Snowy',
                  snowConfig:SnowConfig(
                    snowNum: 10
                  )
                ),
              )
            ),
            Divider(),
            // 插件落雨
            Container(
              height: 300,
              child: WeatherWidget(
                size:Size.infinite,
                weather:'Rainy',
                rainConfig:RainConfig(
                  rainNum: 20
                )
              ),
            ),
            Divider(),
            // 自定义礼物飘动动画
            Container(
              width: 300,
              height: 120,
              color: Colors.yellow,
              child: Stack(
                children: <Widget>[
                  CustomWeatherWidget(
                    size:Size.infinite,
                    weather:'Gift',
                    giftConfig:CustomGiftConfig(
                      giftNum: 6,
                      giftSize: ScreenUtil().setWidth(20),
                      giftAreaXStart: 1,
                      giftAreaXEnd: 6,
                      giftAreaYStart: 100,
                      giftAreaYEnd: 0,
                      giftFallSecMin: 2,
                      giftFallSecMax: 5,
                      giftWaveSecMin: 1,
                      giftWaveSecMax: 2,
                      giftWaveRangeMin: 1,
                      giftWaveRangeMax: 20,
                      imgUrls:['gift1.png', 'gift2.png', 'gift3.png', 'gift4.png', 'gift5.png', 'gift6.png', ]
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset('assets/images/default_tx.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40),),
                  )
                ],
              )
            ),
            Divider(),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/bg_nvshen.png")
                )
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedUpArrowWidget(),
                ],
              )
            ),
            Divider(),
            Container(
              width: double.infinity,
              height: 300,
              child: AnimatedBuilder(
                animation: _fallController,
                builder: (BuildContext context, Widget child) {
                  return Container(
                    margin: EdgeInsets.only(left: _x, top: _y),
                    child: Image.asset('assets/images/gift1.png'),
                  );
                },
              ),
            ),
          ]
        )
      )
    );
  }
}