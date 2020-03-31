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
            Container(
              child: CustomPaint(

              ),
            )
          ],
        )
      )
    );
  }
}

