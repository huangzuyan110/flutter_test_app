/*
 * @Descripttion: 拖拽列表移动排序
 * @Author: huangzuyan
 * @Date: 2021-01-22 14:27:30
 */
import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/util/widget_utils.dart';
import 'package:reorderables/reorderables.dart';

class ReorderableListPage extends StatefulWidget {
  ReorderableListPage({Key key}) : super(key: key);

  @override
  _ReorderableListPageState createState() => _ReorderableListPageState();
}

class _ReorderableListPageState extends State<ReorderableListPage> {
  List reviewList = [];
  @override
  void initState() { 
    super.initState();
    reviewList = [
      {'id':1, 'comment': '商品不错1'},
      {'id':2, 'comment': '商品不错2'},
      {'id':3, 'comment': '商品不错3'},
      {'id':4, 'comment': '商品不错4'},
      {'id':5, 'comment': '商品不错5'},
      {'id':6, 'comment': '商品不错6'},
      {'id':7, 'comment': '商品不错7'},
      {'id':8, 'comment': '商品不错8'},
      {'id':9, 'comment': '商品不错9'},
      {'id':10, 'comment': '商品不错10'},
      {'id':11, 'comment': '商品不错11'}
    ];
  }

    // 移动评价排序
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      var row = reviewList.removeAt(oldIndex);
      reviewList.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '拖拽列表移动重新排序', 
      child: Container(
        padding: EdgeInsets.all(12),
        child: CustomScrollView(
          slivers: <Widget>[
            ReorderableSliverList(
              delegate: ReorderableSliverChildListDelegate(
                List<Widget>.generate(reviewList.length, (int index) {
                  Map reviewItem = reviewList[index];
                  return  _reviewItemWidget(reviewItem, index);
                })
              ),
              onReorder: _onReorder,
              // 这个自定义按下拖拽是显示什么
              buildDraggableFeedback: (context, constraints, child){
                // print('height...${constraints.constrainHeight()}');
                var node = child.toDiagnosticsNode();
                String valueStr = node.getProperties()[0].toString();
                String indexStr = valueStr.substring(valueStr.indexOf(':')+1);
                int index = int.parse(indexStr);
                Map reviewItem = reviewList[index];
                return Material(
                  child: Container(
                    width: constraints.constrainWidth(),
                    height: constraints.constrainHeight()-12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _reviewItemWidget(reviewItem, index, onLongPress: true),
                  ),
                );
              },
            )
          ],
        ),
      )
    );
  }

  // 评价item
  Widget _reviewItemWidget(Map reviewItem, int index, {bool onLongPress = false}){
    return Container(
      key: ValueKey(index),
      margin: onLongPress ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 12),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: InkResponse(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
            highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
            //点击或者toch控件高亮的shape形状
            highlightShape: BoxShape.rectangle,
            //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
            //水波纹的半径
            radius: 0.0,
            //true表示要剪裁水波纹响应的界面 false不剪裁 如果控件是圆角不剪裁的话水波纹是矩形
            containedInkWell: true,
            onTap: () {
              // print('click');
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: onLongPress ? Color.fromRGBO(0, 0, 0, 0.2) : Colors.transparent
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      child: getTextWidget(14, '${index+1}'),
                    ),
                    Expanded(child: getTextWidget(14, reviewItem['comment']??''))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}