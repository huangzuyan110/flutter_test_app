import 'package:flutter/material.dart';

class ScaffoldPage extends StatelessWidget {

  const ScaffoldPage({Key key, @required this.appBarTitle, @required this.child}) : super(key: key);
  final Widget child;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarTitle'),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}