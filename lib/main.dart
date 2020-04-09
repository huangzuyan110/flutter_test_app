import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_page.dart';
import 'home_page.dart';
import 'personal_center_page.dart';
import 'product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '测试项目',
      theme: ThemeData(
        primaryColor: Color(0xFFF43333),
      ),
      home: MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {

  int _selected = 0;
  
  // 显示直播间按钮， 默认true:显示
  bool isShowLiveBotton = true;
  @override
  void initState() {
    super.initState();
  }


  void _onItemTap(int index) {
    if (_selected != index) {
      setState(() {
        debugPrint('select tab $index');
        _selected = index;
      });
    }
  }

  Widget _selectPage(){
    switch(_selected) {
      case 0:
        return HomePage();
      case 1:
       return ProductPage();
      case 2:
        return CartPage();
      case 3:
        return PersonalCenterPage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return  Scaffold(
        body: _selectPage(),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTap,
        currentIndex: _selected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.shop), title: Text('产品')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), title: Text('我的')),
        ],
      )
    );
  }
}

/* class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '团巴拉',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: TblApp(),
    );
  }
}

class TblApp extends StatefulWidget {
  TblApp({Key key}) : super(key: key);

  _TblAppState createState() => _TblAppState();
}

class _TblAppState extends State<TblApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ddd"),
      ),
      body: Container(
        child: Scaffold(
          appBar: AppBar(title: Text("dd22"),),
          body: Container(
            child: Text("内容22"),
          )
        ),
      ),
    );
  }
}


class TblApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "团巴啦",
      // debugShowCheckedModeBanner:false, //隐藏debug
      home: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: Image.asset("images/shoppingcar+sel@2x.png"),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: Column(
              children: <Widget>[
                Container(
                  height: 30,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFFF7B90),
                  Color.fromRGBO(254, 69, 69, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
                onPressed: null,
              ),
            ],
          ),
          body: Container(
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('左'),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text('sdasd'),
                  ),
                ),
                Text('右11'),
              ],
            ),
          )),
    );
  }
}
 */



