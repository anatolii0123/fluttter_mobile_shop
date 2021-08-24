import 'package:cms_manhattan/src/UI/HomePage.dart';
import 'package:cms_manhattan/src/UI/LoginPage.dart';
import 'package:cms_manhattan/src/UI/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class SuccessPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SuccessPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body:Stack(
          children: [
            Center(child: Image.asset("images/success.png",fit: BoxFit.fitWidth, width:width,)),
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Success',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                  Text('Your Order will be deliver soon.',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),),
                  Text('Thank you for choosing CMS App!',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                  _ButtonHome(),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
  Widget _ButtonHome() {
    return InkWell(
      onTap: () => {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()),(route)=>false)
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.blue),
        child: Text(
          "Continue Shopping",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

}
