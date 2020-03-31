
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'fix_tab_bar_view.dart';

class CommonSelectPage extends StatefulWidget {
  CommonSelectPage({Key key }) : super(key: key);

  @override
  _CommonSelectPageState createState() => _CommonSelectPageState();
}


class _CommonSelectPageState extends State<CommonSelectPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin  {
  @override
  bool get wantKeepAlive => true;

  GlobalKey rootKey = GlobalKey();
  TabController _tabController;
  PageController _pageController;

  int currentTabIndex = 0;

  bool isShowCity = false;  // 是否显示了市
  bool isShowArea = false; // 是否显示了区
  String priviceName = ''; // 选中了的省
  String cityName = ''; // 选中了的市
  String areaName = ''; // 选中了的区

  List provices = [{
      'code': '1',
      'name': '广东省',
      'checked': false
    },{
      'code': '2',
      'name': '广西',
      'checked': false
    },{
      'code': '3',
      'name': '北京',
      'checked': false
    }
  ];
  List citys = [
    {
      'code': '11',
      'name': '南宁市',
      'checked': false
    },{
      'code': '2',
      'name': '北海市',
      'checked': false
    },{
      'code': '3',
      'name': '河池市',
      'checked': false
    }
  ];

   List areas = [
    {
      'code': '111',
      'name': '银行区',
      'checked': false
    },{
      'code': '222',
      'name': '海城区',
      'checked': false
    }
  ];
  List bankBranchs = [
    {
      'code': '33333',
      'name': '中国银行支行',
      'checked': false
    },
    {
      'code': '44444',
      'name': '中国农行支行',
      'checked': false
    },
    {
      'code': '5555',
      'name': '中国建设银行支行',
      'checked': false
    }
  ];
  List tabArr = [
    {
      'text': '请选择',
      'metaArr': []
    }
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    tabArr[0]['metaArr']= provices;
    _tabController = TabController(length: tabArr.length, vsync: this);
    // _tabController.addListener(() {
    //   /*
    //     默认点击选项卡切换时会执行了两遍，滑动切换时正常输出一次。
    //     解决：1、增加条件判断：_tabController.index.toDouble() == _tabController.animation.value，此方法完美解决
    //          2、增加条件判断：_tabController.indexIsChanging， 但是此时文案滑����时不会再执行，只适用于tabBar禁用滑动时才能适用
    //    */

    //   if (_tabController.index.toDouble() == _tabController.animation.value) {
    //     setState(() {
    //       currentTabIndex = _tabController.index;
    //     });
    //   }
    // });
  }

   // 更新tabController
  void _updateTabController() {
    _tabController = TabController(initialIndex: currentTabIndex, length: tabArr.length, vsync: this);
    _tabController.addListener(() {
      /*
        默认点击选项卡切换时会执行了两遍，滑动切换时正常输出一次。
        解决：1、增加条件判断：_tabController.index.toDouble() == _tabController.animation.value，此方法完美解决
             2、增加条件判断：_tabController.indexIsChanging， 但是此时文案滑����时不会再执行，只适用于tabBar禁用滑动时才能适用
       */

      if (_tabController.index.toDouble() == _tabController.animation.value) {
        setState(() {
          currentTabIndex = _tabController.index;
        });
      }
    });
  }
  // 点击了头部列表项
  void _clickHeadListItem(int index){
    if(currentTabIndex==index) return;
    setState(() {
      currentTabIndex = index;
      _pageController.jumpToPage(currentTabIndex);
    });
  }
  // 点击了行
  void _clickRowData(List metaArr, int index){
    debugPrint('点击了====${metaArr[index]['name']}');
    debugPrint('当前点击了currentTabIndex===$currentTabIndex');
    // 如果是第一次选择省份，还没有城市
    setState(() {
      metaArr[index]['checked'] = true;
    });
    if(currentTabIndex==0){
      priviceName = metaArr[index]['name'];
      if(!isShowCity){
        isShowCity = true;
        setState(() {
          tabArr[0]['text'] = metaArr[index]['name'];
          tabArr.add({'text': '请选择', 'metaArr': citys});
          currentTabIndex = 1;
          _updateTabController();
          _pageController.jumpToPage(currentTabIndex);
        });
      }else{
        setState(() {
          tabArr[0]['text'] = metaArr[index]['name'];
        });
      }
      return;
    }
    if(currentTabIndex==1){
      cityName = metaArr[index]['name'];
      if(!isShowArea){
        isShowArea = true;
        setState(() {
          tabArr[1]['text'] = metaArr[index]['name'];
          tabArr.add({'text': '请选择', 'metaArr': areas});
          currentTabIndex = 2;
          _updateTabController();
          _pageController.jumpToPage(currentTabIndex);
        });
      }else{
        setState(() {
          tabArr[1]['text'] = metaArr[index]['name'];
        });
      }
      return;
    }
    if(currentTabIndex==2){
      areaName = metaArr[index]['name'];
      setState(() {
        tabArr[2]['text'] = metaArr[index]['name'];
      });
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: MediaQuery.of(context).size.height - 99,
      child: Column(
        children: <Widget>[
          // Container(
          //   color: Color(0xffffffff),
          //   child: TabBar(
          //     controller: _tabController,
          //     tabs: tabArr.map((item) {
          //       return Tab(
          //         child: Text(
          //           '${item['text']}',
          //         ),
          //       );
          //     }).toList(),
          //     labelPadding: EdgeInsets.only(left: 0, right: 0),
          //     labelStyle:
          //         TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          //     labelColor: Color(0xFFF43333),
          //     unselectedLabelColor: Color(0xFF060918),
          //     unselectedLabelStyle: TextStyle(fontSize: 14),
          //     indicatorColor: Color(0xFFFFFFFF),
          //     indicatorWeight: 3.0,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     indicatorPadding: EdgeInsets.only(
          //       left: 10.0,
          //       right: 10.0,
          //       bottom: 5.0,
          //     ),
          //     onTap: (index) {
          //       _pageController.jumpToPage(index);
          //     },
          //     // isScrollable: false,
          //   ),
          // ),

          _headListWidget(),
          Expanded(
            child: Container(
              color: Color(0xFFF3F2F5),
              child: FixTabBarView(
                pageController: _pageController,
                tabController: _tabController,
                children: tabArr.map((item) {
                  return tabView(item['metaArr']);
                }).toList(),
              ),
              // child: TabBarView(
              //   controller: _tabController,
              //   children: tabArr.map((item) {
              //     return tabView(item['metaArr']);
              //   }).toList(),
              // ),
            ),
          )
        ],
      ),
    );
  }

  // 头部
  Container _headListWidget() {
    List<Widget> temp = [];
    for(int i = 0; i<tabArr.length; i++){
      temp.add(GestureDetector(
        onTap: (){
          _clickHeadListItem(i);
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right:36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${tabArr[i]['text']}',
              ),
              Offstage(
                offstage: currentTabIndex != i,
                child: Container(
                  width: 30,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        ),
      ));
    }
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: temp
      ),
    );
  }
  // 控制是否显示每一行的勾选图标
  bool _isShowCheckedIcons(Map metaItme){
    bool isShow = false;
    switch (currentTabIndex){
      case 0:
        isShow = priviceName == metaItme['name'];
        break;
      case 1:
        isShow = cityName == metaItme['name'];
        break;
      case 2:
        isShow = areaName == metaItme['name'];
        break;
    }
    return isShow;
  }

  /* tab切换容器 */
  Widget tabView(List metaArr) {
    return ListView.builder(
      itemCount: metaArr.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            _clickRowData(metaArr,index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Offstage(
                offstage: !_isShowCheckedIcons(metaArr[index]),
                child: Icon(Icons.check_circle),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.red, width: 1)
                    )
                  ),
                  child: Text('${metaArr[index]['name']}'),
                ),
              )
            ],
          ),
        );
      },
    ); 
  }


}