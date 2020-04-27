import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/common/custom_radio_page.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:flutter_test_app/util/throttle.dart';
import 'package:flutter_test_app/util/utils.dart';

// 多次点击事件对象
class MultipleClickObject{

  MultipleClickObject(this.multipleClickNum, this.clickInterverTime);
  final String password = 'ligeit123456';
  // 点击六次
  final int multipleClickNum;
  // 点击时间间隔1s
  final int clickInterverTime;
  // 上一次点击的时间
  int lastClickTime = 0;
  // 记录点击次数
  int clickNum = 0;
}

class MultipleClickPage extends StatefulWidget {
  MultipleClickPage({Key key}) : super(key: key);

  @override
  _MultipleClickPageState createState() => _MultipleClickPageState();
}

class _MultipleClickPageState extends State<MultipleClickPage>{
  // 密码输入框控制器
  final TextEditingController _passwordController = new TextEditingController();
  // 防抖动
  final Throttling throttling =  Throttling();
  String _checkedRadioValue = '英语';

  // 多次点击对象
  MultipleClickObject clickObject = MultipleClickObject(6, 1000);

  final List<Widget> aboutBoxChildren = <Widget>[
    SizedBox(height: 24),
    RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Flutter is Google’s UI toolkit for building beautiful, '
            'natively compiled applications for mobile, web, and desktop '
            'from a single codebase. Learn more about Flutter at '
          ),
          TextSpan(
            text: 'https://flutter.dev'
          ),
          TextSpan(
            text: '.'
          ),
        ],
      ),
    ),
  ];

  @override
  void initState() { 
    super.initState();
    print('对此点击创建对象里的 clickInterverTime====${clickObject.clickInterverTime}');
    print('对此点击创建对象里的 lastClickTime====${clickObject.lastClickTime}');
    print('对此点击创建对象里的 multipleClickNum====${clickObject.multipleClickNum}');
    print('对此点击创建对象里的 clickNum====${clickObject.clickNum}');
  }

  @override
  void dispose() { 
    clickObject = null;
    _passwordController.dispose();
    super.dispose();
  }

  void _multipelClick(BuildContext mContext){
    // 获取当前时间戳（单位毫秒）
    int currentClickTime = DateTime.now().millisecondsSinceEpoch;
    debugPrint('当前时间戳====$currentClickTime');
    debugPrint('上一次时间戳====${clickObject.lastClickTime}');
    debugPrint('连续点击了几次clickNum====${clickObject.clickNum+1}');

    //点击的间隔时间不能超过1秒
    if (currentClickTime - clickObject.lastClickTime <= clickObject.clickInterverTime || clickObject.lastClickTime == 0) {
      clickObject.lastClickTime = currentClickTime;
      clickObject.clickNum++;
    } else {
      //超过1秒的间隔
      //重新计数 从1开始
      clickObject.clickNum = 1;
      clickObject.lastClickTime = 0;
      debugPrint('点击间隔超过1s,重新开始计算点击次数');
      return;
    }
    if (clickObject.clickNum == clickObject.multipleClickNum) {
      //重新计数
      clickObject.clickNum = 0; 
      clickObject.lastClickTime = 0;
      debugPrint('点击了六次了============================');
      /*实现点击多次后的事件*/
      // showAboutDialog(
      //   context: context,
      //   applicationIcon: FlutterLogo(),
      //   applicationName: 'Show About Example',
      //   applicationVersion: 'August 2019',
      //   applicationLegalese: '© 2019 The Chromium Authors',
      //   children: aboutBoxChildren,
      // );

      // 多次点击弹出输入密码确认框弹窗
      _confirmDialog(mContext);
    }
  }


  // 环境设置弹框取消按钮回调
  void _passwordCancleBtnCallBack(){
    _passwordController.text = '';
    // 关闭弹窗
    Navigator.pop(context);
  }

  // 环境设置弹框确定按钮回调
  void _passwordConfirmBtnCallBack(){
    debugPrint('输入密码===${_passwordController.text}');
    if(!stringIsNotEmpty(_passwordController.text)){
      showInfo(context, '请输入密码');
      return;
    }
    if(_passwordController.text == clickObject.password){
      debugPrint('密码匹配成功');
      _passwordController.text = '';
      // 关闭弹窗
      Navigator.pop(context);
      _settingDialog(context);
    }else{
      showInfo(context, '密码输入有误，请重新输入');
    }
  }

  // 密码确认框弹窗
  void _confirmDialog(BuildContext mContext){
    showDialog(
      context: mContext,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
              width: 270,
              margin: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _inputCommonWidget('请输入密码'),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFECEBF0), width: 1)
                      )
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _customMaterialButton(_passwordCancleBtnCallBack, '取消', false, textColor: Color(0xFFF43333), bgColor: Color(0xffffffff)),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: _customMaterialButton(_passwordConfirmBtnCallBack, '确定', true, textColor: Color(0xffffffff), bgColor: Color(0xFFF43333)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ); 
  }

  // 按钮 btnText:按钮文本  isComfirm: 是否是点击了确定 textColor: 按钮文本的颜色 bgColor:按钮的背景色
  MaterialButton _customMaterialButton(Function callback,String btnText, bool isComfirm, {Color textColor, Color bgColor}) {
    return MaterialButton(
      child: Text(
        '$btnText',
        style: TextStyle(
            fontSize: 16.0),
      ),
      color: bgColor,
      textColor: textColor,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      onPressed: () {
        throttling.throttle((){
          if(callback!=null) callback();
        });
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: textColor),
        borderRadius: BorderRadius.circular(20.0)
      ),
      height: 40,
    );
  }

  // 环境设置弹框取消按钮回调
  void _settingCancleBtnCallBack(){
    // 关闭弹窗
    Navigator.of(context).pop();
  }

  // 环境设置弹框确定按钮回调
  void _settingConfirmBtnCallBack(){
    debugPrint('环境配置页面点击了确定按钮');
  }

  // 单选框发生改变
  void _onChangeRadioValue(String value){
    _checkedRadioValue = value;
    debugPrint('父组件监听到子组件的单选框发生改变，_checkedRadioValue对应值====$_checkedRadioValue');
  }

  // 环境配置弹框
  void _settingDialog(BuildContext mcontext){
    debugPrint('进入环境配置弹框方法。。。');
    showDialog(
      context: mcontext,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
              width: 270,
              margin: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomRadioPage(radioValue: _checkedRadioValue, onChangeRadioValue: _onChangeRadioValue),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFECEBF0), width: 1)
                      )
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _customMaterialButton(_settingCancleBtnCallBack, '取消', false, textColor: Color(0xFFF43333), bgColor: Color(0xffffffff)),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: _customMaterialButton(_settingConfirmBtnCallBack, '确定', true, textColor: Color(0xffffffff), bgColor: Color(0xFFF43333)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 输入框
  Container _inputCommonWidget(String hintText) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: TextField(
        autofocus: true,
        maxLines: 1,
        style: TextStyle(
          color: Color(0xFF060918),
          fontSize: 14.0,
          inherit: false,
          textBaseline: TextBaseline.alphabetic,
        ),
        controller: _passwordController,
        onChanged: (text) {
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20) //限制长度
        ],
        decoration: InputDecoration(
          contentPadding:EdgeInsets.all(0),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '多次点击图标触发事件',
      child: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: (){
            _multipelClick(context);
          },
          child: Image.asset('assets/images/icon_home_select.png'),
        ),
      ),
    );
  }
}