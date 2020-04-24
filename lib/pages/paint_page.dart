import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class PaintPage extends StatefulWidget {
  PaintPage({Key key}) : super(key: key);

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '绘制图形', 
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: BottomClipper(diffHeight:50),
              child: Container(
                // height: 200,
                color: Colors.yellow,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 50),
                child: Text('不定死高度，由内容撑开高度。不定死高度，由内容撑开高度。不定死高度，由内容撑开高度。不定死高度，由内容撑开高度。不定死高度，由内容撑开高度。不定死高度，由内容撑开高度。'),
              )
            ),
            ClipPath(
              clipper: BottomWavyClipper(diffHeight:50),
              child: Container(
                height: 200,
                color: Colors.cyan,
              )
            )
            
          ],
        )
      )
    );
  }
}

// 贝塞尔曲线 两个控制点 一般弧线
class BottomClipper extends CustomClipper<Path> {
  BottomClipper({this.diffHeight=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffHeight;


  @override
 
  Path getClip(Size size) {
    print('弧线size====$size');
    // 绘制点从左往右，从上往下
    Path path = Path();
    // 第1个点, 起始点（0，0）：左上角
    path.lineTo(0, 0);
    // 第2个点，左下角
    path.lineTo(0, size.height - diffHeight);
    // 路径第一个开始控制点 Offset(size.width / 2, size.height） size.width/2 : Container容器宽度中心，size.height： Container容器高度
    Offset firstControlPoint = Offset(size.width / 2, size.height);
    // 路径第一个结束控制点 Offset(size.width, size.height - diffHeight)： 以容器宽度为x，（容器高度-diffHeight）为y轴作为结束控制点
    Offset firstEndPoint = Offset(size.width, size.height - diffHeight);
    print('绘制路径firstControlPoint===$firstControlPoint');
    print('绘制路径firstEndPoint===$firstEndPoint');
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    // 第3个点, 右下角
    path.lineTo(size.width, size.height - diffHeight);
    // 第4个点， 右上角
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


// 贝塞尔曲线 三个控制点 波浪线
class BottomWavyClipper extends CustomClipper<Path> {
  BottomWavyClipper({this.diffHeight=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffHeight;


  @override
  Path getClip(Size size) {
    print('弧线size====$size');
    // 绘制点从左往右，从上往下
    Path path = Path();
    // 第1个点, 起始点（0，0）：左上角
    path.lineTo(0, 0);
    // 第2个点，左下角
    path.lineTo(0, size.height - diffHeight);
    // 路径第一个开始控制点 Offset(size.width / 2, size.height） size.width/2 : Container容器宽度中心，size.height： Container容器高度
    Offset firstControlPoint = Offset(80, size.height);
    Offset secondControlPoint = Offset(100, size.height - diffHeight-60);
    Offset thirdControlPoint = Offset(200, size.height - diffHeight);
    print('绘制路径firstControlPoint===$firstControlPoint');
    print('绘制路径secondControlPoint===$secondControlPoint');
    print('绘制路径thirdControlPoint===$thirdControlPoint');

    path.cubicTo(firstControlPoint.dx, firstControlPoint.dy,
        secondControlPoint.dx, secondControlPoint.dy, thirdControlPoint.dx, thirdControlPoint.dy);

    Offset firstControlPoint2 = Offset(size.width / 2+50, size.height);
    Offset secondControlPoint2 = Offset(300, size.height - diffHeight-60);
    Offset thirdControlPoint2 = Offset(size.width, size.height - diffHeight);

    path.cubicTo(firstControlPoint2.dx, firstControlPoint2.dy,
        secondControlPoint2.dx, secondControlPoint2.dy, thirdControlPoint2.dx, thirdControlPoint2.dy);

    // 第3个点, 右下角
    path.lineTo(size.width, size.height - diffHeight);
    // 第4个点， 右上角
    path.lineTo(size.width, 0);

    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



