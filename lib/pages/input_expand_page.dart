import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class InputExpandPage extends StatelessWidget {
  const InputExpandPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '输入框expand样式',
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(bottom:12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextField(
                  maxLines: null, 
                  expands: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    hintText: '输入关键字以搜索',
                    hintStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      inherit: false,
                      color: Colors.grey,
                      fontSize: 14.0
                    ),
                    // border: InputBorder.none
                    border: OutlineInputBorder(
                      // borderSide: BorderSide.none
                    ),
                  ),
                  onEditingComplete: () {
                  },
                  readOnly: true,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                  ],
                  onChanged: null,
                  autocorrect: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextField(
                  maxLines: null, 
                  expands: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: '关键字以搜索',
                    hintStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      
                      inherit: false,
                      color: Colors.grey,
                      fontSize: 14.0
                    ),
                    // border: InputBorder.none
                  ),
                  onEditingComplete: () {
                  },
                  readOnly: true,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                  ],
                  onChanged: null,
                  autocorrect: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}