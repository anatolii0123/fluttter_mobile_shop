import 'package:cms_manhattan_project/src/Models/ModelMessage.dart';
import 'package:cms_manhattan_project/src/UI/ChatPage.dart';
import 'package:cms_manhattan_project/src/UI/MessageDetailsPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MessagePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  late RestDatasource api;
  int value = 1;
  String valuetxt = 'All Messages';
  _PageState() {
    api = new RestDatasource();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage(
                      placeholder: AssetImage('images/logo.png'),
                      image: NetworkImage(
                        data.image,
                      ),
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailsPage()));
              },
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
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: TextButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return Filter();
                      },
                    ),
                    child: Text(
                      'Filter: $valuetxt',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue),
                    ),
                  )),
              Expanded(
                  child: FutureBuilder(
                      future: api.getMessage(context),
                      builder: (context, data) {
                        if (data.hasData) {
                          List<ModelMessage> list = data.data as List<ModelMessage>? ?? [];
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return _Message(list[index]);
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }))
            ],
          )),
    );
  }

  Widget Filter() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 480,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter By',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 1, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(1, 'All Messages'),
                  child: Text(
                    'All Messages',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 2, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(2, 'Unread'),
                  child: Text(
                    'Unread',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 3, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(3, 'Flagged'),
                  child: Text(
                    'Flagged',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 4, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(4, 'From CMS'),
                  child: Text(
                    'From CMS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 5, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(5, 'From Members'),
                  child: Text(
                    'From Members',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(value: value, groupValue: 6, onChanged: onChanged),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => onChangedVal(6, 'High priority'),
                  child: Text(
                    'High priority',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void onChanged(v) {
    setState(() {
      value = v;
    });
    Navigator.pop(context);
  }

  void onChangedVal(v, txt) {
    setState(() {
      value = v;
      valuetxt = txt;
    });
    Navigator.pop(context);
  }
}
