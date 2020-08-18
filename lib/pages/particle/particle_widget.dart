/*
 * @Author: your name
 * @Date: 2020-08-10 11:00:22
 * @LastEditTime: 2020-08-18 18:29:47
 * @LastEditors: Please set LastEditors
 * @Description: 粒子动画
 * @FilePath: /flutter_test_app/lib/pages/particle/particle_widget.dart
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/rendering.dart';

import 'particle_model.dart';
import 'particle_painter.dart';

class ParticlesWidget extends StatefulWidget {
  final int numberOfParticles;

  ParticlesWidget(this.numberOfParticles);

  @override
  _ParticlesWidgetState createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget> {
  final Random random = Random();

  final List<ParticleModel> particles = [];
  // List imageList = ['gift1.png', 'gift2.png', 'gift3.png', 'gift4.png', 'gift5.png', 'gift6.png'];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random, defaultMilliseconds: 2000, imageUrl: 'gift${index+1}.png'));
    });
    super.initState();
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
