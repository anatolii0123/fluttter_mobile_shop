import 'package:cms_manhattan/src/Models/ModelMessage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class ChatPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ChatPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;
  RestDatasource api;
  _PageState(){
    api=new RestDatasource();
  }
  

  Widget _MessageLeft(ModelMessage data) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue,width: 1)
        ),
        margin: EdgeInsets.only(right: 100,top: 10,left: 10,bottom: 5),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey[200],
                      child: Image.network(data.image,width: 50,),
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
                            "Gil",
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

              },
            ));
  }
  Widget _MessageRight(ModelMessage data) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue,width: 1)
        ),
        margin: EdgeInsets.only(right: 10,top: 10,left: 100,bottom: 5),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "You",
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey[200],
                      child: Image.network(data.image,width: 50,),
                    ),

                  ],
                ),

              ),
              onTap: (){

              },
            ));
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Gil',style: TextStyle(
          color: Colors.black
      ),),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: [
        CircleAvatar(
          child: Image.asset('images/user.png', height: 40,),
        )
      ],
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
        appBar: _appBar(),
        body:Stack(
          children: [
            SingleChildScrollView(child:Column(
              children: [
                FutureBuilder(
                    future: api.getMessage(context),
                    builder: (context,data){
                      print(data);
                      if(data.hasData){
                        List<ModelMessage>list=data.data;
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Expanded(child:index%2==0?_MessageLeft(list[index]):_MessageRight(list[index]));
                          },
                        );
                      } else{
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )),
            _BottomField(),
          ],
        )
      ),
    );
  }
  Widget _BottomField() {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 4,
                child:
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true),
                  onSaved: (val) => {},
                  validator: (value) => value.isNotEmpty ? null : "Please enter a Message",
                )
            ),
            Expanded(
              flex: 1,
                child: IconButton(
                  icon: Icon(Icons.send,color: Colors.blue,),
                  onPressed: ()=>{

                  },
                )),

          ],
        ),
      ),
    );
  }
}
