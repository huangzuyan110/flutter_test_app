/*
 * @Descripttion: 拖拽网格图移动
 * @Author: huangzuyan
 * @Date: 2021-01-22 14:44:44
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/util/widget_utils.dart';
import 'package:reorderables/reorderables.dart';

class ReorderableWrapPage extends StatefulWidget {
  ReorderableWrapPage({Key key}) : super(key: key);

  @override
  _ReorderableWrapPageState createState() => _ReorderableWrapPageState();
}

class _ReorderableWrapPageState extends State<ReorderableWrapPage> {
  final double _iconSize = 90;
  List _tiles = [];

  @override
  void initState() { 
    super.initState();
    _tiles = <Widget>[
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_1, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_2, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_3, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_4, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_5, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_6, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_7, size: _iconSize)
      ),
      Container(
        width: ScreenUtil().setWidth(220),
        height: ScreenUtil().setWidth(220),
        color: Colors.white,
        child: Icon(Icons.filter_8, size: _iconSize)
      ),
    ];
  }

  // 移动排序
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _tiles.removeAt(oldIndex);
      _tiles.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '拖拽网格图移动', 
      child: Container(
        color: Colors.yellow,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ReorderableWrap(
                // 纵轴间距
                spacing: ScreenUtil().setWidth(20),
                // 主轴间距
                runSpacing: 10.0,
                padding: const EdgeInsets.all(12),
                children: _tiles,
                onReorder: _onReorder,
                // 纵轴对齐方式
                alignment: WrapAlignment.end,
                minMainAxisCount: 3,
                onNoReorder: (int index) {
                  //this callback is optional
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                },
                onReorderStarted: (int index) {
                  //this callback is optional
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                },
                buildDraggableFeedback:(context, constraints, child){
                  return Container(
                    child: getTextWidget(14, '拖动', textColor: Colors.red),
                  );
                }
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.add_circle),
                    color: Colors.deepOrange,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      var newTile = Container(
                        width: ScreenUtil().setWidth(220),
                        height: ScreenUtil().setWidth(220),
                        color: Colors.white,
                        child: Icon(Icons.filter_9_plus, size: _iconSize)
                      );
                      setState(() {
                        _tiles.add(newTile);
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.remove_circle),
                    color: Colors.teal,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      setState(() {
                        _tiles.removeAt(0);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
