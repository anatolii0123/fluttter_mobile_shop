import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOfferPage extends StatefulWidget {
  ModelProduct product;
  @override
  _PageState createState() => _PageState();
  AddOfferPage(this.product);
}

class _PageState extends State<AddOfferPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late RestDatasource api;
  late SessionManager session;
  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }
  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.product.price,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Your Offer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "0",
                    prefix: Text(
                      '\$',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Increase your Offer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                _submitButton(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
    );
  }

  Future AddToOffer() async {
    List<ModelProduct> oldList = [];
    if (await session.readOfferSize() != null) oldList.addAll(await session.getFromOffer());
    oldList.add(widget.product);
    await session.AddToOffer(ModelProduct.encode(oldList));
    Navigator.pop(context);
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () => {
        AddToOffer(),
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.blue),
        child: Text(
          'REVIEW OFFER',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
