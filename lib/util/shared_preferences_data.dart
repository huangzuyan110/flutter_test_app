/*
 * @Descripttion: 
 * @Author: huangzuyan
 * @Date: 2021-01-19 11:53:39
 */
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/* 储存数据公用类 */
class PublicSharedPreferences {
  /* 删除指定数据 */
  static publicDeleteData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
    // TblLogUtil.d('删除key===$key');
  }

  /* 储存指定数据
    key: 要存储的字段key
    value: 要存储的key对应的值
    type: 存储的value是什么类型 bool、string、int、double、stringList
  */
  static publicSaveData(String key, dynamic value, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case 'bool':
        prefs.setBool(key, value);
        break;
      case 'string':
        prefs.setString(key, value);
        break;
      case 'int':
        prefs.setInt(key, value);
        break;
      case 'double':
        prefs.setDouble(key, value);
        break;
      case 'stringList':
        prefs.setStringList(key, value);
        break;
    }
  }

  /* 获取用户指定数据 
  key: 要获取的字段key
  defualtValue: 当获取的key对应的值没找到时的默认值
  type: 获取的value是什么类型
  */
  static Future<dynamic> publicLoadData(
      String key, dynamic errorDefualtValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic returnValue = prefs.get(key) ?? errorDefualtValue;
    // TblLogUtil.d('key===$key, returnValue===$returnValue');
    return returnValue;
  }

  /*
   * 储存指定字段数据，并存储改字段保存时的时间戳
   * key: 储存字段
   * value: key对应的值
   * timeKey：储存key对应的时间戳字段
   * type: key对应的字段类型
   * */
  static Future saveKeyAndTimestamp(String key, dynamic value, String timeKey, String type) async {
    PublicSharedPreferences.publicSaveData(key, value, type);
    DateTime time = new DateTime.now();
    // TblLogUtil.d('获取进入保存$key 当前时间====$time');
    // TblLogUtil.d('获取进入保存$key 当前时间戳(毫秒)====${time.millisecondsSinceEpoch}');

    // 存储保存当前字段的时间戳
    PublicSharedPreferences.publicSaveData(timeKey, time.millisecondsSinceEpoch, 'int');
  }

  /*
   * 获取指定字段储存时的时间戳, 如果达到指定时间，删除该字段
   * key: 获取字段
   * timeKey：获取储存字段key时对应的储存的时间戳
   * milliseconds: 指定时间:单位毫秒（删除key字段）
   * */
  static Future loadKeyTimestampThenDelete(String key, String timeKey, {int milliseconds=24*60*60*1000}) async{
    int oldTimestamp = await PublicSharedPreferences.publicLoadData(timeKey, -1);
    // 如果之前还没有存储有该时间戳，直接return
    if(oldTimestamp==-1) return;
    DateTime currentTimestamp = new DateTime.now();
    // TblLogUtil.d('时间间隔毫秒数===${currentTimestamp.millisecondsSinceEpoch-oldTimestamp}');
    if((currentTimestamp.millisecondsSinceEpoch-oldTimestamp)>=milliseconds){
      PublicSharedPreferences.publicDeleteData(key);
      PublicSharedPreferences.publicDeleteData(timeKey);
    }
  }

  // 获取用户升级级别
  static Future<int> getLevel(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int level = prefs.get('$id') ?? -1;
    return level;
  }

  // 设置用户升级级别
  static setLevel(id, int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('$id', level);
  }

  // 获取用户是否是第一次进入
  static Future<bool> getIsFirstUse(use) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstUse = prefs.get(use) ?? false;
    return firstUse;
  }

}


