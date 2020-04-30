import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'dart:math' as math;

class CustomLeftShowDeletePage extends StatefulWidget {
  CustomLeftShowDeletePage({Key key}) : super(key: key);

  @override
  _CustomLeftShowDeletePageState createState() => _CustomLeftShowDeletePageState();
}

class _CustomLeftShowDeletePageState extends State<CustomLeftShowDeletePage> {

  double _deleteBtnWidth = 80;
  double _rowHeight = 60;

   List list = [
    {'id': 1, 'content': '商品1', 'pLeft': 0.0},
    {'id': 2, 'content': '商品2', 'pLeft': 0.0},
    {'id': 3, 'content': '商品3', 'pLeft': 0.0},
    {'id': 4, 'content': '商品4', 'pLeft': 0.0},
    {'id': 5, 'content': '商品5', 'pLeft': 0.0},
    {'id': 6, 'content': '商品6', 'pLeft': 0.0},
    {'id': 7, 'content': '商品7', 'pLeft': 0.0},
    {'id': 8, 'content': '商品8', 'pLeft': 0.0},
    {'id': 9, 'content': '商品9', 'pLeft': 0.0},
    {'id': 10, 'content': '商品10', 'pLeft': 0.0},
    {'id': 11, 'content': '商品11', 'pLeft': 0.0},
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '左滑出现删除按钮', 
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: _rowHeight,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width:0.5, color: Colors.blue)
              )
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: _deleteBtnWidth,
                    alignment: Alignment.center,
                    height: double.infinity,
                    color: Colors.red,
                    child: Text('删除', style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Positioned(
                  left: list[index]['pLeft'],
                  top: 0,
                  bottom: 0,
                  // right: 0,
                  width: MediaQuery.of(context).size.width-24,
                  child: GestureDetector(
                    onTap: (){
                      if(list[index]['pLeft']!=0.0){
                        setState(() {
                          list[index]['pLeft'] = 0.0;
                        });
                      }
                    },
                    onPanUpdate: (details) {
                      // debugPrint('onPanUpdate details.delta.dx===${details.delta.dx}');
                      // debugPrint('onPanUpdate details.delta.dy===${details.delta.dy}');

                      if(list[index]['pLeft'] + details.delta.dx > 0) return;
                      if(list[index]['pLeft'] + details.delta.dx < -_deleteBtnWidth) return;

                      double dx =  list[index]['pLeft'] + details.delta.dx;
                      debugPrint('dx===$dx');
                      if(dx>=-_deleteBtnWidth){
                        setState(() {
                          list[index]['pLeft'] = dx;
                        });
                      }
                    },

                    onPanEnd: (details) {
                      debugPrint('onPanEnd details===$details,${details.velocity.pixelsPerSecond.dx}');
                      // 向右拖拽
                      if(list[index]['pLeft'].toInt().abs()>=_deleteBtnWidth/2){
                        setState(() {
                          list[index]['pLeft'] = -_deleteBtnWidth;
                        });
                      }else{
                        setState(() {
                          list[index]['pLeft'] = 0.0;
                        });
                      }
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Container(
                              width: 50,
                              height: double.infinity,
                              alignment: Alignment.center,
                              // color: Colors.yellow,
                              child: Text('${index+1}'),
                            ),
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                            child: Text('${list[index]['content']}'),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          );
        }
      )
    );
  }
}