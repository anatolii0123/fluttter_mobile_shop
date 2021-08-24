import 'package:cms_manhattan/src/Models/ModelCategory.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProductPage extends StatefulWidget {
  ModelCategory category;

  @override
  _PageState createState() => _PageState();

  ProductPage();

  ProductPage.set(this.category);
}

class _PageState extends State<ProductPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;
  RestDatasource api;

  _PageState() {
    api = new RestDatasource();
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        widget.category.cat_name,
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: widget.category != null ? _appBar() : null,
        body: Column(
          children: [
            _Search(),
            _child_category(context),
            FutureBuilder(
                future: api.getProduct(context),
                builder: (context, data) {
                  if (data.hasData) {
                    List<ModelProduct> list = data.data;
                    return Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsPage.set(
                                                      list[index])))
                                    },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Card(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FadeInImage(
                                          placeholder:
                                              AssetImage('images/logo.png'),
                                          image: NetworkImage(
                                            list[index].image,
                                          ),
                                          width: 100.0,
                                          height: 80,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[index].name,
                                              maxLines: 1,
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              list[index].short_des,
                                              maxLines: 2,
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ), //*
                                            RatingBar.builder(
                                              initialRating: list[index].rating,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 10,
                                              itemSize: 15,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  list[index].price,
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  list[index].cut_off,
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _Search() {
    return Container(
      padding: EdgeInsets.all(5.0),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200]),
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Icon(Icons.search),
          Container(
            width: MediaQuery.of(context).size.width * 0.66,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              "Search for a...",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            widthFactor: 1,
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              children: [
                Icon(Icons.mic_outlined),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.camera_alt_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _child_category(dis) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 40.0,
        child: FutureBuilder(
            future: api.getCategory(dis),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelCategory> category = data.data;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[200]),
                          child: Row(
                            children: [
                              FadeInImage(
                                placeholder: AssetImage('images/logo.png'),
                                image: NetworkImage(
                                  category[index].image,
                                ),
                                height: 40.0,
                                width: 40.0,
                              ),
                              Text(
                                category[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ));
                    });
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
