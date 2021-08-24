import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class SearchPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text("Search");
  Icon actionIcon = new Icon(Icons.search);
  Widget _appBar() {
    return TabBar(
      indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.blueGrey[200],
        tabs: [
          Tab(child: Text("RECENT",style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),),),
          Tab(child: Text("SAVED",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),),),
        ],
      );
  }
  Widget _SearchappBar() {
    return AppBar(
        centerTitle: true,
        title:appBarTitle,
        backgroundColor: Colors.white,
        bottom: _appBar(),
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5.0),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[100]),
            margin: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
                        onPressed: ()=>{
                  Navigator.pop(context)})),
                Expanded(
                  flex: 3,
                  child: Container(
                  width: MediaQuery.of(context).size.width * 0.66,
                  margin: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: TextField(
                    decoration: new InputDecoration(
                      hintText: "Search for a...",
                      hintStyle: new TextStyle(color: Colors.blue),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black,
                        backgroundColor: Colors.grey[100]
                    ),
                  ),
                ),),
                Expanded(
                  flex: 1,
                  child: Row(
                  children: [
                    Icon(Icons.mic_outlined,color: Colors.grey[400],),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.camera_alt_outlined,color: Colors.grey[400],)
                  ],
                ),)
              ],
            ),
          ),
        ]
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
        appBar: _SearchappBar(),
        body:TabBarView(
          children: [
            _Resent(),
            _Searches(),
          ],
        ),
      ),
    );
  }
  Widget _Searches(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Save Searches",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "Save a search to update when new item are listed that match your criteria.",
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
      )
    );
  }
  Widget _Resent(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Recent Searches",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "Save a search to update when new item are listed that match your criteria.",
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
      )
    );
  }

}
