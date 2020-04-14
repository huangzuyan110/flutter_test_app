import 'package:flutter/material.dart';


class LogisticsInformationItem extends StatefulWidget {
  final Color topColor;
  final Color centerColor;
  final Color bottomColor;
  final Color textColor;
  final String text;
  final String details;
  LogisticsInformationItem({
    this.topColor: Colors.red,
    this.centerColor: Colors.green,
    this.bottomColor: Colors.cyan,
    this.textColor: Colors.cyan,
    this.text:'物流',
    @required this.details,
  });
 @override
 _LogisticsInformationItemState createState() =>_LogisticsInformationItemState();
}

class _LogisticsInformationItemState extends State<LogisticsInformationItem> {
  double _itemHeight = 0.0;
  GlobalKey _textKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    /// 监听是否渲染完
    WidgetsBinding _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addPostFrameCallback((callback){
      // _获取相应控件的size
      RenderObject _renderObject = _textKey.currentContext.findRenderObject();
      setState(() {
        _itemHeight = _renderObject.semanticBounds.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          // 左侧的线
          Container(
            margin: EdgeInsets.only(left:20),
            width: 10,
            height: _itemHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: widget.topColor,
                  )
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: widget.centerColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                Expanded(
                  child: Container(
                    width:2,
                    color:widget.bottomColor,
                  )
                ),
              ],
            ),
          ),
          /// 右侧的文案
          Expanded(
            child: Container(
              key: _textKey,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.text,
                    style: TextStyle(fontSize:15, color:widget.textColor),
                  ),
                  Text(
                    widget.details,
                    style: TextStyle(fontSize:12, color: Colors.black),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

}