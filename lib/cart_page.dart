import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'common/scaffold_page.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List list = [
    {'id': 1, 'content': '商品1'},
    {'id': 2, 'content': '商品2'},
    {'id': 3, 'content': '商品3'},
    {'id': 4, 'content': '商品4'},
    {'id': 5, 'content': '商品5'},
    {'id': 6, 'content': '商品6'},
    {'id': 7, 'content': '商品7'},
    {'id': 8, 'content': '商品8'},
    {'id': 9, 'content': '商品9'},
    {'id': 10, 'content': '商品10'},
    {'id': 11, 'content': '商品11'},
  ];
  @override
  void initState() {
    super.initState();
  }

  final SlidableController slidableController = SlidableController();
  _showSnackBar(String val, int idx) {
    print('idx===$idx');
    setState(() {
      list.removeAt(idx);
    });
  }

  _showSnack(BuildContext context, type) {
    print(type);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '购物车',
      child: Container(
        color: Color(0xf2f2f2f2),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: Key(index.toString()),
              controller: slidableController,
              actionPane: SlidableScrollActionPane(), // 侧滑菜单出现方式 SlidableScrollActionPane SlidableDrawerActionPane SlidableStrechActionPane
              actionExtentRatio: 0.20, // 侧滑按钮所占的宽度
              enabled: true, // 是否启用侧滑 默认启用
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                onDismissed: (actionType) {
                  _showSnack(
                      context,
                      actionType == SlideActionType.primary
                          ? 'Dismiss Archive'
                          : 'Dimiss Delete');
                  setState(() {
                    list.removeAt(index);
                  });
                },
                
                onWillDismiss: (actionType) {
                  return showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete'),
                        content: Text('Item will be deleted'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );
                },
              
              ),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Text('$index'),
                    foregroundColor: Colors.white,
                  ),
                  title: Text('${list[index]['content']}'),
                  subtitle: Text('SlidableDrawerDelegate'),
                ),
              ),
              // actions: <Widget>[
              //   IconSlideAction(
              //     caption: 'Archive',
              //     color: Colors.blue,
              //     icon: Icons.archive,
              //     onTap: () => print('2222'),
              //     closeOnTap: false,
              //   ),
              //   IconSlideAction(
              //     caption: 'Share',
              //     color: Colors.indigo,
              //     icon: Icons.share,
              //     onTap: () => _showSnackBar('Share', index),
              //   ),
              // ],
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'More',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: () => _showSnackBar('More', index),
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  closeOnTap: true,
                  onTap: () => _showSnackBar('Delete', index),
                ),
              ],
              
            );
          },
        ),
      ),
    );
  }
}
