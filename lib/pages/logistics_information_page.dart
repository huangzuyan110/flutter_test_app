import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/logistics_information_Item.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';


class LogisticsInformationPage extends StatefulWidget {
  LogisticsInformationPage({Key key}) : super(key: key);
 @override
 _LogisticsInformationPageState createState() =>_LogisticsInformationPageState();
}

class _LogisticsInformationPageState extends State<LogisticsInformationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '物流详情',
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left:20, right:10),
        child: ListView(
          children: <Widget>[
            LogisticsInformationItem(
              topColor: Colors.transparent,
              text: '已收货',
              details: '派送员张三已签收，如有问题请联系10010',
            ),
            LogisticsInformationItem(
              text: '派送中',
              details: '派送员李四正在派送中，如有问题请联系10086 派送员李四正在派送中，如有问题请联系10086 派送员李四正在派送中，如有问题请联系10086 派送员李四正在派送中，如有问题请联系10086',
            ),
            LogisticsInformationItem(
              bottomColor: Colors.transparent,
              text: '已发货',
              details: '商家已发货，如有问题请联系11110 商家已发货，如有问题请联系11110 商家已发货，如有问题请联系11110',
            ),
          ],
        ),
      ),
    );
  }

}