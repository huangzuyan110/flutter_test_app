import 'package:flutter/material.dart';

class TestGlobalKeyPage extends StatefulWidget {
  TestGlobalKeyPage({Key key}) : super(key: key);

  @override
  TestGlobalKeyPageState createState() => TestGlobalKeyPageState();
}

class TestGlobalKeyPageState extends State<TestGlobalKeyPage> {

  void testGlobalKeyFunc(){
    debugPrint('调用了TestGlobalKeyPageState类测试globalKey的方法');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}