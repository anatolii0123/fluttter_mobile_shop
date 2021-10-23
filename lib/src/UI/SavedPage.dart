import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Models/ModelSearch.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/UI/ProductPage.dart';
import 'package:cms_manhattan_project/src/UI/SearchProductPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'PaymentPage.dart';

class SavedPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SavedPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ModelSearch> SavedSearchList = [];
  List<String>? list;
  bool isLoading = false;
  List<String> qty = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List<ModelProduct> oldList = [];
  List<ModelProduct> oldListFeed = [];
  late RestDatasource api;
  late SessionManager session;
  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }
  Future Remove(value) async {
    oldList.remove(value);
    if (oldList.isNotEmpty) {
      await session.AddToSaved(ModelProduct.encode(oldList));
    } else {
      await session.remove("saved");
    }
    setState(() {});
  }

  Future RemoveFeed(value) async {
    oldListFeed.remove(value);
    if (oldListFeed.isNotEmpty) {
      await session.AddToFeed(ModelProduct.encode(oldListFeed));
    } else {
      await session.remove("feed");
    }
    setState(() {});
  }

  Future RemoveSearchSaved(value) async {
    SavedSearchList.remove(value);
    if (SavedSearchList.isNotEmpty) {
      await session.AddToSearchSaved(ModelSearch.encode(SavedSearchList));
    } else {
      await session.remove("search_saved");
    }
    setState(() {});
  }

  PreferredSizeWidget _appBar() {
    return TabBar(
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.blueGrey[200],
      tabs: [
        Tab(
          child: Text(
            "Searches List",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            "Sellers",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            "Feed",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      // Added
      length: 3, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _appBar(),
        body: TabBarView(
          children: [
            _SavedSearch(),
            _Sellers(),
            _Feed(),
          ],
        ),
      ),
    );
  }

  Widget _Searches() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  "Save Searches",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Save a search to update when new item are listed that match your criteria.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.blueGrey[300],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset("images/list.png")
            ],
          ),
        ));
  }

  Widget _Sellers() {
    return FutureBuilder(
        future: session.getFromSaved(),
        builder: (context, data) {
          if (data.hasData) {
            oldList = data.data as List<ModelProduct>? ?? [];
            return Expanded(
              child: ListView.builder(
                  itemCount: oldList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ModelProduct product = oldList[index];
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: InkWell(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Text(
                                            'Seller: ${product.sellar_name}',
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: PopupMenuButton<String>(
                                              icon: Icon(Icons.more_vert),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: "onClick",
                                                  child: Text('Pay only this seller'),
                                                ),
                                              ],
                                              onSelected: (Str) => {Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()))},
                                            )),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: FadeInImage(
                                              placeholder: AssetImage('images/logo.png'),
                                              image: NetworkImage(product.image),
                                              fit: BoxFit.cover,
                                              height: 80.0,
                                              width: 80.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'New',
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                product.price,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                'Shipping ${product.shipping_charge}',
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            dropdownColor: Colors.white,
                                            value: product.qty,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            elevation: 16,
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? data) {
                                              setState(() {
                                                product.qty = data ?? product.qty;
                                              });
                                            },
                                            items: qty.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  'Qty: $value',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextButton(
                                            child: Text(
                                              'View',
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onPressed: () =>
                                                {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(product)))},
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextButton(
                                            child: Text(
                                              'Remove',
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onPressed: () => {
                                              setState(() {
                                                Remove(product);
                                              }),
                                              Fluttertoast.showToast(msg: "Remove item Successfully"),
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )));
                  }),
            );
          } else if (data.hasError) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      "Save Sellers",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Save Sellers to quickly see what they're selling or collecting.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.blueGrey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset("images/list.png")
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _Feed() {
    return FutureBuilder(
        future: session.getFromFeed(),
        builder: (context, data) {
          if (data.hasData) {
            oldListFeed = data.data as List<ModelProduct>? ?? [];
            return Expanded(
              child: ListView.builder(
                  itemCount: oldListFeed.length,
                  itemBuilder: (BuildContext context, int index) {
                    ModelProduct product = oldListFeed[index];
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: InkWell(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Text(
                                            'Seller: ${product.sellar_name}',
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: PopupMenuButton<String>(
                                              icon: Icon(Icons.more_vert),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: "onClick",
                                                  child: Text('Pay only this seller'),
                                                ),
                                              ],
                                              onSelected: (Str) => {Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()))},
                                            )),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: FadeInImage(
                                              placeholder: AssetImage('images/logo.png'),
                                              image: NetworkImage(product.image),
                                              fit: BoxFit.cover,
                                              height: 80.0,
                                              width: 80.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'New',
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                product.price,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                'Shipping ${product.shipping_charge}',
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            dropdownColor: Colors.white,
                                            value: product.qty,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            elevation: 16,
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? data) {
                                              setState(() {
                                                product.qty = data ?? product.qty;
                                              });
                                            },
                                            items: qty.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  'Qty: $value',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextButton(
                                            child: Text(
                                              'View',
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onPressed: () =>
                                                {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(product)))},
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextButton(
                                            child: Text(
                                              'Remove',
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onPressed: () => {
                                              setState(() {
                                                RemoveFeed(product);
                                              }),
                                              Fluttertoast.showToast(msg: "Remove item Successfully"),
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )));
                  }),
            );
          } else if (data.hasError) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      "Welcome to your feed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "New item you save searches and sellers will show up here as soon they'er listed.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.blueGrey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset("images/feed.png")
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _SavedSearch() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        FutureBuilder(
            future: session.getFromSearchSaved(),
            builder: (context, data) {
              if (data.hasData) {
                SavedSearchList = data.data as List<ModelSearch>? ?? [];
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: SavedSearchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(SavedSearchList[index].key),
                        tileColor: Colors.white,
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            RemoveSearchSaved(SavedSearchList[index]);
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductPage.set(
                                searchString: SavedSearchList[index].key,
                                productPageType: ProductPageType.Search,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (data.hasError) {
                return Center(child: Text('No saved search found'));
              } else {
                return Center(child: Text('No saved search found'));
              }
            }),
      ]),
    );
  }
}
