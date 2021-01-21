import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test_app/pages/map/show_marker.dart';
import 'package:flutter_test_app/util/widget_utils.dart';

import 'common/scaffold_page.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  // isShowSortGuide: 是否显示排序指引遮罩层 hasRelocate: 页面渲染完后是否已经重新定位过排序指引遮罩层,这个字段一定要加，用来控制页面不要一直重新绘制
  bool isShowSortGuide = true, hasRelocate = false;
  // positionTop：移动提示指引遮罩距离顶部定位 paddingTop: 状态栏高度 stackHeight: 遮罩层高度
  double positionTop = 180, positionLeft = 30, paddingTop = 20, stackHeight = 102;
    
  List list = [
    {'id': 1, 'content': '商品商品商品商品商品商品商品商1'},
    {'id': 2, 'content': '商品商品商品商品商品商品商品商品商品商品商品商品商品2'},
    {'id': 3, 'content': '商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品商品3'},
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
      child: Stack(
        children: [
          Container(
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
                      leading: Builder(
                        builder: (builderContext) {
                          if(isShowSortGuide && !hasRelocate && index==2){
                            WidgetsBinding.instance.addPostFrameCallback((_){
                            
                              try{
                                final RenderBox renderContainer = builderContext.findRenderObject();
                                // Size size = renderContainer.paintBounds.size;
                                var vector3 = renderContainer.getTransformTo(null)?.getTranslation();
                                final double dx = vector3[0];
                                final double dy = vector3[1];

                                setState(() {
                                  positionLeft = dx;
                                  positionTop = dy - (kToolbarHeight + paddingTop + stackHeight);
                                  hasRelocate = true;
                                });

                                // print('renderContainer====$renderContainer');
                                // print('vector3===$vector3');
                                print('dx===$dx, dy====$dy');
                              }catch(err){
                                print('err===$err');
                              }
                            });
                          }

                          return CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            child: Text('$index'),
                            foregroundColor: Colors.white,
                          );
                        }
                      ),
                      // title: Text('${list[index]['content']}'),
                      title: Container(
                        width: 20,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text('${list[index]['content']}'),
                      ),
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
          _stackGuideWidget()
        
        ],
      ),
    );
  }

  // 排序遮罩指引
  Visibility _stackGuideWidget() {
    return Visibility(
      visible: isShowSortGuide,
      child: Positioned(
        left: positionLeft,
        top: positionTop,
        child: Container(
          height: stackHeight,
          width: 158,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46,
                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getTextWidget(12, '长按可以移动商品排序', textColor: Color(0xffffffff)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isShowSortGuide = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(6.0, 10.0, 6.0, 10.0),
                        color: Colors.transparent,
                        child: Image.asset('assets/images/common_popups_close_icon.png', width: 12, height: 12),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: Offset(6, 0),
                  child: Image.asset('assets/images/sort_guide_icon.png', height: 63, width: 28,)
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
  
