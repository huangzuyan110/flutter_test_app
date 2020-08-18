/*
 * @Author: your name
 * @Date: 2020-08-10 11:00:22
 * @LastEditTime: 2020-08-18 17:35:18
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /gsy_github_app_flutter-master/lib/widget/particle/particle_model.dart
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/animation_progress.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;
  int defaultMilliseconds;

  ParticleModel(this.random, {this.defaultMilliseconds = 500}) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    // 底部选择一个随机的起始位置
    // final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);

    // 固定一个起始位置
    final startPosition = Offset(0.5, 1.2);
    // 顶部选择一个随机的目标位置
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);

    final duration =
        Duration(milliseconds: defaultMilliseconds + random.nextInt(1000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    // 随机速度
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    // 随机大小
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}
