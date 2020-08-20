import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/particle/particle_widget.dart';

import 'common/scaffold_page.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List products = [
    {'id':1, 'name':'商品1', },
    {'id':2, 'name':'商品11', },
    {'id':3, 'name':'商品12', },
    {'id':4, 'name':'商品13', },
    {'id':5, 'name':'商品14', },
    {'id':1, 'name':'商品15', },
    {'id':6, 'name':'商品16', },
    {'id':11, 'name':'商品17', },
    {'id':12, 'name':'商品18', },
    {'id':13, 'name':'商品19', },
    {'id':14, 'name':'商品122', },
    {'id':15, 'name':'商品1223', },
    {'id':16, 'name':'商品144', },
    {'id':1, 'name':'商品1', },
    {'id':2, 'name':'商品11', },
    {'id':3, 'name':'商品12', },
    {'id':4, 'name':'商品13', },
    {'id':5, 'name':'商品14', },
    {'id':1, 'name':'商品15', },
    {'id':6, 'name':'商品16', },
    {'id':11, 'name':'商品17', },
    {'id':12, 'name':'商品18', },
    {'id':13, 'name':'商品19', },
    {'id':14, 'name':'商品122', },
    {'id':15, 'name':'商品1223', },
    {'id':16, 'name':'商品144', },
  ];
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBarTitle: '产品列表',
      child: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                
              ],
              title: Text('SliverAppBar'),
              backgroundColor: Theme.of(context).accentColor,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/images/homepagedrag.png', fit: BoxFit.cover),
              ),
              // floating: true,  // true: 一旦有下拉就展开
              // snap: true,
              // pinned: true, 
            ),

            // 单列数量不明确
            // SliverList(
            //   delegate:SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return _buildItem(products[index]);
            //     },
            //     childCount: 2,
            //   ),
            // ),

            // 单列数量明确，并且最好不超过一屏
            // _singleColumnLayout(),

            SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:150,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildItem(products[index]);
                },
                childCount: products.length,
              ),
            )
          ]
        ),
      ),
    );
  }

  // 单列布局
  SliverFixedExtentList _singleColumnLayout() {
    return SliverFixedExtentList(
      itemExtent: 180.0,
      delegate: SliverChildListDelegate(
        products.map((product) {
          return _buildItem(product);
        }).toList(),
      ),
    );
  }


  Widget _buildItem(Map product){
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.pink,
      child: Stack(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            color: Colors.lightGreen,
          ),
          Text('${product['name']}'),
          // 动画铺满容器
          // Positioned.fill(
          //   child: ParticlesWidget(6)
          // ),
          Positioned(
            left: 0,
            right: 50,
            bottom: 0,
            top: 0,
            child: ParticlesWidget(6)
          ),
        ],
      ),
    );
  }
}