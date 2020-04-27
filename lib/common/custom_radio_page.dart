import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/test_globalkey_page.dart';
/* 
  注意此时的选择框必须是直接输入StatefulWidget下才能动态的更新选中状态的UI，如果有一个弹框里面包含了选择框，那么此时更换选中项是无法动态的更新UI
 */

class CustomRadioPage extends StatefulWidget {
  CustomRadioPage({Key key, @required this.radioValue, this.onChangeRadioValue, this.floatKey}) : super(key: key);
  // 当前选中的按钮的值
  final String radioValue;
  // 方法一： 改变单选框选择的值时，父组件执行方法
  final Function onChangeRadioValue;
  // 方法二： 通过父级传递过来的globalKey去控制单选框选择改变的执行
  final GlobalKey<TestGlobalKeyPageState> floatKey;

  @override
  _CustomRadioPageState createState() => _CustomRadioPageState();
}

class _CustomRadioPageState extends State<CustomRadioPage> {

  String _newValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newValue = widget.radioValue;
  }

  // 单选框发生改变
  void _changeRadioValue(String value){
    debugPrint('点击了单选框。。。。。。');
    setState(() {
      _newValue = value;
    });
    // 更新父级元素里面对应的选中变量的值
    if(widget.onChangeRadioValue!=null){
      debugPrint('执行父组件回调函数onChangeRadioValue。。。。');
      widget.onChangeRadioValue(value);
    }
    if(widget.floatKey != null){
      // widget.floatKey.currentState.onChangeRadioValue(value);
      widget.floatKey.currentState.testGlobalKeyFunc();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: _rowsRadioWidget(),
    );
  }

  // 每个选项独占一行的单选框
  Column _rowsRadioWidget() {
    return Column(
      children: <Widget>[
        RadioListTile<String>(
          value: '语文',
          title: Text('语文'),
          activeColor: Colors.red,
          groupValue: _newValue,
          onChanged: (value) {
            _changeRadioValue(value);
          },
        ),
        RadioListTile<String>(
          value: '数学',
          title: Text('数学'),
          activeColor: Colors.red,
          groupValue: _newValue,
          onChanged: (value) {
            _changeRadioValue(value);
          },
        ),
        RadioListTile<String>(
          value: '英语',
          title: Text('英语'),
          activeColor: Colors.red,
          groupValue: _newValue,
          onChanged: (value) {
            _changeRadioValue(value);
          },
        ),
      ],
    );
  }

  // 所有选项都在一行的单选框
  Row _flexibleRadioWidget() {
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile<String>(
            value: '语文',
            title: Text('语文'),
            activeColor: Colors.red,
            groupValue: _newValue,
            onChanged: (value) {
              _changeRadioValue(value);
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: '数学',
            title: Text('数学'),
            activeColor: Colors.red,
            groupValue: _newValue,
            onChanged: (value) {
              _changeRadioValue(value);
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: '英语',
            title: Text('英语'),
            activeColor: Colors.red,
            groupValue: _newValue,
            onChanged: (value) {
              _changeRadioValue(value);
            },
          ),
        ),
      ],
    );
  }

  // 不显示文本的单选框
  Row _noTipsRadiosWidget() {
    return Row(
      children: <Widget>[
        Radio<String>(
          value: "语文",
          groupValue: _newValue,
          activeColor: Colors.red,
          onChanged: (value) {
            print('点击语文===$value');
            _changeRadioValue(value);
          }),
        Radio<String>(
          value: "数学",
          groupValue: _newValue,
          activeColor: Colors.red,
          onChanged: (value) {
            print('点击数学===$value');
            _changeRadioValue(value);
          }),
        Radio<String>(
          value: "英语",
          groupValue: _newValue,
          activeColor: Colors.red,
          onChanged: (value) {
            print('点击英语===$value');
            _changeRadioValue(value);
          }),
      ],
    );
  }

}