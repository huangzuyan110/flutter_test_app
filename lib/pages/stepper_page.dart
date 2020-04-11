import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/custom_stepper_page.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class StepperPage extends StatefulWidget {
  StepperPage({Key key}) : super(key: key);

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '步骤条', 
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildCustomStepper(),
            ],
          )
        ),
      )
    );
  }

  // 重写flutter自带的步骤条
  Widget _buildCustomStepper(){
    return CustomStepper(
      currentStep: 2,
      type: CustomStepperType.vertical,
      steps: ['提交任务', '本金返款', '评价返佣金', '追评返佣金', '任务完结']
          .map(
            (s) => CustomStep(title: Text(s), subtitle: Text('2020-3-20'), content: Container(), isActive: true),
      ).toList(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container(
          child: Text('dddd')
        );
      },
    );
  }
  
}