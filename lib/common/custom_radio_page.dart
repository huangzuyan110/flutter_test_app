import 'package:flutter/material.dart';

/* 
  注意此时的选择框必须是直接输入StatefulWidget下才能动态的更新选中状态的UI，如果有一个弹框里面包含了选择框，那么此时更换选中项是无法动态的更新UI
 */

class CustomRadioPage extends StatefulWidget {
  CustomRadioPage({Key key, @required this.radioValue}) : super(key: key);
  // 当前选中的按钮的值
  final String radioValue;

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
            setState(() {
              _newValue = value;
            });
          },
        ),
        RadioListTile<String>(
          value: '数学',
          title: Text('数学'),
          activeColor: Colors.red,
          groupValue: _newValue,
          onChanged: (value) {
            setState(() {
              _newValue = value;
            });
          },
        ),
        RadioListTile<String>(
          value: '英语',
          title: Text('英语'),
          activeColor: Colors.red,
          groupValue: _newValue,
          onChanged: (value) {
            setState(() {
              _newValue = value;
            });
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
              setState(() {
                _newValue = value;
              });
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
              setState(() {
                _newValue = value;
              });
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
              setState(() {
                _newValue = value;
              });
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
            setState(() {
              _newValue = value;
            });
          }),
        Radio<String>(
          value: "数学",
          groupValue: _newValue,
          activeColor: Colors.red,
          onChanged: (value) {
            print('点击数学===$value');
            setState(() {
              _newValue = value;
            });
          }),
        Radio<String>(
          value: "英语",
          groupValue: _newValue,
          activeColor: Colors.red,
          onChanged: (value) {
            print('点击英语===$value');
            setState(() {
              _newValue = value;
            });
          }),
      ],
    );
  }

}