import 'package:cms_manhattan/src/Models/ModelMessage.dart';
import 'package:cms_manhattan/src/UI/ChatPage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class MessagePage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MessagePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;
  RestDatasource api;
  _PageState(){
    api=new RestDatasource();
  }
  

  Widget _Message(ModelMessage data) {
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
                    FadeInImage(
                      placeholder: AssetImage('images/logo.png'),
                      image: NetworkImage(data.image,),
                      width: 50.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
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
                            data.message,
                            softWrap: true,
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
                            data.date,
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
                    )


                  ],
                ),

              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
              },
            )));
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Notification List',style: TextStyle(
          color: Colors.black
      ),),
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
        key: _scaffoldKey,
          backgroundColor: Colors.white,
        body:Container(
          child: FutureBuilder(
            future: api.getMessage(context),
            builder: (context,data){
              print(data);
             if(data.hasData){
               List<ModelMessage>list=data.data;
               return ListView.builder(
                 scrollDirection: Axis.vertical,
                 itemCount: list.length,
                 itemBuilder: (context, index) {
                   return _Message(list[index]);
                 },
               );
             } else{
               return Center(child: CircularProgressIndicator());
             }
            }
          ),
        )
      ),
    );
  }
}
