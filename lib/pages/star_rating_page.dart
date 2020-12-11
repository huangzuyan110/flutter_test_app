/*
 * @Descripttion: 星级评分
 * @Author: huangzuyan
 * @Date: 2020-12-10 16:09:22
 */

import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/scaffold_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StarRatingPage extends StatefulWidget {
  StarRatingPage({Key key}) : super(key: key);

  @override
  _StarRatingPageState createState() => _StarRatingPageState();
}

class _StarRatingPageState extends State<StarRatingPage> {
  double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '星级评分',
      child: Column(
        children: [
          Text('可以评半分'),
          Center(
            child: SmoothStarRating(
              rating: rating,
              isReadOnly: false,
              size: 80,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: true,
              spacing: 2.0,
              onRated: (value) {
                print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            )
          ),

          Text('只能评整分'),
          Center(
            child: SmoothStarRating(
              rating: rating,
              isReadOnly: false,
              size: 80,
              filledIconData: Icons.star,
              color: Colors.orange,
              borderColor: Colors.orange,
              starCount: 5,
              allowHalfRating: false,
              spacing: 0.0,
              onRated: (value) {
                print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            )
          ),
          Text('只能看不能评分'),
          Center(
            child: SmoothStarRating(
              rating: rating,
              isReadOnly: true,
              size: 80,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Colors.pinkAccent,
              borderColor: Colors.pinkAccent,
              starCount: 5,
              allowHalfRating: false,
              spacing: 0.0,
              onRated: (value) {
                print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            )
          ),
          Center(
            child: SmoothStarRating(
              rating: rating,
              isReadOnly: false,
              size: 80,
              filledIconData: Icons.sentiment_satisfied,
              defaultIconData: Icons.sentiment_satisfied,
              color: Colors.pinkAccent,
              borderColor: Colors.grey,
              starCount: 5,
              allowHalfRating: false,
              spacing: 0.0,
              onRated: (value) {
                print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            )
          )
        ],
      )
    );
  }
}
