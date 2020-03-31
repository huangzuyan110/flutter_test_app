import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  double _dx;
  double _dy;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 10.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward(from: 100);
  }

  void _onTapUp(TapUpDetails details) {
    //_controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    _dx = _controller.value;
    _dy = 0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      /* child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ), */
      child: Transform.translate(
        offset:Offset(_dx,_dy),
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 80,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      boxShadow: [
        BoxShadow(
          color: Color(0x80000000),
          blurRadius: 30.0,
          offset: Offset(0.0, 30.0),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFA7BFE8),
          Color(0xFF6190E8),
        ],
      ),
    ),
    child: Center(
      child: Text(
        'tap!',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
