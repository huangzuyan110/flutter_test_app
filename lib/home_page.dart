import 'package:flutter/material.dart';
import 'common/common_select_page.dart';
import 'common/float_widget.dart';
import 'common/scaffold_page.dart';
import 'pages/animated_button.dart';
import 'pages/test_future.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '首页',
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.cyan,
            child: Column(
              children: <Widget>[
                Text("这是首页"),
                AnimatedButton(),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: () async{
                    _bankBranchDialog();
                  },
                  child: Text('弹窗选择省市区'),
                ),
                RaisedButton(
                  onPressed: () async{
                    print(1111);
                    TestFuture testFuture = new TestFuture();
                    String a = await testFuture.getIntNumber();
                    print('future返回的值===$a');
                  },
                  child: Text('跳转到上传多张图片页面'),
                ),
              ],
            ),
          ),

          FloatWidget()
        ],
      )
    );
  }

  // 选择支行弹出框
  Future _bankBranchDialog() async{
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CommonSelectPage();
      },
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      )),
    );
  }
}