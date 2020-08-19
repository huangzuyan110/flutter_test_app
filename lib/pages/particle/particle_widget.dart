/*
 * @Author: your name
 * @Date: 2020-08-10 11:00:22
 * @LastEditTime: 2020-08-19 10:32:18
 * @LastEditors: Please set LastEditors
 * @Description: 粒子动画
 * @FilePath: /flutter_test_app/lib/pages/particle/particle_widget.dart
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/rendering.dart';

import 'particle_model.dart';
import 'particle_painter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
class ParticlesWidget extends StatefulWidget {
  final int numberOfParticles;

  ParticlesWidget(this.numberOfParticles);

  @override
  _ParticlesWidgetState createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget> {
  final Random random = Random();

  final List<ParticleModel> particles = [];
  List imageList = [];

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _initData();
  }
  
  // 初始化动画对象个数
  void _initData(){
    List.generate(widget.numberOfParticles, (index) async{
      ui.Image image = await _loadImage('assets/images/gift${index+1}.png');
      particles.add(ParticleModel(random, defaultMilliseconds: 2000, image: image));
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
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 20),
      onTick: _simulateParticles,
      builder: (context, time) {
        _simulateParticles(time);
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}
