import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class CustomStepperNewPage extends StatefulWidget {
  CustomStepperNewPage({Key key}) : super(key: key);

  @override
  _CustomStepperNewPageState createState() => _CustomStepperNewPageState();
}

class _CustomStepperNewPageState extends State<CustomStepperNewPage> {
  double _progressHeight = 40;
  double _height = 60;
  List stepperArr = [
    {'name':'提交申请', 'time':'2020-03-27 12:20:21', 'isActive': true},
    {'name':'提交审核', 'time':'2020-04-20 14:21:31', 'isActive': false},
    {'name':'提交资金预计到账', 'time':'2020-03-17 13:12:20', 'isActive': false},
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '自定义步骤条', 
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: SingleChildScrollView(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _stepperWidget(),
                
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: stepperArr.map((stepperItme)=> Container(
                        height: _height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${stepperItme['name']}'),
                            Text('${stepperItme['time']}')
                          ],
                        ),
                      ),).toList()
                    ),
                  )
                )
              ],
            ),
          ),
          // child:Column(
          //   children: _fixedHeightStepperWidget(),
          // )
        ),
      )
    );
  }

  // 固定高度的另一种写法进度条
  Widget _stepperWidget(){
    List<Widget> temp = [];
    int len=stepperArr.length; 
    for(int i=0; i<len; i++){
      double _positionBottom = 0;
      bool isShowProgress = true;
      bool isActive = stepperArr[i]['isActive'];
      if(i!=len-1){
        if(stepperArr[i]['isActive']==false){
          _positionBottom = null;
        }else if(stepperArr[i]['isActive']==true && stepperArr[i+1]['isActive']==false){
          _positionBottom = _progressHeight/2;
        }
      }else{
        isShowProgress = false;
      }
      debugPrint('_positionBottom===$_positionBottom');
      debugPrint('isShowProgress===$isShowProgress');
      debugPrint('isActive===$isActive');
      temp.add(
        Container(
          height: _height,
          child: Stack(
            children: <Widget>[
              Visibility(
                visible: isShowProgress,
                child: Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
              Visibility(
                visible: isShowProgress,
                child: Positioned(
                  left: 10,
                  top: 0,
                  bottom: _positionBottom,
                  child: Container(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
              ),
              isActive ? Container(
                  width: 22,
                  height: 22,
                  child: Image.asset('assets/images/icon_select_nom.png', fit: BoxFit.cover,) 
                ): Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey
                  ),
                ),
              // Positioned(
              //   left: 0,
              //   top: 0,
              //   child: isActive ? Container(
              //     width: 22,
              //     height: 22,
              //     color: Colors.yellow,
              //     child: Image.asset('assets/images/icon_select_nom.png', fit: BoxFit.cover,) 
              //   ): Container(
              //     width: 22,
              //     height: 22,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.grey
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    }
    return Container(
      width: 22,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(right:12),
      child: Column(
        children: temp,
      ),
    );
  }
   

  // 固定高度的进度条
  List<Widget> _fixedHeightStepperWidget(){
    List<Widget> temp = [];
    int len=stepperArr.length; 
    for(int i=0; i<len; i++){
      double progressHeight = _progressHeight;
      bool isShowProgress = true;
      bool isActive = stepperArr[i]['isActive'];
      if(i!=len-1){
        if(stepperArr[i]['isActive']==false){
          progressHeight = 0;
        }else if(stepperArr[i]['isActive']==true && stepperArr[i+1]['isActive']==false){
          progressHeight = progressHeight/2;
        }
      }else{
        isShowProgress = false;
      }
      temp.add(
        Stack(
          children: <Widget>[
            Container(
              height: _height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( 
                    margin: EdgeInsets.only(right:12),
                    height: isShowProgress ? 60 : 30,
                    width: 22,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            child: Image.asset('assets/images/${isActive ? 'icon_select_nom.png' : 'icon_select_nor.png'}', fit: BoxFit.cover,)
                          ),
                        ),
                        Visibility(
                          visible: isShowProgress,
                          child: Positioned(
                            left: 10,
                            top:20,
                            child: Container(
                              width: 2,
                              height: 40,
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isShowProgress,
                          child: Positioned(
                            left: 10,
                            top: 20,
                            child: Container(
                              width: 2,
                              height: progressHeight,
                              color: Colors.red,
                            )
                          )
                        )
                        
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${stepperArr[i]['name']}'),
                        Text('${stepperArr[i]['time']}')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return temp;
  }
}