import 'package:cms_manhattan/src/Models/ModelCart.dart';
import 'package:cms_manhattan/src/Models/ModelCategory.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/UI/PaymentPage.dart';
import 'package:cms_manhattan/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<CartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  RestDatasource api;
  double total = 0;
  double mTotal = 0;
  List<String> qty = ["1", "2", "3", "4", "5","6","7","8","9","10"];

  _PageState() {
    api = new RestDatasource();
  }

  Widget _appBar(dis) {
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
        body: Column(children: [
          FutureBuilder(
              future: api.getCart(context),
              builder: (context, data) {
                if (data.hasData) {
                  List<ModelCart> list = data.data;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _Cart(list[index]);
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          BottomAppBar(
            notchMargin: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Divider(color: Colors.grey,height: 2,),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(flex: 1,
                      child: Text('Items (10)',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),)
                      ),
                      Expanded(flex: 1,
                          child: Text('\$77541.57',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),)
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(flex: 1,
                      child: Text('Shipping',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),)
                      ),
                      Expanded(flex: 1,
                          child: Text('\$2000',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),)
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(flex: 1,
                      child: Text('Discount',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),)
                      ),
                      Expanded(flex: 1,
                          child: Text('\$20',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),)
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(color: Colors.grey,height: 2,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(flex: 1,
                      child: Text('Sub Total',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),)
                      ),
                      Expanded(flex: 1,
                          child: Text('\$80265.57',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18
                          ),)
                      ),
                    ],
                  ),
                  _submitButton(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _Cart(ModelCart product) {
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
                            child:Text(
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
                            child:PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                             itemBuilder: (context)=>[
                                PopupMenuItem(
                                  value: "onClick",
                                 child: Text('Pay only this seller'),
                               ),
                             ],
                              onSelected:(Str)=>{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()))
                              },
                            )
                        ),
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
                            onChanged: (String data) {
                              product.qty = data;
                            },
                            items: qty.map<DropdownMenuItem<String>>(
                                    (String value) {
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
                          child: Text(
                          'Save For later',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),),
                        Expanded(
                          flex: 1,
                          child: Text(
                          'Remove',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),)
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.blue),
          child: Text(
            'Go to checkout',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }


}
