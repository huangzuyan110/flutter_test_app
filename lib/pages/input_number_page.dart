import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/utils.dart';

class InputNumberPage extends StatefulWidget {
  InputNumberPage({Key key}) : super(key: key);

  @override
  _InputNumberPageState createState() => _InputNumberPageState();
}

class _InputNumberPageState extends State<InputNumberPage> {

  bool isCategoryMode = true;

  FocusNode focusNode = new FocusNode();
  final TextEditingController _inputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: Text('sdf'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness:Brightness.light,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Image.asset('assets/images/black_back.png'),
            ),
          ),
        ),
      ),
      
      body: GestureDetector(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            color: Color(0xfffffff),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:12),
                  child: Text('邀请码', style:TextStyle(fontSize:30, color: Color(0xFF060918), fontWeight: FontWeight.bold))
                ),
                Text('请输入邀请码', style:TextStyle(fontSize:12, color: Color(0xFF8D8D99))),
                // 邀请码输入区域
                _inputAreaWidget(context),
                // 登录按钮
                GestureDetector(
                  child: Container(
                    height: 44,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          stringIsNotEmpty(_inputController.text) ? Color(0xFFF55433) : Color(0xFFF8C7BD),
                          stringIsNotEmpty(_inputController.text) ? Color(0xFFF43333) : Color(0xFFF7BDBD),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(22)
                    ),
                    child:  Text(
                      '确定',
                      style: TextStyle(
                        fontSize: 14,
                        decoration:
                            TextDecoration.none,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ), 
        // onTap: () {
        //   // 点击空白页面关闭键盘
        //   FocusScope.of(context).requestFocus(focusNode);
        // },
      ),
    );
  }
  // 输入框部分
  Container _inputAreaWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 48, 0, 48),
      width: MediaQuery.of(context).size.width-24,
      height: 48,
      child: Stack(
        children: <Widget>[
          TextField(
            autofocus: false,
            maxLines: 1,
            style: TextStyle(
              color: Color(0xFF060918),
              fontSize: 14.0,
              inherit: false,
              textBaseline: TextBaseline.alphabetic,
            ),
            controller: _inputController,
            focusNode: focusNode,
            onChanged: (text) {
              // 刷新一下页面，此处一定要有
              setState(() {
              });
            },
            onSubmitted: (text) {
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:EdgeInsets.all(0),
              border: InputBorder.none,
            ),
          ),
          Positioned(
            top: -2,
            bottom: 0,
            left:0,
            right: 0,
            child:GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(focusNode);
              },
              child: Container(
                color: Color(0xffffffff),
                child: _numberRowWidget(),
              ),
            )
          )
        ],
      )
    );
  }
  // 数字行部分
  Row _numberRowWidget() {
    print('da====${_inputController.text}');
    bool _inputIsNotEmpty = stringIsNotEmpty(_inputController.text);
    int _len = _inputController.text.length;

    return Row(
      children: <Widget>[
        _numberWidget(_inputIsNotEmpty && _len>=1 ? _inputController.text.substring(0,1) : ''),
        SizedBox(width: 32,),
        _numberWidget(_inputIsNotEmpty && _len>=2 ? _inputController.text.substring(1,2) : ''),
        SizedBox(width: 32,),
        _numberWidget(_inputIsNotEmpty && _len>=3 ? _inputController.text.substring(2,3) : ''),
        SizedBox(width: 32,),
        _numberWidget(_inputIsNotEmpty && _len>=4 ? _inputController.text.substring(3,4) : ''),
        SizedBox(width: 32,),
        _numberWidget(_inputIsNotEmpty && _len>=5 ? _inputController.text.substring(4,5) : ''),
        SizedBox(width: 32,),
        _numberWidget(_inputIsNotEmpty && _len>=6 ? _inputController.text.substring(5,6) : ''),
      ],
    );
  }
  // 数字部分
  Expanded _numberWidget(String number) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: number.isNotEmpty ? Color(0xFF060918) : Color(0xFFECEBF0)
            )
          ),
        ),
        child: Text('$number', style: TextStyle(fontSize: 36, color: Color(0xFF060918), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
    );
  }
}