import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/pages/paint/image_paint_widget.dart';

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
            ),
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                height: 100,
                margin: EdgeInsets.only(bottom:50),
                color: Colors.purple,
                // child: Text('三角形绘制'),
              ),
            ),
            CustomPaint(
              painter: ImagePaint(),
              size: Size(MediaQuery.of(context).size.width, 400),
            ),
            CustomPaint(
              painter: TrianglePainter(Colors.red),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
              ),
            )
            
          ],
        )
      )
    );
  }
}

// 曲线 两个控制点 一般弧线
class BottomClipper extends CustomClipper<Path> {
  BottomClipper({this.diffHeight=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffHeight;


  @override
 
  Path getClip(Size size) {
    // print('两个控制点容器size====$size');
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
    // print('绘制路径firstControlPoint===$firstControlPoint');
    // print('绘制路径firstEndPoint===$firstEndPoint');
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


// 曲线 三个控制点 波浪线
class BottomWavyClipper extends CustomClipper<Path> {
  BottomWavyClipper({this.diffHeight=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffHeight;


  @override
  Path getClip(Size size) {
    // print('三个控制点容器size====$size');
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
    // print('绘制路径firstControlPoint===$firstControlPoint');
    // print('绘制路径secondControlPoint===$secondControlPoint');
    // print('绘制路径thirdControlPoint===$thirdControlPoint');

    // 形成曲线
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

// 三角形
class TriangleClipper extends CustomClipper<Path> {
  TriangleClipper({this.diffWidth=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffWidth;


  @override
  Path getClip(Size size) {
    // print('三角形容器size====$size');
    // 绘制点从左往右，从上往下
    Path path = Path();
    // 第1个点, 将起始点从左上角移动到容器中心
    path.moveTo(size.width/2, 0);
    path.lineTo(diffWidth, size.height);
   
    path.lineTo(size.width-diffWidth, size.height);

    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// 绘制三角形
class TrianglePainter extends CustomPainter {
  
  // 填充颜色
  final Color color;
  // 画笔
  Paint _paint;
  // 绘制路径
  Path _path;
  // 角度
  double angle;

  TrianglePainter(this.color){
    _paint = Paint()
      ..strokeWidth = 1.0 // 线宽
      ..color = color
      ..isAntiAlias = true;
      _path = Path();
  } 

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // debugPrint('绘制三角形容器size===$size');
    final baseX = size.width * 0.5;
    final baseY = size.height * 0.5;
    // 起点
    _path.moveTo(baseX - 0.86 * baseX, 0.5 * baseY);
    _path.lineTo(baseY, 1.5 * baseY);
    _path.lineTo(baseX + 0.86 * baseX, 0.5 * baseY);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }

}

// 绘制六边形
class SexangleClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    // debugPrint('六边形容器的size====$size');
    Path path = Path();
    path.moveTo(size.width/2 - 100, 0);
    // path.lineTo(x, y)

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }

  
}



