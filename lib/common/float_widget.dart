import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';

///漂浮按钮尺寸
const double KFloatWidgetSize = 64.0;

///拖动按钮时距离屏幕边缘的间距
const double KFloatWidgetPadding = 0.0;

///漂浮按钮的圆角尺寸
const double KFloatWidgetRadius = 20.0;

// 除去状态栏和底部标题栏的总高度
const double KFloatRemoveHeight = 160;


class FloatWidget extends StatefulWidget {
  FloatWidget({Key key}) : super(key: key);
  @override
  _FloatWidgetState createState() => _FloatWidgetState();

}

class _FloatWidgetState extends State<FloatWidget> {
  Offset offset;
  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      offset = Offset(3, 149);
    } else {
      offset = Offset(320, 546.0);
    }
  }

  Future<bool> showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Text('zzzz');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userModel = {
      'userInfo': {
        'fetchMobileMember': {'referrerId': 1}
      }
    };
    bool isShowBaing = true;
//    debugPrint(userModel.userInfo.toString());
    if (userModel['userInfo'] != null &&
        userModel['userInfo']["fetchMobileMember"] != null) {
      if (userModel['userInfo']['fetchMobileMember']["referrerId"] != null &&
          userModel['userInfo']['fetchMobileMember']["referrerId"] == 1) {
        debugPrint("需绑定");
        isShowBaing = false;
      }
    } else {
      debugPrint("没有登录");
    }

    // debugPrint('offset.dx====${offset.dx}');
    // debugPrint('MediaQuery.of(context).size.width====${MediaQuery.of(context).size.width}');
    debugPrint('MediaQuery.of(context).size.height====${MediaQuery.of(context).size.height}');
    // debugPrint('offset.dy====${offset.dy}');

    return Positioned(
      // left: (offset.dx > (MediaQuery.of(context).size.width - 64))
      //     ? (MediaQuery.of(context).size.width - 64)
      //     : offset.dx,
      right: (offset.dx > (MediaQuery.of(context).size.width - 64))
          ? (MediaQuery.of(context).size.width - 64)
          : offset.dx,
      bottom: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          debugPrint('details.delta.dx===${details.delta.dx}');
          debugPrint('details.delta.dy===${details.delta.dy}');
          double originX = (offset.dx - details.delta.dx) < KFloatWidgetPadding
              ? KFloatWidgetPadding
              : (offset.dx - details.delta.dx);
          originX = originX >
                  (MediaQuery.of(context).size.width - KFloatWidgetSize - KFloatWidgetPadding)
              ? (MediaQuery.of(context).size.width - KFloatWidgetSize - KFloatWidgetPadding)
              : originX;
          double originY;
          debugPrint('offset.dy - details.delta.dy====${offset.dy - details.delta.dy}');
          if((offset.dy - details.delta.dy)<0){
            originY = 0;
          }else {
            double diffHeight = MediaQuery.of(context).size.height - KFloatRemoveHeight - KFloatWidgetSize;
            debugPrint('diffHeight===$diffHeight');
            if((offset.dy - details.delta.dy)>diffHeight){
              originY = diffHeight;
            }else{
              originY = offset.dy - details.delta.dy;
            }
          }
          // double originY = (offset.dy - details.delta.dy) < 0
          //     ? 0
          //     : (offset.dy - details.delta.dy);
          // debugPrint('第一次赋值originY===$originY');
          // originY = originY > (MediaQuery.of(context).size.height - widget.paddingTop - KFloatWidgetSize)
          //         ? (MediaQuery.of(context).size.height - widget.paddingTop - widget.paddingTop - KFloatWidgetSize)
          //         : originY;

          // debugPrint('第二次赋值originY===$originY');
          // originY = originY < 64 ? 64 : originY;

          debugPrint('第三次赋值originY===$originY');
          setState(() {
            offset = Offset(originX, originY);
          });
        },
        onPanEnd: (details) {
          if (offset.dx < (MediaQuery.of(context).size.width / 2.0 - KFloatWidgetPadding)) {
            setState(() {
              offset = Offset(3, offset.dy);
            });
          } else {
            setState(() {
              offset = Offset(MediaQuery.of(context).size.width - KFloatWidgetSize - KFloatWidgetPadding, offset.dy);
            });
          }
        },
        child: Offstage(
          offstage: isShowBaing,
          child: Container(
            width: 64,
            height: 61,
            child: InkWell(
              onTap: () {
                // showCustomDialog();
                //  debugPrint("跳转到");
              },
              child: Image.asset(
                "assets/images/homepagedrag.png",
                fit: BoxFit.cover,
              )
            ),
          )
        ),
      ),
    );
  }
}
