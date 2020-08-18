/*
 * @Author: your name
 * @Date: 2020-08-18 16:38:57
 * @LastEditTime: 2020-08-18 16:57:00
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flutter_test_app/lib/pages/paint/image_paint_widget.dart
 */
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImagePaint extends CustomPainter{
  Paint _paint;
  ui.Image _image;

  ImagePaint() { 
    _paint = Paint();
    _loadImage('assets/images/icon_home_select.png').then((res) {
      _image = res;
    });
  }

  /// 加载图片
  Future<ui.Image> _loadImage(String path) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var info = await codec.getNextFrame();
    return info.image;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_image != null) {
      canvas.drawImage(_image, Offset(0, 0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}