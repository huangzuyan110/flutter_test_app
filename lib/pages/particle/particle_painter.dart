/*
 * @Author: your name
 * @Date: 2020-08-18 17:21:57
 * @LastEditTime: 2020-08-18 17:35:50
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /flutter_test_app/lib/pages/particle/particle_painter.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/particle/particle_model.dart';
class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;
  Color color;

  ParticlePainter(this.particles, this.time, {this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    // 有透明度画笔
    final paint = Paint()..color = color.withAlpha(50);
    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
