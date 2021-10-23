import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelCharge.dart';
import 'package:cms_manhattan_project/src/Models/ModelOrder.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/UI/AddressPage.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

import 'OrderTrackingPage.dart';

class PaymentDetailsPage extends StatefulWidget {
  ModelOrder order;
  @override
  _PageState createState() => _PageState();
  PaymentDetailsPage.set(this.order);
}

class _PageState extends State<PaymentDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late RestDatasource api;
  int _radioValue1 = -1;
  _PageState() {
    api = new RestDatasource();
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text('Payment details', style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Card(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      FadeInImage(
                        placeholder: AssetImage('images/logo.png'),
                        image: NetworkImage(
                          widget.order.image,
                        ),
                        width: width,
                        height: 200,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.order.name,
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
                      Text(
                        widget.order.description,
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
                      Row(
                        children: [
                          Text(
                            widget.order.price,
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
                            widget.order.cut_off,
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
                      Padding(padding: EdgeInsets.all(5)),
                    ],
                  ),
                )),
              ),
              Container(
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
                              'Order Date',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ' ${widget.order.date}',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Order ID',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              '${widget.order.order_id}',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Payment ID',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ' ${widget.order.payment_id}',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Items (1)',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              '\$ ${widget.order.price}',
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
                              '\$ 10',
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
                              '\$ ${widget.order.cut_off}',
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
                              '\$ ${widget.order.price}',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                            )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingPage.setOrder(widget.order)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
                              color: Colors.blue),
                          child: Text(
                            'Shipping',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        )),
                    Padding(padding: EdgeInsets.all(5)),
                    InkWell(
                        onTap: () {
                          ModelOrder or = widget.order;
                          ModelProduct pr =
                              new ModelProduct(or.id, or.name, or.description, '1', or.price, or.cut_off, or.description, or.image, 5, "Seller", "2");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(pr)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.blue),
                              boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
                              color: Colors.white),
                          child: Text(
                            'Reorder',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        )),
                    Padding(padding: EdgeInsets.all(5)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
