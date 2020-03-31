import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class LeftScrollDeletePage extends StatefulWidget {
  LeftScrollDeletePage({Key key}) : super(key: key);

  @override
  _LeftScrollDeletePageState createState() => _LeftScrollDeletePageState();
}

class _LeftScrollDeletePageState extends State<LeftScrollDeletePage> {
  double kWidgetPadding = 20.0;
  List productArr = [
    {'name':'测试左滑出现删除按钮商品1','dx':0.0},
    {'name':'测试左滑出现删除按钮商品2','dx':0.0},
    {'name':'测试左滑出现删除按钮商品3','dx':0.0},
    {'name':'测试左滑出现删除按钮商品4','dx':0.0},
    {'name':'测试左滑出现删除按钮商品5','dx':0.0},
    {'name':'测试左滑出现删除按钮商品6','dx':0.0},
    {'name':'测试左滑出现删除按钮商品7','dx':0.0},
    {'name':'测试左滑出现删除按钮商品8','dx':0.0},
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '左滑删除选项',
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey,
        child: ListView.builder(
          itemCount: productArr.length,
          itemBuilder: (BuildContext context, int index){
            GlobalKey _key = GlobalKey();
            return Container(
              width: MediaQuery.of(context).size.width-20,
              height: 115,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: 72,
                        height: 115.5,
                        key: _key,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.only(bottomRight: Radius.circular(9)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color.fromRGBO(255, 123, 144, 1),
                              Color.fromRGBO(254, 69, 69, 1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            Text(
                              "删除",
                              textScaleFactor: 1.0,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: productArr[index]['dx'],
                    top: 0,
                    child: GestureDetector(
                      onTap: (){
                        // 单击的时候恢复
                        if(productArr[index]['dx'] !=0.0){
                          setState(() {  
                            productArr[index]['dx'] =0.0;
                          });
                        }
                      },
                      onHorizontalDragUpdate: (details){
                        debugPrint('Update details===$details');
                        debugPrint('''productArr[index]['dx']===${productArr[index]['dx']}''');
                        double originX;
                        // 用户从右向左滑动
                        if(details.delta.dx<=0.0){
                          originX = (details.delta.dx + productArr[index]['dx']) > (-72.0-kWidgetPadding)
                            ? (details.delta.dx + productArr[index]['dx'])
                            : (-72.0-kWidgetPadding);
                        } else{
                          originX = (productArr[index]['dx']+details.delta.dx) < 0.0
                            ? (details.delta.dx + productArr[index]['dx'])
                            : 0.0;
                        }

                        setState(() {
                          productArr[index]['dx'] = originX;
                        });
                      },
                      onHorizontalDragEnd:(details){
                        debugPrint('删除按钮的宽===${_key.currentContext.size.width}');
                        debugPrint('End details===$details');
                        debugPrint('End dx===${productArr[index]['dx']}');
                        if(productArr[index]['dx']< 0.0){
                          setState(() {  
                            productArr[index]['dx'] = -92.0;
                          });
                        }else{
                          setState(() {  
                            productArr[index]['dx'] =0.0;
                          });
                        }
                        // if(productArr[index]['dx']<0)
                      },
                      onHorizontalDragCancel: (){
                        debugPrint('取消。。。');
                      },

                      // onPanUpdate: (details) {
                      //   double originX;
                      //   // 用户从右向左滑动
                      //   if(details.delta.dx<=0.0){
                      //     originX = (details.delta.dx + productArr[index]['dx']) > (-72.0-kWidgetPadding)
                      //       ? (details.delta.dx + productArr[index]['dx'])
                      //       : (-72.0-kWidgetPadding);
                      //   } else{
                      //     originX = (productArr[index]['dx']+details.delta.dx) < 0.0
                      //       ? (details.delta.dx + productArr[index]['dx'])
                      //       : 0.0;
                      //   }

                      //   setState(() {
                      //     productArr[index]['dx'] = originX;
                      //   });
                      // },
                      // onPanEnd: (details) {
                      //   debugPrint('onPanEnd details.delta.dx===$details');
                      //   if(productArr[index]['dx']< 0.0){
                      //     setState(() {  
                      //       productArr[index]['dx'] = -92.0;
                      //     });
                      //   }else{
                      //     setState(() {  
                      //       productArr[index]['dx'] =0.0;
                      //     });
                      //   }
                      // },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 115,
                        color: Colors.cyan,
                        child: Text(productArr[index]['name']??''),
                      ) ,
                    )
                  )
                ],
              ),
            );
          }
        ),
      )
    );
  }


}