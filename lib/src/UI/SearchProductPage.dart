import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Models/ModelSearch.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/UI/MainCategoryPage.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ProductPage.dart';

class SearchProductPage extends StatefulWidget {
  String search;
  @override
  _PageState createState() => _PageState();

  SearchProductPage.set(this.search);
}

class _PageState extends State<SearchProductPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  late RestDatasource api;
  int _radioValue = -1;
  late SessionManager session;
  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }
  Future AddToSearchSaved(String value) async {
    List<ModelSearch> oldList = [];
    if (await session.readSearchSavedSize() != null) oldList.addAll(await session.getFromSearchSaved());
    oldList.add(new ModelSearch(value));
    await session.AddToSearchSaved(ModelSearch.encode(oldList));
    oldList.clear();
    Fluttertoast.showToast(msg: "Search Saved Successfully");
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        widget.search,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _appBar(),
        endDrawer: _drawerFilter(),
        body: Column(
          children: [
            Card(
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            ),
                            TextButton(
                              child: Text(
                                "Save this Search",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () => {AddToSearchSaved(widget.search)},
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sort,
                              color: Colors.blue,
                            ),
                            TextButton(
                              child: Text(
                                "Sort",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () => {_Sort()},
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.blue,
                            ),
                            TextButton(
                              child: Text(
                                "Filter",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () => {_scaffoldKey.currentState?.openEndDrawer()},
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            DidUMean(),
            FutureBuilder(
                future: api.getProduct(context),
                builder: (context, data) {
                  if (data.hasData) {
                    List<ModelProduct> list = data.data as List<ModelProduct>? ?? [];
                    return Expanded(
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(list[index])))},
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Card(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        FadeInImage(
                                          placeholder: AssetImage('images/logo.png'),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
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

  Widget DidUMean() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Text.rich(TextSpan(text: 'Did you mean:', style: TextStyle(fontSize: 16, color: Colors.blueGrey), children: <TextSpan>[
          TextSpan(
              text: ' ${widget.search}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pop(context);
                }),
          TextSpan(
            text: ' (17 items)?',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          )
        ])));
  }

  Future _Sort() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 500,
          color: Colors.transparent,
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
              child: SingleChildScrollView(
                  child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Sort",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Best Match"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Lowest Price + Shipping"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Highest Price + Shipping"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 4,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Ending Soonest"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 5,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Newly Listed"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 8,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Distant: Nearest First"),
                      ],
                    ),
                  ],
                ),
              ))),
        );
      },
    );
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value ?? _radioValue;
      Navigator.pop(context);
    });
  }

  Widget _drawerFilter() {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Filter",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Reset",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Sort'),
            subtitle: Text('Price + Shipping: low, High'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
              _Sort();
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Buying Format'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Condition'),
            subtitle: Text('New'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Price'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Category'),
            subtitle: Text('Cell Phones'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainCategoryPage()));
            },
          ),
          _child_category(),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Storage Capacity'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Lock Status'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    ));
  }

  Widget _child_category() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 40.0,
        child: FutureBuilder(
            future: api.getCategory(context),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelCategory> category = data.data as List<ModelCategory>? ?? [];
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage.set(category: category[index])))},
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey[200]),
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
                            )),
                      );
                    });
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
