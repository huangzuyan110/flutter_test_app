import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';

class AutoWidthStepperPage extends StatefulWidget {
  AutoWidthStepperPage({Key key}) : super(key: key);

  @override
  _AutoWidthStepperPageState createState() => _AutoWidthStepperPageState();
}

class _AutoWidthStepperPageState extends State<AutoWidthStepperPage> {
  String _currentState = 'APPLY_SUCCESS';
  // 所有步骤
  List _stepDetails = [{
    'state': 'APPLY_RETURN',
    'class': 'APPLY_RETURN,UNDO,APPLY_SUCCESS,APPLY_SUCCESS_NOT_RETURN,SHIPPED,GOOD_RETURN,RETURNING,AGREE,REJECT,SUCCESS,FAILURE,ALREADY_PAID,CLOSED',
    'text': '申请退货'
  }, {
    'state': 'APPLY_SUCCESS',
    'class':'APPLY_SUCCESS,SHIPPED,GOOD_RETURN,APPLY_SUCCESS_NOT_RETURN,RETURNING,AGREE,REJECT,SUCCESS,FAILURE,ALREADY_PAID,CLOSED',
    'text': '审核通过'
  }, {
    'state': 'GOOD_RETURN',
    'class': 'GOOD_RETURN,RETURNING,AGREE,REJECT,SUCCESS,FAILURE,ALREADY_PAID,CLOSED',
    'text': '退货商品确认'
  }, {
    'state': 'SUCCESS',
    'class': 'SUCCESS,FAILURE,CLOSED',
    'text': '退货成功'
  }];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '高度宽度步骤条',
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF55433),
                Color(0xFFF43333)
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12, 12, 12),
                child: Text('待填写退货物流', style: TextStyle(fontSize: 16, color: Color(0xffffffff)),),
              ),
              _horizontalStepperWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Container _horizontalStepperWidget() {
    List<Widget> _temp = [];
    for(int i=0; i<_stepDetails.length; i++){
      Map<String, String> step = _stepDetails[i];
      String _tips = step['text'];
      bool _showLeft = i==0 ? false : true;
      bool _showRight = i==_stepDetails.length-1 ? false : true;
      bool _isLight = _currentStepActive(step['class'], _currentState);
      bool _isLastLight = false;
      if(_isLight && i!=_stepDetails.length-1){
        _isLastLight = _currentStepActive(_stepDetails[i+1]['class'], _currentState) ? false : true;
      }
      bool _show2Word = step['state']=='GOOD_RETURN' ? false : true;
      _temp.add(_stepChildWidget(_tips, _showLeft, _showRight, _isLight, _isLastLight, show2Word: _show2Word));
    }
    _temp.add(
      Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(left:12),
        color: Colors.yellow,
      )
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 34, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _temp,
      ),
    );
  }

  /* 售后归类 */
  bool _currentStepActive(str, state) {
    if (state == null) {
      return false;
    }
    return str.contains(state);
  }

  /* 抽出每一个步骤
   * tips: 步骤描述
   * showLeft: 显示左边线
   * showRight: 显示右边线
   * showRight: 当前步骤是否处于激活状态
   * isLastLight: 处于最后一个激活步骤
   * show2Word：步骤描述一行是否只显示两个字
   */
  Expanded _stepChildWidget(String tips,bool showLeft, bool showRight, bool isLight, bool isLastLight, { bool show2Word=true}) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(// 圆和线
              width: double.infinity,
              height: 32,
              child: LeftLineWidget(showLeft, showRight, isLight, isLastLight),
            ),
            Container(
              width: show2Word ? 24 : 48,
              child: Text(
                tips,
                style: TextStyle(fontSize: 10, color: Color(0xffffffff), letterSpacing:1),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeftLineWidget extends StatelessWidget {
  // 显示左边的线
  final bool showLeft;
  // 显示右边的线
  final bool showRight;
  // 是否高亮显示
  final bool isLight;
  // 步骤条圆圈的大小
  final double circle;
  // 处于最后一个激活步骤
  final bool isLastLight;
  const LeftLineWidget(this.showLeft, this.showRight, this.isLight, this.isLastLight, { this.circle=10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 10,
      // height: 32,
      child: CustomPaint(
        painter: LeftLinePainter(showLeft, showRight, isLight, isLastLight, circle: circle),
      ),
    );
  }
}

class LeftLinePainter extends CustomPainter {
  static const Color _lightColor = Color(0xFFFFFFFF);
  static const Color _normalColor = Color(0xFFFBB7AD);
  

  final bool showLeft;
  final bool showRight;
  final bool isLight;
  final double circle;
  final bool isLastLight;
  const LeftLinePainter(this.showLeft, this.showRight, this.isLight, this.isLastLight, { this.circle = 10.0});

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint('size===$size');
    debugPrint('isLastLight===$isLastLight');
    debugPrint('isLight===$isLight');
    
    double lineWidth = 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    
    // 圆圈上面的线（显示灰色还是红色）
    Paint linePain = Paint();
    linePain.color = showLeft ? (isLight ? _lightColor : _normalColor) : Colors.transparent;
    linePain.strokeWidth = lineWidth;
    linePain.strokeCap = StrokeCap.square;
    // 将线画在画板上
    canvas.drawLine(Offset(0, centerY), Offset(centerX, centerY), linePain);
    // 圆圈
    Paint circlePaint = Paint();
    circlePaint.color = isLight ? _lightColor : _normalColor;
    circlePaint.style = PaintingStyle.fill;
    // 圆圈下面的先显示灰色还是红色#FFFBB7AD  #FFF43333
    linePain.color = showRight ? (isLight && !isLastLight ? _lightColor : _normalColor) : Colors.transparent;
    // 将线画在画板上
    canvas.drawLine(Offset(centerX, centerY), Offset(size.width, centerY), linePain);
    // 将圆圈画在画板上
    canvas.drawCircle(Offset(centerX, centerY), circle, circlePaint);
    
    // 画勾 
    Path path = Path();
    // 第1个点, 将起始点从左上角移动到容器中心
    path.moveTo(centerX - circle/2, centerY);
    path.lineTo(centerX-1, centerY + circle/3);
    path.lineTo(centerX + circle/2, centerY-circle/4);
    linePain.color = Color(0xFFF43333);
    linePain.style = PaintingStyle.stroke;
    canvas.drawPath(path, linePain);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}