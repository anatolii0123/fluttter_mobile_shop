import 'package:cms_manhattan_project/src/UI/LoginPage.dart';
import 'package:cms_manhattan_project/src/UI/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PostItemPage.dart';

class SellingPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SellingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;

  Widget _Message(index) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        // height: 250,
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/user.png",
                      width: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Admin',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hello, This is test message',
                          softWrap: true,
                          maxLines: 2,
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
                        Text(
                          "2021-01-19 01:15 PM",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {},
            )));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Notification List',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => PostItemPage()))},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        size: 40,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'To Create a listing, please list on the website',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      tileColor: Colors.blueGrey[100],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ButtonSignUp(),
                          SizedBox(
                            width: 20,
                          ),
                          _ButtonLogin(),
                        ],
                      ),
                    ),
                    Text(
                      'How it Works',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt_outlined, size: 60),
                      title: Text('List in minutes'),
                      subtitle: Text('Snap some photos and white a grate description. We will help you price your item to sell'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.featured_play_list, size: 60),
                      title: Text('Get paid quickly and safely'),
                      subtitle: Text('When your item sells, We make the payment process esey for you & the buyer.'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.local_offer, size: 60),
                      title: Text('Ship it to its new home'),
                      subtitle: Text('Box it up, print a label directly on ebay, and say farewell its that simple'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _ButtonLogin() {
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))},
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.blueAccent), color: Colors.white),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _ButtonSignUp() {
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))},
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.blueAccent), color: Colors.white),
        child: Text(
          "Register",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
}
