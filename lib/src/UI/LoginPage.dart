import 'dart:convert';

import 'package:cms_manhattan/src/UI/HomePage.dart';
import 'package:cms_manhattan/src/UI/RegisterPage.dart';
import 'package:cms_manhattan/src/languages/Languages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final JsonDecoder _decoder = new JsonDecoder();
  String _password, _email;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  _LoginPageState() {

  }

  Widget _emailField(dis) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Languages.of(dis).Email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _email = val,
            validator: (value) => EmailValidator.validate(value) ? null : Languages.of(dis).EmailValidMessage,
          )
        ],
      ),
    );
  }
  Widget _passField(dis) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment:   CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Languages.of(dis).Password,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _password = val,
            validator: (val) {
              return val.length < 5 ?  Languages.of(dis).PasswordValidMessage : null;
            },
          )
        ],
      ),
    );
  }
  Future<void> saveData(context,user) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  Widget _submitButton(dis) {
    final form = _formKey.currentState;
    return InkWell(
      onTap: () => {
        if (form.validate())
          {
            setState(() {
              isLoading = true;
            }),
            form.save(),

          }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.blueGrey[200]),
        child: Text(
          Languages.of(dis).SignIn,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget(dis) {
    return Column(
      children: <Widget>[
        _emailField(dis),
        _passField(dis),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:20),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        Languages.of(context).labelWelcome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(key: _formKey, child: _emailPasswordWidget(context)),
                    SizedBox(
                      height: 20,
                    ),
                    isLoading ? CircularProgressIndicator() : _submitButton(context),
                    SizedBox(height:30),


                    TextButton(onPressed: ()=>{

                    },
                      child: Text(
                      Languages.of(context).ResetYourPassword,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    ),
                    TextButton(onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()))
                    },
                      child: Text(
                        Languages.of(context).CreateAnAccount,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(Languages.of(dis).SignIn,style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
      ),
      ),
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,//change your color here
      ),
      backgroundColor: Colors.white,
    );
  }
}
