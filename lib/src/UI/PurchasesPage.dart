import 'package:cms_manhattan/src/Models/ModelOrder.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/UI/OrderFeedbackPage.dart';
import 'package:cms_manhattan/src/UI/OrderTrackingPage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProductDetailsPage.dart';
class PurchasesPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PurchasesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;
  RestDatasource api;
  _PageState(){
    api=new RestDatasource();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body:Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Search(),
                  FutureBuilder(
                      future: api.getOrderHistory(context),
                      builder: (context,data){
                        if(data.hasData){
                          List<ModelOrder>list=data.data;
                          return Expanded(
                            child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: ()=>{
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage.set(list[index])))
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child:Card(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex:2,
                                                        child:  Text(
                                                          list[index].date,
                                                          maxLines: 2,
                                                          softWrap: true,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ), Expanded(
                                                        flex:3,
                                                        child:  Text(
                                                          "Order ID: ${list[index].order_id}",
                                                          maxLines: 2,
                                                          softWrap: true,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ), Expanded(
                                                        flex:3,
                                                        child:  Text(
                                                          "Payment ID: ${list[index].payment_id}",
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
                                                        image: NetworkImage(list[index].image,),
                                                        width: 100.0,
                                                        height: 80,
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Expanded(
                                                          child:Column(
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
                                                                list[index].description,
                                                                maxLines: 2,
                                                                softWrap: true,
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.normal,
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                ),
                                                              ),//*
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    list[index].price,
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
                                                          )
                                                      )

                                                    ],
                                                  ),
                                                  Padding(padding: EdgeInsets.all(5)),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex:1,
                                                        child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderTrackingPage()));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              margin: EdgeInsets.only(top: 5),
                                                              padding: EdgeInsets.symmetric(vertical: 5),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  border: Border.all(color: Colors.blue),
                                                                  boxShadow: <BoxShadow>[
                                                                    BoxShadow(
                                                                        color: Colors.grey.shade200,
                                                                        offset: Offset(2, 4),
                                                                        blurRadius: 5,
                                                                        spreadRadius: 2)
                                                                  ],
                                                                  color: Colors.white),
                                                              child: Text(
                                                                'Track Package',
                                                                style: TextStyle(fontSize: 14, color: Colors.blue),
                                                              ),
                                                            )),
                                                      ),
                                                      Padding(padding: EdgeInsets.all(5)),
                                                      Expanded(
                                                        flex:1,
                                                        child: InkWell(
                                                            onTap: () {
                                                              ModelOrder or=list[index];
                                                              ModelProduct pr=new ModelProduct(or.id, or.name, or.description, '1', or.price, or.cut_off, or.description, or.image, 5);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage.set(pr)));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              margin: EdgeInsets.only(top: 5),
                                                              padding: EdgeInsets.symmetric(vertical: 5),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  border: Border.all(color: Colors.blue),
                                                                  boxShadow: <BoxShadow>[
                                                                    BoxShadow(
                                                                        color: Colors.grey.shade200,
                                                                        offset: Offset(2, 4),
                                                                        blurRadius: 5,
                                                                        spreadRadius: 2)
                                                                  ],
                                                                  color: Colors.white),
                                                              child: Text(
                                                                'Buy Again',
                                                                style: TextStyle(fontSize: 14, color: Colors.blue),
                                                              ),
                                                            )),
                                                      ),
                                                      Padding(padding: EdgeInsets.all(5)),
                                                      Expanded(
                                                        flex:1,
                                                        child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderFeedbackPage()));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              margin: EdgeInsets.only(top: 5),
                                                              padding: EdgeInsets.symmetric(vertical: 5),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  border: Border.all(color: Colors.blue),
                                                                  color: Colors.white),
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
                                            )
                                        ),
                                      )
                                  );
                                }
                            ),
                          );
                        }else if(data.hasError){
                          return Column(
                            children: [
                              Image.asset('images/card_icon.png',width: 150,),
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
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }
                      }),

                ],
              ),
            )

          ],
        )
      ),
    );
  }
  Widget _Search(){
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 45,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[100]),
      margin: EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search,),
          Expanded(child: TextField(
            decoration: new InputDecoration(
              hintText: "Search by date, order id, name...",
              hintStyle: new TextStyle(color: Colors.black),
            ),
            minLines: 1,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black,
              backgroundColor: Colors.grey[100],
            ),
          ),)
        ],
      ),
    );

  }
}
