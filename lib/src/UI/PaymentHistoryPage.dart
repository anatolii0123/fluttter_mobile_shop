import 'package:cms_manhattan/src/Models/ModelPaymentHistory.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ProductDetailsPage.dart';
class PaymentHistoryPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PaymentHistoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;
  RestDatasource api;
  _PageState(){
    api=new RestDatasource();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                  FutureBuilder(
                      future: api.getPaymentHistory(context),
                      builder: (context,data){
                        if(data.hasData){
                          List<ModelPaymentHistory>list=data.data;
                          return Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
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
                                            child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.arrow_upward_outlined,color: Colors.blue,),
                                              SizedBox(width: 5,),
                                              Expanded(
                                                  child:Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        list[index].amount,
                                                        softWrap: true,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.amber,
                                                        ),
                                                      ),
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
                                                    ],
                                                  )
                                              ),
                                              Text(
                                                list[index].date,
                                                maxLines: 2,
                                                softWrap: true,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),)
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
}
