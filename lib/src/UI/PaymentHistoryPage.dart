import 'package:cms_manhattan_project/src/Models/ModelPaymentHistory.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ProductDetailsPage.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PaymentHistoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isSelectDate = false;
  late RestDatasource api;
  String searchText = "";
  _PageState() {
    api = new RestDatasource();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Search(),
                  FutureBuilder(
                      future: api.getPaymentHistory(context, searchText),
                      builder: (context, data) {
                        if (data.hasData) {
                          List<ModelPaymentHistory> list = data.data as List<ModelPaymentHistory>? ?? [];
                          return Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () => {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage.set(list[index])))
                                          },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Card(
                                            child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.arrow_upward_outlined,
                                                color: Colors.blue,
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
                                                  ), //*
                                                ],
                                              )),
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
                                          ),
                                        )),
                                      ));
                                }),
                          );
                        } else if (data.hasError) {
                          return Column(
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
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ],
          )),
    );
  }

  Widget _Search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 45,
      alignment: AlignmentDirectional.center,
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
                        searchText = text;
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
                    isSelectDate = false;
                  });
                } else {
                  _selectDate();
                }
              },
              icon: Icon(isSelectDate ? Icons.close : Icons.date_range_outlined))
        ],
      ),
    );
  }

  Future _selectDate() async {
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
        return;
      }
      setState(() {
        isSelectDate = true;
        final DateFormat formatter = DateFormat('M/d/yyyy');
        searchText = formatter.format(pickedDate);
      });
    });
  }
}
