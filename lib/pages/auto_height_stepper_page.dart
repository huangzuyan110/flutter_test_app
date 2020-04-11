import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class AutoHeightStepperPage extends StatefulWidget {
  AutoHeightStepperPage({Key key}) : super(key: key);

  @override
  _AutoHeightStepperPageState createState() => _AutoHeightStepperPageState();
}

class _AutoHeightStepperPageState extends State<AutoHeightStepperPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '高度自适应步骤条',
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(// 圆和线
                    height: 32,
                    child: LeftLineWidget(false, true, true),
                  ),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '天天乐超市（限时降价）已取货',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border:Border(left: BorderSide(
                    width: 2,
                    color: Colors.grey
                  ))
                ),
                margin: EdgeInsets.only(left: 23),
                padding: EdgeInsets.fromLTRB(22,0,16,16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('配送员：吴立亮 18888888888'),
                    Text('时间：2018-12-17 09:55:22'),
                    Text('由于天气原因无法准时到达, 如有疑惑请电联。由于天气原因无法准时到达, 如有疑惑请电联。由于天气原因无法准时到达, 如有疑惑请电联。由于天气原因无法准时到达, 如有疑惑请电联。'),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(// 圆和线
                    height: 32,
                    child: LeftLineWidget(true, true, false),
                  ),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '天天乐超市（限时降价）已取货',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border:Border(left: BorderSide(
                        width: 2,
                        color: Colors.grey
                    ))
                ),
                margin: EdgeInsets.only(left: 23),
                padding: EdgeInsets.fromLTRB(22,0,16,16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('配送员：吴立亮 18888888888'),
                    Text('时间：2018-12-17 09:55:22')
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(// 圆和线
                    height: 32,
                    child: LeftLineWidget(true, false, false),
                  ),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '天天乐超市（限时降价）已取货',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border:Border(left: BorderSide(
                        width: 2,
                        color: Colors.transparent
                    ))
                ),
                margin: EdgeInsets.only(left: 23),
                padding: EdgeInsets.fromLTRB(22,0,16,16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('配送员：吴立亮 18888888888'),
                    Text('时间：2018-12-17 09:55:22')
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LeftLineWidget extends StatelessWidget {
  final bool showTop;
  final bool showBottom;
  final bool isLight;

  const LeftLineWidget(this.showTop, this.showBottom, this.isLight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: 16,
      child: CustomPaint(
        painter: LeftLinePainter(showTop, showBottom, isLight),
      ),
    );
  }
}

class LeftLinePainter extends CustomPainter {
  static const double _topHeight = 16;
  static const Color _lightColor = Colors.deepPurpleAccent;
  static const Color _normalColor = Colors.grey;

  final bool showTop;
  final bool showBottom;
  final bool isLight;

  const LeftLinePainter(this.showTop, this.showBottom, this.isLight);

  @override
  void paint(Canvas canvas, Size size) {
    double lineWidth = 2;
    double centerX = size.width / 2;
    Paint linePain = Paint();
    linePain.color = showTop ? Colors.grey : Colors.transparent;
    linePain.strokeWidth = lineWidth;
    linePain.strokeCap = StrokeCap.square;
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, _topHeight), linePain);
    Paint circlePaint = Paint();
    circlePaint.color = isLight ? _lightColor : _normalColor;
    circlePaint.style = PaintingStyle.fill;
    linePain.color = showBottom ? Colors.grey : Colors.transparent;
    canvas.drawLine(
        Offset(centerX, _topHeight), Offset(centerX, size.height), linePain);
    canvas.drawCircle(Offset(centerX, _topHeight), centerX, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}