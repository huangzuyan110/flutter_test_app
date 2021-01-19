/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2021-01-19 11:48:13
 */
/*
 * @Descripttion: 引导加盟生活馆弹窗
 * @Author: huangzuyan
 * @Date: 2020-12-24 13:56:29
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/util/navigator_utils.dart';
import 'package:flutter_test_app/util/shared_preferences_data.dart';
import 'package:flutter_test_app/util/widget_utils.dart';

class BlaLifeHallWidget extends StatefulWidget {
  BlaLifeHallWidget({Key key}) : super(key: key);

  @override
  _BlaLifeHallWidgetState createState() => _BlaLifeHallWidgetState();
}

class _BlaLifeHallWidgetState extends State<BlaLifeHallWidget> with TickerProviderStateMixin {
  var userModel;
  // waveController->宽 fallController->高 fadeController->淡入淡出
  AnimationController waveController, fallController, fadeController;
  Animation waveAnimation, fallAnimation, fadeAnimation;
  // 动画变化
  Curve curve = Curves.easeInOut;
  // 弹窗的高度
  double wrapHeight = 71.0;
  // 是否显示引导加盟生活馆弹窗
  bool isShowDialog = true;
  // 是否显示内容，为了解决放大过程中宽度不够导致的文本溢出
  bool isShowContent = false;
  // 弹窗定位左右距离
  static const POSITION_LEFT = 43 , POSITION_RIGHT = 44;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 检查用户是否关闭了三次
    // _checkUserClose();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double width = MediaQuery.of(context).size.width - (POSITION_LEFT + POSITION_RIGHT);

      AnimationController controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

      fadeController = controller;
      waveController = controller;
      fallController = controller;
      
      fadeAnimation =  Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeController, curve: curve));
      waveAnimation = new Tween(begin:0.0, end: width).animate(CurvedAnimation(parent: waveController, curve: curve))..addListener((){
        setState(() {});
      });
      fallAnimation = new Tween(begin:0.0, end:wrapHeight).animate(CurvedAnimation(parent: fallController, curve: curve))..addListener((){
        setState(() {});
      });

      // 监听动画
      fadeAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // print('动画正向完成');
          setState(() {
            isShowContent = true;
          });
        } else if (status == AnimationStatus.dismissed) {
          // print('动画反向完成');
          setState(() {
            isShowDialog = true;
          });
        }
      });
      
      Future.delayed(Duration(milliseconds: 500), (){
        fadeController.forward();
        waveController.forward();
        fallController.forward();
      });
    });
    
  }

  // 将弹窗信息取出来
  Future<List> loadDialogCache() async{
    List blaLifeHallDataCache = [];
    try {
      String blaLifeHallDataCacheString = await PublicSharedPreferences.publicLoadData('blaLifeHallDataCache', '[]');
      blaLifeHallDataCache = jsonDecode(blaLifeHallDataCacheString);
    } catch (err) {
      debugPrint(err);
    }
    // debugPrint('用户弹窗缓存数据===$blaLifeHallDataCache');
    return blaLifeHallDataCache;
  }

  // 检查用户关闭弹窗次数，并且赋值弹窗是否还能弹窗
  void _checkUserClose() async{
    List blaLifeHallDataCache = await loadDialogCache();
    int memberId = userModel.userInfo["fetchMobileMember"]['id'];
    if(blaLifeHallDataCache.isNotEmpty){
      // 要先找到和当前用户相匹配的那条数据
      int index = blaLifeHallDataCache.indexWhere((note) => note['memberId'] == memberId);

      // 当前用户保存过关闭弹窗数据
      if(index!=-1 && blaLifeHallDataCache[index]['count']>=3){
        setState(() {
          isShowDialog = false;
        });
      }
    }
  }

  // 关闭弹窗 点击左上角关闭按钮可关闭弹窗，累计关闭3次后不再弹出
  void handleCloseDialog() async{
    // 将用户关闭弹窗信息存储起来，和用户memberId对应起来
    List blaLifeHallDataCache = await loadDialogCache();
    int memberId = userModel.userInfo["fetchMobileMember"]['id'];
    if(blaLifeHallDataCache.isEmpty){
      blaLifeHallDataCache.add({
        'memberId': memberId,
        'count': 1 
      });
    }else{
      // 要先找到和当前用户相匹配的那条数据
      int index = blaLifeHallDataCache.indexWhere((note) => note['memberId'] == memberId);
      if(index!=-1){
        blaLifeHallDataCache[index]['count'] = blaLifeHallDataCache[index]['count'] + 1;
      }else{
        blaLifeHallDataCache.add({
          'memberId': memberId,
          'count': 1 
        });
      }
    }
    try {
      // debugPrint('用户保存数据===${ jsonEncode(blaLifeHallDataCache) }');
      PublicSharedPreferences.publicSaveData('blaLifeHallDataCache', jsonEncode(blaLifeHallDataCache), 'string');
    } catch (err) {
      debugPrint(err);
    }
    
    handleAnimationReverse();
  }

  // 方向动画
  void handleAnimationReverse(){
    setState(() {
      isShowContent = false;
      waveController.reverse();
      fallController.reverse();
      fadeController.reverse();
    });
  }

  // 点击“速去”按钮后，缩小并关闭弹窗，后打开生活馆介绍加盟页面；
  void handleJumpVipApplyCurator(){
    handleAnimationReverse();
    Future.delayed(Duration(milliseconds: 1000),(){
      NavigatorUtils.popToRoot(context);
    });
  }

  @override
  void dispose() {
    // fadeController.dispose();
    // waveController.dispose();
    // fallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(waveAnimation==null || fallAnimation==null) return Container();
    return Visibility(
      visible: isShowDialog,
      child: Positioned(
        bottom: ScreenUtil().setHeight(586),
        left: (MediaQuery.of(context).size.width - (POSITION_LEFT + POSITION_RIGHT) - waveAnimation.value) / 2 + POSITION_LEFT,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Container(
            width: waveAnimation.value,
            height: fallAnimation.value,
            child: CustomPaint(
              painter: CustomMenuPanelPainter(),
              child: Stack(
                children: [
                  Visibility(
                    visible: isShowContent,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 0, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/bLa_life_hall_icon.png', width: 52, height: 52,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getTextWidget(14, '想获得更多能量？', textColor: Color(0xFFF87C01)),
                                getTextWidget(12, '成为馆长，能量享不停', textColor: Color(0xFFF87C01))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              handleJumpVipApplyCurator();
                            },
                            child: Container(
                              width: 62,
                              height: 26,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFFF87C01),
                                borderRadius: BorderRadius.circular(13)
                              ),
                              child: getTextWidget(14, '速去', textColor: Color(0xFFFFFFFF)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // handleCloseDialog();
                    },
                    child: Image.asset('assets/images/bLa_life_hall_icon2.png', width: 17, height: 17,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* 绘制带向下三角形的矩形 */
class CustomMenuPanelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // print('绘制带三角形的面板size===$size');
    
    // 向下三角形大小
    double triggleWidth = 12.0;

    Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..invertColors = false;

    // 绘制描边
    Paint borderPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      // ..strokeCap = StrokeCap.round//折线连接处圆滑处理
      ..style = PaintingStyle.stroke
      ..color = Color(0xFFF87C01)
      ..invertColors = false;
    
    // Path shadowPath = Path();
    // // 第1个点, 将起始点从左上角移动到容器中心
    // shadowPath.lineTo(0, 0);
    // shadowPath.lineTo(0, size.height);
    // shadowPath.lineTo(size.width, size.height);
    // shadowPath.lineTo(size.width, 0);

    // // 绘制阴影
    // canvas.drawShadow(shadowPath, Color.fromRGBO(0, 0, 0, 0.5), 8.0, false);
    
    // 绘制填充
    RRect rRect = RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(8));
    canvas.drawRRect(rRect, paint);

    // 矩形描边
    RRect borderRRect = RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(8));
    canvas.drawRRect(borderRRect, borderPaint);

    // 绘制描边三角形
    Path borderTrianglePath = Path();
    borderTrianglePath.moveTo(size.width/2 - triggleWidth, size.height);
    borderTrianglePath.lineTo(size.width/2, size.height + triggleWidth);
    borderTrianglePath.lineTo(size.width/2 + triggleWidth, size.height);
    canvas.drawPath(borderTrianglePath, borderPaint);

    // 绘制填充三角形
    Path trianglePath = Path();
    trianglePath.moveTo(size.width/2 - (triggleWidth-1), size.height-1);
    trianglePath.lineTo(size.width/2, size.height + triggleWidth);
    trianglePath.lineTo(size.width/2 + (triggleWidth-1), size.height-1);
    canvas.drawPath(trianglePath, paint);
  }
 
  //在实际场景中正确利用此回调可以避免重绘开销
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}