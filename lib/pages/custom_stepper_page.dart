import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/custom_stepper.dart';
import 'package:flutter_test_app/common/custom_stepper2.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

/**
 * 横向进度条 
 * 注意：有个问题，重写stepper后无法在 CustomStep 里，对state进行赋值
 * */

 class CustomStepperPage extends StatefulWidget {
   CustomStepperPage({Key key}) : super(key: key);
 
   @override
   _CustomStepperPageState createState() => _CustomStepperPageState();
 }
 
 class _CustomStepperPageState extends State<CustomStepperPage> {
   @override
   Widget build(BuildContext context) {
     return ScaffoldPage(
      appBarTitle: '步骤条', 
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildVerticalCustomStepper2(),
              _buildHorizontalCustomStepper(),
              _buildVerticalCustomStepper(),

            ],
          )
        ),
      )
    );
   }
 }

// 重写flutter自带的步骤条水平
Widget _buildHorizontalCustomStepper(){
  return CustomStepper(
    currentStep:0,
    type: CustomStepperType.horizontal,
    steps: ['待揽收', '已发货', '运输中', '已到达', '派送中']
        .map(
          (s) => CustomStep(title: Text(s), subtitle: Text('2020-3-20'), content: Container(), isActive: true),
    ).toList(),
    controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
      return Container();
    },
  );
}

// 重写flutter自带的步骤条垂直
Widget _buildVerticalCustomStepper(){
  return CustomStepper(
    currentStep: 2,
    type: CustomStepperType.vertical,
    steps: ['提交任务', '本金返款', '评价返佣金', '追评返佣金', '任务完结'].map((s) => CustomStep(
        title: Text(s), subtitle: Text('2020-7-8'), content: Container(), isActive: true,
      ),
    ).toList(),
    controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
      return Container(
        child: Text('dddd')
      );
    },
  );
}

_buildVerticalCustomStepper2(){
   return CustomStepper2(
    currentStep: 2,
    type: CustomStepperType2.horizontal,
    steps: ['待揽收', '已发货', '运输中', '已到达', '派送中']
        .map(
          (s) => CustomStep2(title: Text(s), subtitle: Text('2020-7-8'), content: Container(), isActive: true),
    ).toList(),
    controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
      return Container();
    },
  );
}