import 'package:cms_manhattan_project/src/Models/ModelCart.dart';
import 'package:cms_manhattan_project/src/Models/ModelCharge.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/UI/PaymentPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<CartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  double total = 0;
  double mTotal = 0;
  List<String> qty = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List<ModelProduct> oldList = [];
  List<ModelProduct> oldSavedList = [];
  late RestDatasource api;
  late SessionManager session;
  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }
  Future Remove(value) async {
    oldList.remove(value);
    if (oldList.isNotEmpty) {
      await session.AddToCart(ModelProduct.encode(oldList));
    } else {
      await session.remove("cart");
    }
    setState(() {});
  }

  Future SaveForLater(value) async {
    List<ModelProduct> saved = [];
    if (await session.readSavedSize() != null) {
      saved.addAll(await session.getFromSaved());
    }
    saved.add(value);
    await session.AddToSaved(ModelProduct.encode(saved));
    saved.clear();
    oldList.remove(value);
    if (oldList.isNotEmpty) {
      await session.AddToCart(ModelProduct.encode(oldList));
    } else {
      await session.remove("cart");
    }
    setState(() {});
  }

  Future RemoveSaved(value) async {
    oldSavedList.remove(value);
    if (oldSavedList.isNotEmpty) {
      await session.AddToSaved(ModelProduct.encode(oldSavedList));
    } else {
      await session.remove("saved");
    }
    setState(() {});
  }

  Future AddTocart(value) async {
    List<ModelProduct> oldList = [];
    if (await session.readCartSize() != null) oldList.addAll(await session.getFromCart());
    oldList.add(value);
    await session.AddToCart(ModelProduct.encode(oldList));
    oldList.clear();
    RemoveSaved(value);
  }

  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        Languages.of(dis).Cart,
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
        appBar: _appBar(context),
        body: ListView(
          shrinkWrap: false,
          children: [
            FutureBuilder(
                future: session.getFromCart(),
                builder: (context, data) {
                  print('Cart ${data.hasError}');
                  if (data.hasData) {
                    oldList = data.data as List<ModelProduct>? ?? [];
                    return ListView.builder(
                        itemCount: oldList.length,
                        shrinkWrap: true,
                        primary: false,
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
                                                    onSelected: (Str) =>
                                                        {Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()))},
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
                                                      product.qty = data!;
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
                                                    'Save For later',
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    SaveForLater(product);
                                                    Fluttertoast.showToast(msg: "Saved item Successfully");
                                                  },
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
                        });
                  } else if (data.hasError) {
                    return Container(
                      height: 350,
                      child: Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                            child: Text(
                              "Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "Save Cart to quickly see what they're selling or collecting.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.blueGrey[300],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image.asset(
                            "images/list.png",
                            height: 200,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            _Saved(),
            FutureBuilder(
                future: api.getTotalCart(context),
                builder: (context, data) {
                  if (data.hasData) {
                    ModelCharge charge = data.data as ModelCharge;
                    return BottomAppBar(
                      notchMargin: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Items (${charge.item_count})',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '\$ ${charge.total}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Shipping',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '\$ ${charge.shipping}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Discount',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '\$ ${charge.discount}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Sub Total',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.black, fontSize: 18),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '\$ ${charge.sub_total}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                    )),
                              ],
                            ),
                            _submitButton(),
                          ],
                        ),
                      ),
                    );
                  } else if (data.hasError) {
                    return SizedBox(
                      height: 5,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.blue),
          child: Text(
            'Go to checkout',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _Saved() {
    return FutureBuilder(
        future: session.getFromSaved(),
        builder: (context, data) {
          if (data.hasData) {
            oldSavedList = data.data as List<ModelProduct>? ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Saved for later (${oldSavedList.length})',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: oldSavedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ModelProduct product = oldSavedList[index];
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
                                                onSelected: (Str) =>
                                                    {Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()))},
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
                                                  product.qty = data!;
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
                                                'Add To Cart',
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              onPressed: () => {AddTocart(product)},
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
                                                  RemoveSaved(product);
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
                    })
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
