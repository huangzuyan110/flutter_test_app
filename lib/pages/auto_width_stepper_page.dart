import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class AutoWidthStepperPage extends StatefulWidget {
  AutoWidthStepperPage({Key key}) : super(key: key);

  @override
  _AutoWidthStepperPageState createState() => _AutoWidthStepperPageState();
}

class _AutoWidthStepperPageState extends State<AutoWidthStepperPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '高度宽度步骤条',
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF55433),
                Color(0xFFF43333)
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12, 12, 12),
                child: Text('待填写退货物流', style: TextStyle(fontSize: 16, color: Color(0xffffffff)),),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 34, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(// 圆和线
                              width: double.infinity,
                              height: 32,
                              child: LeftLineWidget(false, true, true),
                            ),
                            Container(
                              width: 24,
                              child: Text(
                                '申请退货',
                                style: TextStyle(fontSize: 10, color: Color(0xffffffff), letterSpacing:1),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(// 圆和线
                              width: double.infinity,
                              height: 32,
                              child: LeftLineWidget(true, true, true),
                            ),
                            Container(
                              width: 24,
                              child: Text(
                                '审核通过',
                                style: TextStyle(fontSize: 10, color: Color(0xffffffff), letterSpacing:1),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(// 圆和线
                              width: double.infinity,
                              height: 32,
                              child: LeftLineWidget(true, true, false),
                            ),
                            Container(
                              width: 44,
                              child: Text(
                                '退货商品确认',
                                style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Color(0xffffffff), letterSpacing:1),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(// 圆和线
                              width: double.infinity,
                              height: 32,
                              child: LeftLineWidget(true, false, false),
                            ),
                            Container(
                              width: 24,
                              child: Text(
                                '退货成功',
                                style: TextStyle(fontSize: 10, color: Color(0xffffffff), letterSpacing:1),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(left:12),
                      color: Colors.yellow,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftLineWidget extends StatelessWidget {
  final bool showLeft;
  final bool showRight;
  final bool isLight;
  final double circle;
  const LeftLineWidget(this.showLeft, this.showRight, this.isLight, {this.circle=10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 10,
      // height: 32,
      child: CustomPaint(
        painter: LeftLinePainter(showLeft, showRight, isLight, circle: circle),
      ),
    );
  }
}

class LeftLinePainter extends CustomPainter {
  static const Color _lightColor = Color(0xFFFFFFFF);
  static const Color _normalColor = Color(0xFFFBB7AD);
  

  final bool showLeft;
  final bool showRight;
  final bool isLight;
  final double circle;
  const LeftLinePainter(this.showLeft, this.showRight, this.isLight, {this.circle = 10.0});

  @override
  void paint(Canvas canvas, Size size) {
    print('size===$size');
    double lineWidth = 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    
    // 圆圈上面的线（显示灰色还是红色）
    Paint linePain = Paint();
    linePain.color = showLeft ? _lightColor : Colors.transparent;
    linePain.strokeWidth = lineWidth;
    linePain.strokeCap = StrokeCap.square;
    // 将线画在画板上
    canvas.drawLine(Offset(0, centerY), Offset(centerX, centerY), linePain);
    // 圆圈
    Paint circlePaint = Paint();
    circlePaint.color = isLight ? _lightColor : _normalColor;
    circlePaint.style = PaintingStyle.fill;
    // 圆圈下面的先显示灰色还是红色#FFFBB7AD  #FFF43333
    linePain.color = showRight ? _lightColor : Colors.transparent;
    // 将线画在画板上
    canvas.drawLine(Offset(centerX, centerY), Offset(size.width, centerY), linePain);
    // 将圆圈画在画板上
    canvas.drawCircle(Offset(centerX, centerY), circle, circlePaint);
    
    // 画勾 
    Path path = Path();
    // 第1个点, 将起始点从左上角移动到容器中心
    path.moveTo(centerX - circle/2, centerY);
    path.lineTo(centerX-1, centerY + circle/3);
    path.lineTo(centerX + circle/2, centerY-circle/4);
    linePain.color = Color(0xFFF43333);
    linePain.style = PaintingStyle.stroke;
    canvas.drawPath(path, linePain);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}