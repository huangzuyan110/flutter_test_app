import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// 输入组件 用户名密码输入
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机号登录'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 123, 144, 1),
                Color.fromRGBO(254, 69, 69, 1)
              ],
            ),
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_left),
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Container(height: double.infinity, child: Formregist()),
    );
  }
}

class Formregist extends StatefulWidget {
  @override
  _FormregistState createState() => _FormregistState();
}

class _FormregistState extends State<Formregist> {

  String _verifyStr = "获取验证码";
  int _seconds = 0;
  String _phone = '';
  Timer _timer;

  _getSmsCode() async{
    Response response = await Dio().get("http://www.baidu.com/");
    print(response);
    // if(_phone == '') {
    //   print('请输入手机号');
    //   return;
    // }
    // if(_seconds == 0) {
    //   _startTimeout();
    // }
  }
  
  _startTimeout() {
    _seconds = 59;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _verifyStr = '${_seconds--}(s)重新获取';
        } else {
          _verifyStr = '获取验证码';
          print(_seconds);
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 44.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(40.0)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mobile_screen_share,
                      color: Colors.grey,
                    ),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入手机号',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  onChanged: (value) {
                    _phone = value;
                  },
                ),
              ),
              Container(
                height: 44.0,
                width: double.infinity,
                margin: EdgeInsets.only(top: 32.0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(40.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.code,
                            color: Colors.grey,
                          ),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          hintText: '请输入验证码',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _getSmsCode();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 110.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(237, 237, 237, 1),
                            borderRadius: BorderRadius.circular(120.0)),
                        child: Text(_verifyStr),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 38.0),
                width: double.infinity,
                height: 44.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                  color: Color.fromRGBO(255, 123, 144, 1),
                  onPressed: () {},
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 0.0,
                  disabledColor: Color.fromRGBO(255, 123, 144, 1),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
