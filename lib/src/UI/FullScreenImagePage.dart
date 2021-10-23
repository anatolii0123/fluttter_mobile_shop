import 'package:carousel_slider/carousel_slider.dart';
import 'package:cms_manhattan_project/src/Models/ModelOrder.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatPage.dart';

class FullScreenImagePage extends StatefulWidget {
  ModelProduct product;
  ModelOrder? order;
  @override
  _PageState createState() => _PageState();

  FullScreenImagePage.set(this.product);
}

class _PageState extends State<FullScreenImagePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isGrid = false;
  int seletedIndex = 0;

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        '${seletedIndex + 1} of 5',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () => {
                  setState(() => {isGrid = !isGrid}),
                },
            icon: isGrid ? Icon(Icons.linear_scale) : Icon(Icons.grid_view))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: Container(padding: EdgeInsets.only(top: 5), child: isGrid ? GridList() : Slider())),
    );
  }

  Widget Slider() {
    final height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        initialPage: seletedIndex,
        onPageChanged: (page, val) => {
          setState(() => {seletedIndex = page})
        },
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Image.asset('images/image_1.png'));
          },
        );
      }).toList(),
    );
  }

  Widget GridList() {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(5, (index) {
        return Center(
            child: InkWell(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Image.asset('images/image_1.png')),
          onTap: () => {
            setState(() => {isGrid = !isGrid, seletedIndex = index}),
          },
        ));
      }),
    );
  }
}
