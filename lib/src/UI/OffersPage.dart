import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class OffersPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<OffersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
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
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/user.png",width: 60,),
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
              onTap: (){

              },
            )));
  }

  Widget _appBar() {
    return TabBar(
      indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.blueGrey[200],
        tabs: [
          Tab(child: Text("Active",style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),),
          Tab(child: Text("Didn't win",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(  // Added
      length: 2,  // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _appBar(),
        body:TabBarView(
          children: [
            _Active(),
            _Active(),
          ],
        ),
      ),
    );
  }
  Widget _Active(){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/card_icon.png',width: 150,),
          Flexible(
            child: Text(
              "You Didn't have any bids",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.blueGrey[300],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  Widget _Sellers(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Save Sellers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              child: Text(
              "Save Sellers to quickly see what they're selling or collecting.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.blueGrey[300],
              ),
                textAlign: TextAlign.center,
            ),
            ),
            Image.asset("images/list.png")
          ],
        ),
    );
  }
  Widget _Feed(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Welcome to your feed",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              child: Text(
              "New item you save searches and sellers will show up here as soon they'er listed.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.blueGrey[300],
              ),
                textAlign: TextAlign.center,
            ),
            ),
            Image.asset("images/feed.png")
          ],
        ),
    );
  }
}
