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
            )
            
          ],
        )
      )
    );
  }
}

// 贝塞尔曲线
class BottomClipper extends CustomClipper<Path> {
  BottomClipper({this.diffHeight=20.0}) : super();
  // 曲线起始点距离底部的高度
  final double diffHeight;


  @override
  Path getClip(Size size) {
    print('弧线size====$size');
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - diffHeight); //第2个点
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - diffHeight);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEdnPoint.dx, firstEdnPoint.dy);
    path.lineTo(size.width, size.height - diffHeight); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


