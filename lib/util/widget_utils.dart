/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2021-01-05 11:24:42
 */
import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/utils.dart';
///返回text 组件
Widget getTextWidget(double textSize, String text,
    {
    Color textColor = Colors.black,
    FontWeight fontWeight,
    TextDecoration decoration,
    TextOverflow overflow,
    Key key,
    int maxLines,
    double height,
    TextAlign textAlign = TextAlign.left}) {
  return Text(
    text,
    key: key,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
        decoration: decoration,
        color: textColor,
        fontSize: textSize,
        fontWeight: fontWeight,
        height: height),
  );
}

///返回价格 组件
Widget getPriceWidget(double textSize, double price, Color textColor,{double dollarFontSize}) {
  String priceLeft;
  String priceRight;
  if (price == null) {
    priceLeft = "00";
    priceRight = "00";
  } else {
    if (price.toString().contains(".")) {
      List priceS = price.toStringAsFixed(2).split(".");
      priceLeft = priceS[0];
      priceRight = priceS[1];
    } else {
      priceLeft = price.toString();
      priceRight = "00";
    }
  }
  return Container(
      child: Text.rich(
    TextSpan(children: [
      TextSpan(
        text: '￥',
        style: TextStyle(
            color: textColor == null ? hexToColor('#F43333') : textColor,
            fontSize:dollarFontSize!=null&&dollarFontSize>0? dollarFontSize:textSize - 4,
            fontWeight: FontWeight.w500),
      ),
      TextSpan(
        text: priceLeft,
        style: TextStyle(
            color: textColor == null ? hexToColor('#F43333') : textColor,
            fontSize: textSize,
            fontWeight: FontWeight.w500),
      ),
      TextSpan(
        text: "." + priceRight,
        style: TextStyle(
            color: textColor == null ? hexToColor('#F43333') : textColor,
            fontSize: dollarFontSize!=null&&dollarFontSize>0? dollarFontSize:textSize - 4,
            fontWeight: FontWeight.w500),
      )
    ]),
  ));
}

///获取圆角容器Container
Widget getRadiusContainer(Color color, double radius,
    {double width,
    double height,
    Widget child,
    EdgeInsets margin,
    Alignment alignment,
    EdgeInsets padding}) {
  return Container(
      height: height,
      width: width,
      child: child,
      margin: margin,
      padding: padding,
      alignment: alignment == null ? Alignment.center : alignment,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))));
}

///获取圆角容器 (有阴影/背景图片 )Container
Widget getShadowRadiusContainer(Color color, double radius,
    {double width,
    double height,
    Widget child,
    EdgeInsets margin,
    AssetImage img}) {
  return Container(
      height: height,
      width: width,
      child: child,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: img != null ? null : color,
          image: DecorationImage(
            image: img,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffD8D8D8),
              spreadRadius: 5.0,
              offset: Offset(3.0, 3.0),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(radius))));
}