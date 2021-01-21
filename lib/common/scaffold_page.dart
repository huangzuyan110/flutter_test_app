/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2020-03-31 11:21:00
 */
import 'package:flutter/material.dart';

class ScaffoldPage extends StatelessWidget {

  const ScaffoldPage({Key key, @required this.appBarTitle, @required this.child, this.backgroundColor}) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('$appBarTitle'),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}