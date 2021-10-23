import 'package:carousel_slider/carousel_slider.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/UI/AddOfferPage.dart';
import 'package:cms_manhattan_project/src/UI/CartPage.dart';
import 'package:cms_manhattan_project/src/UI/FullScreenImagePage.dart';
import 'package:cms_manhattan_project/src/UI/PostItemPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ChatPage.dart';

class ProductDetailsPage extends StatefulWidget {
  ModelProduct product;
  @override
  _PageState createState() => _PageState();

  ProductDetailsPage.set(this.product);
}

class _PageState extends State<ProductDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  bool isFav = false;
  String SelectedSize = 'Size', SelectedColor = 'Color';
  late RestDatasource api;
  late SessionManager session;
  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }
  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        widget.product.name,
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PostItemPage(isEdit: true),
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(context),
          body: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 250.0),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: InkWell(
                              child: Image.asset('images/image_1.png'),
                              onTap: () =>
                                  {Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImagePage.set(widget.product)))},
                            ));
                      },
                    );
                  }).toList(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: SelectedSize,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: <String>['Size', '30', '40', '50'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              SelectedSize = value ?? SelectedSize;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: SelectedColor,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: <String>['Color', 'Black', 'White', 'Red'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              SelectedColor = value ?? SelectedColor;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                setState(() {
                                  isFav = !isFav;
                                });
                                if (isFav) {
                                  AddToFeed();
                                } else {
                                  RemoveToFeed();
                                }
                              },
                            )))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        maxLines: 1,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RatingBar.builder(
                        initialRating: widget.product.rating,
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.product.price} +shipping",
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
                            widget.product.cut_off,
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

                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        widget.product.short_des,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ), //*
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.product.description,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                _BuyNowButton(),
                _AddToCartButton(),
                _MakeOffer(),
                _Message(),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Text(
                    "You can also like this",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
                _product(),
              ],
            ),
          )),
    );
  }

  Widget _BuyNowButton() {
    return InkWell(
      onTap: () => {AddTocart(), Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()))},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.blue),
        child: Text(
          Languages.of(context).BuyNow,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Future AddTocart() async {
    List<ModelProduct> oldList = [];
    if (await session.readCartSize() != null) oldList.addAll(await session.getFromCart());
    oldList.add(widget.product);
    await session.AddToCart(ModelProduct.encode(oldList));
    oldList.clear();
  }

  Future AddToFeed() async {
    List<ModelProduct> oldList = [];
    if (await session.readFeedSize() != null) oldList.addAll(await session.getFromFeed());
    oldList.add(widget.product);
    await session.AddToFeed(ModelProduct.encode(oldList));
    oldList.clear();
    Fluttertoast.showToast(msg: "Added to Saved page Successfully");
  }

  Future RemoveToFeed() async {
    List<ModelProduct> oldList = [];
    if (await session.readFeedSize() != null) oldList.addAll(await session.getFromFeed());
    oldList.remove(widget.product);
    await session.AddToFeed(ModelProduct.encode(oldList));
    oldList.clear();
    Fluttertoast.showToast(msg: "Remove Successfully");
  }

  Future AddToOffer() async {
    List<ModelProduct> oldList = [];
    if (await session.readOfferSize() != null) oldList.addAll(await session.getFromOffer());
    oldList.add(widget.product);
    await session.AddToOffer(ModelProduct.encode(oldList));
    oldList.clear();
  }

  Widget _MakeOfferOld() {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: height / 2,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppBar(
                    centerTitle: false,
                    title: Text(
                      'Make Offer',
                      style: TextStyle(color: Colors.black),
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  _OfferField(),
                  ElevatedButton(
                      child: const Text('Create Offer'),
                      onPressed: () => {
                            AddToOffer(),
                            Fluttertoast.showToast(msg: "Added to offer page Successfully"),
                            Navigator.pop(context),
                          })
                ],
              ),
            );
          },
        )
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blue, width: 1),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.white),
        child: Text(
          'Make Offer',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _MakeOffer() {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AddOfferPage(widget.product)))},
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blue, width: 1),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.white),
        child: Text(
          'Make Offer',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _AddToCartButton() {
    return InkWell(
      onTap: () => {AddTocart(), Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()))},
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blue, width: 1),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.white),
        child: Text(
          Languages.of(context).AddToCart,
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _Message() {
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()))},
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blue, width: 1),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.white),
        child: Text(
          'Message',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _OfferField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Make Your Offer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
            onSaved: (val) => {},
            validator: (value) => (value?.isNotEmpty ?? false) ? null : "Please enter a Offer",
          )
        ],
      ),
    );
  }

  Widget _product() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 220,
        child: FutureBuilder(
            future: api.getProduct(context),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelProduct> list = data.data as List<ModelProduct>? ?? [];
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Container(
                          width: 180,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            child: Card(
                              child: Column(
                                children: [
                                  FadeInImage(
                                    placeholder: AssetImage('images/logo.png'),
                                    image: NetworkImage(
                                      list[index].image,
                                    ),
                                    height: 100.0,
                                    width: 150.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index].name,
                                          softWrap: true,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          list[index].short_des,
                                          softWrap: true,
                                          maxLines: 2,
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
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(list[index])));
                            },
                          ));
                    });
              } else {
                return Container(child: CircularProgressIndicator());
              }
            }));
  }
}
