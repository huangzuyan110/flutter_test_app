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
  final double _fontSize = 50, _spacing = 8.0, _padding = 12.0;
  int _minMainAxisCount = 3;
  List _tiles = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  void initState() { 
    super.initState();
  }

  // 移动排序
  void _onReorder(int oldIndex, int newIndex) {
    print('oldIndex===$oldIndex, newIndex===$newIndex');
    setState(() {
      dynamic row = _tiles.removeAt(oldIndex);
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
                spacing: _spacing,
                // 主轴间距
                runSpacing: 10.0,
                padding: EdgeInsets.all(_padding),
                children: _buildItemWidget(),
                onReorder: _onReorder,
                // 纵轴对齐方式
                alignment: WrapAlignment.end,
                minMainAxisCount: _minMainAxisCount,
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
                      setState(() {
                        _tiles.add('9+');
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

  List<Widget> _buildItemWidget(){
    List<Widget> _temp = [];
    double boxWH = (MediaQuery.of(context).size.width - (_padding*2 + _spacing*(_minMainAxisCount-1))) / _minMainAxisCount;
    _tiles.forEach((element) {
      _temp.add(
        Container(
          width: boxWH,
          height: boxWH,
          color: Colors.white,
          alignment: Alignment.center,
          child: getTextWidget(_fontSize, '$element')
        )
      );
    });
    return _temp;
  }
}
