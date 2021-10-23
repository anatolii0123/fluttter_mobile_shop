import 'package:cms_manhattan_project/src/Models/ModelOrder.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/UI/OrderFeedbackPage.dart';
import 'package:cms_manhattan_project/src/UI/OrderTrackingPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ProductDetailsPage.dart';

class PurchasesPage extends StatefulWidget {
  String? title;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PurchasesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isSelectDate = false;
  bool isSearchEnable = false;
  late RestDatasource api;
  String searchText = "", searchText2 = "";
  String FramDate = "From Date", ToDate = "To Date";
  int FramPrice = 0, ToPrice = 0;
  _PageState() {
    api = new RestDatasource();
  }
  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        widget.title ?? '',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.filter_alt_outlined,
            size: 30,
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: Stack(
            children: [
              Column(
                children: [
                  _Search(),
                  FutureBuilder(
                      future: api.getOrderHistorySearch(context, searchText2,
                          from_price: FramPrice, to_price: ToPrice, from_date: FramDate, to_date: ToDate),
                      builder: (context, data) {
                        if (data.hasData) {
                          List<ModelOrder> list = data.data as List<ModelOrder>? ?? [];
                          return Expanded(
                            child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _Order(list[index]);
                                }),
                          );
                        } else if (data.hasError) {
                          return Expanded(
                              child: Column(
                            children: [
                              Image.asset(
                                'images/card_icon.png',
                                width: 150,
                              ),
                              Flexible(
                                child: Text(
                                  "You Don't have any purchases",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.blueGrey[300],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              )
            ],
          )),
    );
  }

  Widget _Search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey[100]),
      margin: EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
          ),
          Expanded(
            child: isSelectDate
                ? Text(searchText)
                : TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search by payment id, order id, name...",
                      hintStyle: new TextStyle(color: Colors.black),
                    ),
                    onChanged: (text) {
                      setState(() {
                        searchText2 = text;
                      });
                    },
                    minLines: 1,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                      backgroundColor: Colors.grey[100],
                    ),
                  ),
          ),
          IconButton(
              onPressed: () {
                if (isSelectDate) {
                  setState(() {
                    searchText = "";
                    searchText2 = "";
                    FramDate = "From Date";
                    ToDate = "To Date";
                    FramPrice = 0;
                    ToPrice = 0;
                    isSelectDate = false;
                  });
                } else {
                  _Filter();
                }
              },
              icon: Icon(isSelectDate ? Icons.close : Icons.filter_alt_outlined))
        ],
      ),
    );
  }

  Future _selectDate(i) async {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(2020),
            //what will be the previous supported year in picker
            lastDate: DateTime.now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return "";
      }
      final DateFormat formatter = DateFormat('M/d/yyyy');
      String date = formatter.format(pickedDate);
      setState(() {
        if (i == 1) {
          searchText = date;
          FramDate = date;
        } else {
          ToDate = date;
          searchText = '$FramDate TO $ToDate';
        }
      });
      _Filter();
    });
  }

  Widget _SearchResult() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        FutureBuilder(
            future: api.getOrderHistorySearch(context, searchText),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelOrder> suggestion = data.data as List<ModelOrder>? ?? [];
                if (suggestion.isEmpty) {
                  return Center(
                      child: Column(
                    children: [Image.asset('images/card_icon.png'), Text('No Result found!')],
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: suggestion.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _Order(suggestion[index]);
                      }),
                );
              } else if (data.hasError) {
                return Center(
                    child: Column(
                  children: [Image.asset('images/card_icon.png'), Text('No Result found!')],
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ]),
    );
  }

  Widget _Order(ModelOrder order) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
          child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    order.date,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Order ID: ${order.order_id}",
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Payment ID: ${order.payment_id}",
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage(
                  placeholder: AssetImage('images/logo.png'),
                  image: NetworkImage(
                    order.image,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "images/logo.png",
                      height: 80,
                      width: 100,
                    );
                  },
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
                      order.name,
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
                      order.description,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ), //*
                    Row(
                      children: [
                        Text(
                          order.price,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          order.cut_off,
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
                    Text(
                      'Free Shipping',
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ))
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingPage.setOrder(order)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.blue),
                            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
                            color: Colors.white),
                        child: Text(
                          'Track Package',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      )),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        ModelOrder or = order;
                        ModelProduct pr =
                            new ModelProduct(or.id, or.name, or.description, '1', or.price, or.cut_off, or.description, or.image, 5, "Seller", "3");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(pr)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.blue),
                            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
                            color: Colors.white),
                        child: Text(
                          'Buy Again',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      )),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderFeedbackPage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.blue), color: Colors.white),
                        child: Text(
                          'Feedback',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  Future _Filter() {
    setState(() {
      isSelectDate = true;
    });
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextButton(
                                child: Text(
                                  FramDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _selectDate(1);
                                },
                              )),
                          Expanded(
                              flex: 1,
                              child: TextButton(
                                child: Text(
                                  ToDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _selectDate(2);
                                },
                              ))
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Select Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "From Price",
                                hintStyle: new TextStyle(color: Colors.black),
                              ),
                              onChanged: (text) {
                                this.setState(() {
                                  FramPrice = int.parse(text);
                                  if (!ToPrice.isNaN) {
                                    searchText = '$FramPrice To $ToPrice';
                                  } else {
                                    searchText = text;
                                  }
                                });
                              },
                              minLines: 1,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black,
                                backgroundColor: Colors.grey[100],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "To Price",
                                hintStyle: new TextStyle(color: Colors.black),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  ToPrice = int.parse(text);
                                  if (!FramPrice.isNaN) {
                                    searchText = '$FramPrice To $ToPrice';
                                  }
                                });
                              },
                              minLines: 1,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black,
                                backgroundColor: Colors.grey[100],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        child: OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Filter",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
